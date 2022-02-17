import 'dart:async';
import 'dart:io';

import 'package:arbo/app/modules/core/controllers/app_store.dart';
import 'package:arbo/app/modules/core/models/arvore.dart';
import 'package:arbo/app/modules/core/models/endereco.dart';
import 'package:arbo/app/modules/core/models/info_usuario.dart';
import 'package:arbo/app/modules/core/repositories/arvores_repository.dart';
import 'package:arbo/app/modules/core/repositories/images_repository.dart';
import 'package:arbo/app/modules/maptree/views/month_picker_dialog.dart';
import 'package:arbo/app/modules/start/controllers/start_store.dart';
import 'package:arbo/app/shared/components/progress_dialog.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';
import 'package:utils/utils/geofireutils/point.dart';
import 'package:utils/utils/util/location_utils.dart';
import 'package:utils/utils/util/utils.dart';

part 'maptree_store.g.dart';

class MapTreeStore = _MapTreeStoreBase with _$MapTreeStore;

abstract class _MapTreeStoreBase with Store implements Disposable {
  final StartStore startStore = Modular.get<StartStore>();
  final AppStore appStore = Modular.get<AppStore>();
  final _treeRepository = ArvoresRepository();
  final _imagesRepository = ImagesRepository();

  Completer<GoogleMapController> controllerMap = Completer();
  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(-14.36, -47.63),
    zoom: 4,
  );
  Coordinates? currentLocation;

  _MapTreeStoreBase() {
    ///Localização atual
    getMyLocation().then((value) {
      loadMap();
      updateMarkers();
    });
  }

  ///Atributos
  @observable
  File? imageFile;
  @observable
  String name = "", description = "";
  @observable
  bool producing = false;
  @observable
  int? monthStart, monthEnd;
  @observable
  String? monthStartName, monthEndName;

  @action
  setProperty({
    File? image,
    String? name,
    String? description,
    bool? producing,
    int? monthStart,
    int? monthEnd,
    String? monthStartName,
    String? monthEndName,
  }) {
    if (image != null) this.imageFile = image;

    if (name != null) this.name = name;
    if (description != null) this.description = description;

    if (producing != null) this.producing = producing;
    if (monthStart != null) this.monthStart = monthStart;
    if (monthEnd != null) this.monthEnd = monthEnd;

    if (monthEndName != null) this.monthEndName = monthEndName;
    if (monthStartName != null) this.monthStartName = monthStartName;
  }

  @override
  void dispose() {}

  Future getMyLocation() {
    return LocationUtils.currentLatLong.then((value) {
      currentLocation = Coordinates(value.latitude, value.longitude);
      updateMarkers();
    });
  }

  loadMap() {
    ///Carrega o mapa
    controllerMap.future.then((controller) {
/*      LocationUtils.carregarMapStyle().then((value) {
        controller.setMapStyle(value);
      });*/

      if (currentLocation != null)
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                currentLocation!.latitude,
                currentLocation!.longitude,
              ),
              zoom: 15,
            ),
          ),
        );
    });
  }

  @observable
  Set<Marker>? markers;

  @action
  updateMarkers() async {
    final markers = <MarkerId, Marker>{};

    ///Marker localização atual
    if (currentLocation != null) {
      var bitmapDesc = await Utils.bytesFromIcon(Icons.location_on);
      final Marker markerEstabelecimento = Marker(
        icon: BitmapDescriptor.fromBytes(bitmapDesc),
        markerId: MarkerId("myLocation"),
        position: LatLng(
          currentLocation!.latitude,
          currentLocation!.longitude,
        ),
      );
      markers[MarkerId("myLocation")] = markerEstabelecimento;
    }

    this.markers = Set<Marker>.of(markers.values);
  }

  void toggleShowingTabBar() => startStore.toggleShowingTabBar();

  @computed
  get showingTabBar => startStore.showingTabBar;

  @computed
  bool get fieldsFill {
    if (name.isEmpty) return false;
    if (description.isEmpty) return false;
    /*if (monthStart == null) return false;
    if (monthEnd == null) return false;*/
    if (imageFile == null) return false;

    return true;
  }

  void chooseImage() async {
    var image = await ImagePicker()
        .getImage(maxHeight: 916, maxWidth: 916, source: ImageSource.gallery, imageQuality: 70);

    if (image != null) setProperty(image: File(image.path));
  }

  pickerMonthStart(BuildContext context) async {
    dynamic month = await showDialog(
      context: context,
      builder: (context) => MonthPickerDialog(),
    );

    setProperty(monthStart: month["index"], monthStartName: month["name"]);
  }

  pickerMonthEnd(BuildContext context) async {
    dynamic month = await showDialog(
      context: context,
      builder: (context) => MonthPickerDialog(),
    );

    setProperty(monthEnd: month["index"], monthEndName: month["name"]);
  }

  void save(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) => ProgressDialog(title: S.to.aguarde),
      useRootNavigator: true,
    );

    var a =
        (await LocationUtils.getAddresFromLatLong(currentLocation!.latitude, currentLocation!.longitude))[0];

    final geohash = GeoFirePoint(currentLocation!.latitude, currentLocation!.longitude).hash;
    final infoUsuario = InfoUsuario(
      id: appStore.currentUsuario!.id,
      nome: appStore.currentUsuario!.pessoa.nomeSobrenome,
      tipoUsuario: appStore.currentUsuario!.tipoUsuario,
      celular: appStore.currentUsuario!.pessoa.celular,
    );
    final address = Endereco(
      estado: a.adminArea.replaceAll("State of ", ""),
      endereco: a.thoroughfare,
      numero: a.subThoroughfare,
      cep: a.postalCode,
      cidade: a.subAdminArea,
      point: Point(
        geohash: geohash,
        geopoint: GeoPoint(currentLocation!.latitude, currentLocation!.longitude),
      ),
    );
    final id = _treeRepository.getNextIdTree();
    final image = await _imagesRepository.uploadImagem("arvores/$id/image", fileImagem: this.imageFile!);

    List<int> mesesProducao = [];
    if(monthStart != null)
      mesesProducao.add(monthStart!);
    if(monthEnd != null)
      mesesProducao.add(monthEnd!);

    var tree = Arvore(
      id: id,
      infoUsuario: infoUsuario,
      nome: name,
      descricao: description,
      produzindo: producing,
      endereco: address,
      imagem: image,
      mesesProducao: mesesProducao,
    );
    await _treeRepository
        .createTree(tree)
        .then((value) => Modular.to.pop(context))
        .catchError((error) => Modular.to.pop(context));

    startStore.switchTab(StartIndexs.HOME_INDEX);
  }
}

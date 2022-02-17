import 'dart:async';

import 'package:arbo/app/modules/core/models/arvore.dart';
import 'package:arbo/app/modules/core/repositories/arvores_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobx/mobx.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';
import 'package:utils/utils/constants/colors.dart';

import '../views/widgets/tree_modal.dart';

part 'map_home_store.g.dart';

class MapHomeStore = _MapHomeStoreBase with _$MapHomeStore;

abstract class _MapHomeStoreBase with Store implements Disposable {
  Completer<GoogleMapController> controllerMap = Completer();
  final CameraPosition cameraPosition = CameraPosition(
    target: LatLng(-14.36, -47.63),
    zoom: 4,
  );
  Coordinates? currentLatLong;
  final _repository = ArvoresRepository();
  List<Arvore>? trees;
  late BuildContext context;

  _MapHomeStoreBase() {
    getMyLocation().then((value) => loadMap()).then((value) {
      _repository.getTreesInLocation(currentLatLong!, radius: 1000).listen((event) {
        trees = event;
        updateMarkers();
      });
    }).catchError((err){
      print(err);
    });
  }

  Future getMyLocation() {
    return LocationUtils.currentLatLong.then((value) {
      currentLatLong = Coordinates(value.latitude, value.longitude);
      getTreesInLocation();
      updateMarkers();
    }).catchError((err) {
      print(err);
    });
  }

  loadMap() {
    ///Carrega o mapa
    controllerMap.future.then((controller) {
/*      LocationUtils.carregarMapStyle().then((value) {
        controller.setMapStyle(value);
      });*/

      if (currentLatLong != null)
        controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                currentLatLong!.latitude,
                currentLatLong!.longitude,
              ),
              zoom: 14.5,
            ),
          ),
        );
    }).catchError((err) {
      print(err);
    });
  }

  @override
  void dispose() {

  }

  @observable
  Set<Marker>? markers;

  @action
  updateMarkers() async {

    final markers = <MarkerId, Marker>{};

    double size = Responsive.to.isPortrair ? Responsive.to.heightWithoutPaddind*0.1 : Responsive.to.widthWithoutPaddind*0.1;
    if(size>72)
      size = 72;

    //Toast.show("Size: $size\nheight: ${Responsive.to.height}\nwidth: ${Responsive.to.width}", context, duration: 10);

    ///Marker localização atual
    if (currentLatLong != null) {
      var bitmapDesc = await Utils.bytesFromIcon(
        Icons.location_history,
        size: size,
      );
      final Marker markerEstabelecimento = Marker(
        icon: BitmapDescriptor.fromBytes(bitmapDesc),
        markerId: MarkerId("myLocation"),
        position: LatLng(
          currentLatLong!.latitude,
          currentLatLong!.longitude,
        ),
      );
      markers[MarkerId("myLocation")] = markerEstabelecimento;
    }

    ///Marker das árvores
    if (trees != null && trees!.isNotEmpty)
      for (var tree in trees!) {
        var bitmapDesc = await Utils.bytesFromIcon(
          Icons.location_on,
          size: size,
          color: tree.produzindo ? ColorsConfig.primaryColor : ColorsConfig.accentColor,
        );
        final Marker markerTree = Marker(
          flat: true,
          icon: BitmapDescriptor.fromBytes(bitmapDesc),
          markerId: MarkerId(tree.id),
          position: LatLng(
            tree.endereco.point!.geopoint.latitude,
            tree.endereco.point!.geopoint.longitude,
          ),
          onTap: () => showBottomShetTree(tree),
        );
        markers[MarkerId(tree.id)] = markerTree;
      }

    this.markers = Set<Marker>.of(markers.values);
  }

  getTreesInLocation() async {}

  showBottomShetTree(Arvore tree) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        useRootNavigator: true,
        enableDrag: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
          ),
        ),
        builder: (builder) {
          return TreeModal(
            tree: tree,
          );
        });
  }
}

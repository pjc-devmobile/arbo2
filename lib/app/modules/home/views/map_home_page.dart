import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:utils/utils.dart';
import 'package:arbo/app/shared/responsive_values.dart';

import 'package:arbo/app/shared/responsive_values.dart';
import 'package:arbo/l10n/app_localization.dart';
import 'package:utils/utils/constants/colors.dart';
import '../controllers/map_home_store.dart';

class MapHomePage extends StatefulWidget {
  @override
  _MapHomePageState createState() => _MapHomePageState();
}

class _MapHomePageState extends ModularState<MapHomePage, MapHomeStore> {
  @override
  Widget build(BuildContext context) {    controller.context = context;

    return Container(
      width: Responsive.to.width,
      height: Responsive.to.height*2,
      color: ColorsConfig.grey.withOpacity(0.3),
      child: Observer(
        builder: (_) {
          return controller.markers == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: controller.cameraPosition,
                  onMapCreated: (GoogleMapController gmController) {
                    controller.controllerMap.complete(gmController);
                  },
                  markers: controller.markers!,
                );
        },
      ),
    );
  }
}

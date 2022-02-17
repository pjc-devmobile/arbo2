import 'dart:math';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:google_maps_webservice/geocoding.dart' as googleMapsWebService;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
//import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_place/google_place.dart' as place;
import 'package:location/location.dart';
import 'package:utils/utils/constants/constants.dart';
import 'package:location_permissions/location_permissions.dart' as locPermissions;

class LocationUtils {

  static Future<bool> get temPermissaoLocalizacao async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled)
        return false;
    }

    _permissionGranted = await location.hasPermission();
    bool openSystem = false;
    if (_permissionGranted == PermissionStatus.denied || _permissionGranted == PermissionStatus.deniedForever) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted == PermissionStatus.deniedForever)
        openSystem = await locPermissions.LocationPermissions().openAppSettings();

      if (openSystem)
        _permissionGranted = await location.hasPermission();
    }

    return (_permissionGranted == PermissionStatus.granted || _permissionGranted == PermissionStatus.grantedLimited);
  }

  static Future<List<Address>> get ativarGpsPegarLocalizacao async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw PermissionStatus.denied;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw PermissionStatus.denied;
      }
    }

    _locationData = await location.getLocation();
    Coordinates coordin = Coordinates(_locationData.latitude, _locationData.longitude);

    if (kIsWeb) {
      final geocoding = new googleMapsWebService.GoogleMapsGeocoding(apiKey: Constants.MAP_API_KEY);
      return await geocoding
          .searchByLocation(googleMapsWebService.Location(lat: coordin.latitude, lng: coordin.longitude))
          .then((value) {
            List<Address> addres = [];
            for (var d in value.results)
              addres.add(
                Address.fromMap(
                  _convertAddress(d.toJson()),
                ),
              );

        return addres;
      });
    }
    return await Geocoder.local.findAddressesFromCoordinates(coordin);
  }

  static Future<Coordinates> get currentLatLong async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        throw PermissionStatus.denied;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        throw PermissionStatus.denied;
      }
    }

    _locationData = await location.getLocation();
    Coordinates coordinates = Coordinates(_locationData.latitude, _locationData.longitude);
    return coordinates;
  }

  static Future<List<Address>> getAddresFromLatLong(double lat, double lon) async {
    return await Geocoder.local.findAddressesFromCoordinates(Coordinates(lat, lon));
  }

  static Future<List<Address>> pesquisarEnderecos(String pesquisa) async {
    if (kIsWeb) {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'utils-getDataFromUrl',
      );
      return callable.call({
        'url': "https://maps.googleapis.com/maps/api/geocode/json?address=${pesquisa.replaceAll(" ", "+")}&key=${Constants.MAP_API_KEY}",
      }).then((value) {
        List<Address> addres = [];
        for (var d in value.data["results"]) addres.add(Address.fromMap(_convertAddress(d)));

        return addres;
      }).catchError((err){
        print(err);
      });
    }

    return await Geocoder.google(Constants.MAP_API_KEY)
        .findAddressesFromQuery(pesquisa)
        .catchError((err) {
          print(err);
      });
  }

  static Map? _convertCoordinates(dynamic geometry) {
    if (geometry == null) return null;

    var location = geometry["location"];
    if (location == null) return null;
    if(!(location is Map))
      location = location.toJson();

    return {
      "latitude": location["lat"],
      "longitude": location["lng"],
    };
  }

  static Map _convertAddress(dynamic data) {
    Map result = Map();

    result["coordinates"] = _convertCoordinates(data["geometry"] is Map ? data["geometry"] : data["geometry"].toJson());
    result["addressLine"] = data["formatted_address"];

    var addressComponents = data["address_components"];

    addressComponents.forEach((item) {
      if (!(item is Map)) item = item.toJson();
      List types = item["types"];

      if (types.contains("route")) {
        result["thoroughfare"] = item["long_name"];
      } else if (types.contains("street_number")) {
        result["subThoroughfare"] = item["long_name"];
      } else if (types.contains("country")) {
        result["countryName"] = item["long_name"];
        result["countryCode"] = item["short_name"];
      } else if (types.contains("locality")) {
        result["locality"] = item["long_name"];
      } else if (types.contains("postal_code")) {
        result["postalCode"] = item["long_name"];
      } else if (types.contains("postal_code")) {
        result["postalCode"] = item["long_name"];
      } else if (types.contains("administrative_area_level_1")) {
        result["adminArea"] = item["long_name"];
      } else if (types.contains("administrative_area_level_2")) {
        result["subAdminArea"] = item["long_name"];
      } else if (types.contains("sublocality") || types.contains("sublocality_level_1")) {
        result["subLocality"] = item["long_name"];
      } else if (types.contains("premise")) {
        result["featureName"] = item["long_name"];
      }

      result["featureName"] = result["featureName"] ?? result["addressLine"];
    });

    return result;
  }

  static Future<List<place.AutocompletePrediction>?> autocompleteEnderecos(String pesquisa, place.LatLon location, place.LatLon origin, int radius) async {
    if (kIsWeb) {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'utils-getDataFromUrl',
      );
      return callable.call({
        'url':
        "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$pesquisa&key=${Constants.MAP_API_KEY}&origin=${origin.latitude}%2C${origin.longitude}&location=${location.latitude}%2C${location.longitude}&radius=$radius&language=pt-br",
      }).then((value) {
        List<place.AutocompletePrediction> predictions = [];
        for (var d in value.data["predictions"])
          predictions.add(place.AutocompletePrediction(
            //id: d["place_id"],
            description: d["description"],
            //distanceMeters: d["place_id"],
            matchedSubstrings: d["matchedSubstrings"],
            placeId: d["place_id"],
            structuredFormatting: place.StructuredFormatting(
              mainText: d["structured_formatting"]["main_text"],
              secondaryText: d["structured_formatting"]["secondary_text"],
            ),
            //terms: d["terms"],
            //types: d["types"],
            reference: d["reference"],
          ));
        return predictions;
      });
    } else {
      var googlePlace = place.GooglePlace(Constants.MAP_API_KEY);
      var result = await googlePlace.autocomplete
          .get(pesquisa, location: location, origin: origin, radius: radius, language: "pt-br");
      return result == null ? [] : result.predictions;
    }
  }

  static Future<Coordinates?> getLatLngFromAddres(String address) async {
    var addresses = await Geocoder.google(Constants.MAP_API_KEY).findAddressesFromQuery(address);

    if (address.isNotEmpty)
      return addresses[0].coordinates;
    else
      return null;
  }

  ///Km
 /* static Future<double> distanciaRotaEntrePosicoes(LatLng origem, LatLng destino) async {
    final polyline = GoogleMapPolyline(apiKey: Constants.MAP_API_KEY);
    List<LatLng> latLngs;
    if (kIsWeb) {
      HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
        'utils-getDataFromUrl',
      );
      var url =
          "https://maps.googleapis.com/maps/api/directions/json?mode=${RouteMode.driving}&key=${Constants.MAP_API_KEY}&origin=${origem.latitude},${origem.longitude}&destination=${destino.latitude},${destino.longitude}";
      latLngs = await callable.call({
        'url': url,
      }).then((value) {
        latLngs = _decodeEncodedPolyline(value.data['routes'][0]['overview_polyline']['points']);
        return latLngs;
      }).catchError((err) {
        print(err);
      });
    } else {
      latLngs = await polyline.getCoordinatesWithLocation(
        origin: origem,
        destination: destino,
        mode: RouteMode.driving,
      );
    }

    ///Extrai distancia
    double distancia = 0;
    LatLng current = latLngs.first;
    for (int i = 1; i < latLngs.length; i++) {
      distancia += distanceFromCoordinates(
        coordinates1: Coordinates(current.latitude, current.longitude),
        coordinates2: Coordinates(latLngs[i].latitude, latLngs[i].longitude),
      );
      current = latLngs[i];
    }

    return distancia;
  }
*/
  static List<LatLng> _decodeEncodedPolyline(String encoded) {
    List<LatLng> poly = [];
    int index = 0, len = encoded.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;
      LatLng p = new LatLng((lat / 1E5).toDouble(), (lng / 1E5).toDouble());
      poly.add(p);
    }
    return poly;
  }

  ///km
  static double distanceFromCoordinates({required Coordinates coordinates1, required Coordinates coordinates2}) {
    double lat1 = coordinates1.latitude, lon1 = coordinates1.longitude;
    double lat2 = coordinates2.latitude, lon2 = coordinates2.longitude;

    double theta = lon1 - lon2;
    double dist = sin(_deg2rad(lat1)) * sin(_deg2rad(lat2)) +
        cos(_deg2rad(lat1)) * cos(_deg2rad(lat2)) * cos(_deg2rad(theta));
    dist = acos(dist);
    dist = _rad2deg(dist);
    dist = dist * 60 * 1.1515;

    dist = dist * 1.609344;
    return double.parse(dist.toStringAsFixed(2));
  }

  static double _deg2rad(double deg) {
    return (deg * pi / 180.0);
  }

  static double _rad2deg(double rad) {
    return (rad * 180.0 / pi);
  }

  static Future<String> carregarMapStyle() async {
    var value = await rootBundle.loadString('assets/jsons/map_style.json');

    return value;
  }
}

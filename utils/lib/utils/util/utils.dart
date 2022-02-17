import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as material;
import 'package:flutter/services.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/colors.dart';

class Utils {
  static final _dateFormatter = new DateFormat('dd/MM/yyyy');
  static final _hourFormatter = new DateFormat('HH:mm');
  static final _dateFormatterMesAno = new DateFormat('MMMM y', "pt_BR");
  static final _dateFormatterDiaMes = new DateFormat('dd EEEE', "pt_BR");

  static bool emailIsValid(String email) {
    bool emailValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
    return emailValid;
  }

  static launchURL(String url) async {
    if (!url.startsWith("http")) url = "https://" + url;

    await launch(url);
  }

  static String formatarPreco(dynamic preco, {int casasDecimais = 2}) {
    String? precoStr = preco == null ? null : preco.toString();

    if (precoStr != null) precoStr = precoStr.replaceAll(",", ".");

    final numberFormat = NumberFormat.currency(locale: "pt_br", decimalDigits: casasDecimais, symbol: "");
    if (precoStr == null) return numberFormat.format(0);

    return numberFormat.format(double.parse(precoStr.toString())).trim();
  }

  static String formatarData(DateTime data) {
    return _dateFormatter.format(data);
  }

  static String formatarDataMesAno(DateTime data) {
    return _dateFormatterMesAno.format(data);
  }

  static String formatarDataDiaMes(DateTime data) {
    return _dateFormatterDiaMes.format(data);
  }

  static String formatarCelular(String celular) {
    if (celular == null) return "-";

    if (celular.startsWith("+55")) celular = celular.replaceAll("+55", "");

    if (!celular.startsWith("(")) celular = "(" + celular.substring(0, 2) + ") " + celular.substring(2);

    celular = celular.substring(0, celular.length - 4) + "-" + celular.substring(celular.length - 4);

    return celular.replaceAll("--", "-");
  }

  static formatarHora(DateTime data) {
    return _hourFormatter.format(data);
  }

  static formatarDataHorario(DateTime data) {
    DateTime now = DateTime.now();

    if (data.day == now.day && now.month == data.month && data.year == now.year)
      return formatarHora(data);
    else if (data.year == now.year)
      return formatarData(data).substring(0, 5) + " " + formatarHora(data);
    else
      return formatarData(data) + " " + formatarHora(data);
  }

  static DateTime criarData(data) {
    return _dateFormatter.parse(data);
  }

  static Future<File> redimensionarImagem(File image) async {
    ImageProperties properties = await FlutterNativeImage.getImageProperties(image.path);
    File compressedFile = await FlutterNativeImage.compressImage(image.path,
        quality: 80, targetWidth: 200, targetHeight: (properties.height! * 200 / properties.width!).round());

    return compressedFile;

    /* Uint8List m = image.readAsBytesSync();

   await ui.instantiateImageCodec(m, targetHeight: 200, targetWidth: 200)
        .then((codec) {
           codec.getNextFrame().then((frameInfo) async {
             ui.Image i = frameInfo.image;

             ByteData bytes = await i.toByteData();
            image.writeAsBytes(bytes.buffer.asUint32List());
           return image;
      });
    });*/
  }

  static Future<Uint8List> bytesFromIcon(IconData iconData, {Color color = ColorsConfig.primaryColor, double size = 72}) async {
    ///Icon endereco
    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    final textPainter = TextPainter(textDirection: material.TextDirection.ltr);
    final iconStr = String.fromCharCode(iconData.codePoint);
    textPainter.text = TextSpan(
        text: iconStr,
        style: TextStyle(
          letterSpacing: 0.0,
          fontSize: size,
          fontFamily: iconData.fontFamily,
          color: color,
        ));
    textPainter.layout();
    textPainter.paint(canvas, Offset(0.0, 0.0));
    final picture = pictureRecorder.endRecording();
    final image = await picture.toImage(size.round(), size.round());
    final bytes = await image.toByteData(format: ImageByteFormat.png);

    return bytes!.buffer.asUint8List();
  }

  static Future<BitmapDescriptor> bitmapDescriptorFromAsset(String assets, {double height = 48, double width = 48}) async {
    return await BitmapDescriptor.fromAssetImage(
      ImageConfiguration(size: Size(width, height)),
      assets,
    );
  }

  static void esconderTeclado() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
  }

  static mostrarErroScaffold(
      {@required scaffoldKey, required String error, BuildContext? contextNavigatorPop}) {
    if (contextNavigatorPop != null) Navigator.pop(contextNavigatorPop);

    scaffoldKey.currentState.showSnackBar(SnackBar(
      backgroundColor: ColorsConfig.redDarktColor,
      content: Text(
        error,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ));
  }

  static Future<PackageInfo> getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo;
  }

  static void playRingtone({bool vibrate = true}) async {
    /*   FlutterRingtonePlayer.playNotification();
    if (vibrate) if (await Vibration.hasVibrator()) {
      Vibration.vibrate();
    }*/
  }
}

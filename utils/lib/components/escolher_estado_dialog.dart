import 'package:flutter/material.dart';
import 'package:utils/utils/constants/colors.dart';
import 'package:utils/utils/util/estado_cidades_utils.dart';

class EscolheEstadoDialog extends StatefulWidget {
  final estadosCidades;
  final titulo;

  const EscolheEstadoDialog({this.estadosCidades, this.titulo});

  @override
  _EscolheEstadoDialogState createState() => _EscolheEstadoDialogState();
}

class _EscolheEstadoDialogState extends State<EscolheEstadoDialog> {

  @override
  Widget build(BuildContext context) {

    return AlertDialog(
      title: Text(widget.titulo),
      content: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: _listEstados(widget.estadosCidades),
      ),
    );
  }

  Widget _listEstados(List<EstadoCidadesUtils> estadosCidades) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: estadosCidades.length,
      itemBuilder: (context, index) {
        EstadoCidadesUtils item = estadosCidades[index];

        return FlatButton(
          onPressed: () => _escolherEstado(item),
          child: Container(
            padding: EdgeInsets.all(8),
            width: double.maxFinite,
            child: Text(
              item.nome,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorsConfig.primaryColor),
              textAlign: TextAlign.left,
            ),
          ),
        );
      },
    );
  }

  _escolherEstado(item) {
    Navigator.pop(context, item);
  }
}

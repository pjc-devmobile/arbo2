import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:utils/utils/constants/colors.dart';

class EscolherCidadeDialog extends StatefulWidget {
  final estadoCidades;
  final titulo;
  final tituloPesquisa;

  const EscolherCidadeDialog({this.estadoCidades, this.titulo, this.tituloPesquisa});

  @override
  _EscolherCidadeDialogState createState() => _EscolherCidadeDialogState();
}

class _EscolherCidadeDialogState extends State<EscolherCidadeDialog> {
  List<String>? cidades;

  @override
  Widget build(BuildContext context) {

    if (cidades == null) {
      cidades = [];
      for (dynamic cidade in widget.estadoCidades.cidades) cidades!.add(cidade.toString());
    }

    return AlertDialog(
      title: Text(widget.titulo),
      content: Container(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          children: <Widget>[
            TextFormField(
              onChanged: (value) => _filtrarCidades(value),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                ),
                hintText: widget.tituloPesquisa + "...",
              ),
            ),
            Expanded(child: buildListCidades()),
          ],
        ),
      ),
    );
  }

  Widget buildListCidades() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: cidades!.length,
      itemBuilder: (context, index) {
        String item = cidades![index];

        return FlatButton(
          onPressed: () => _escolherCidade(item),
          child: Container(
            padding: EdgeInsets.all(16),
            width: double.maxFinite,
            child: Text(
              item + " - " + widget.estadoCidades.sigla,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: ColorsConfig.primaryColor),
              textAlign: TextAlign.left,
            ),
          ),
        );
      },
    );
  }

  _filtrarCidades(String value) {
    setState(() {
      cidades!.clear();
      for (dynamic cidade in widget.estadoCidades.cidades)
        if (cidade.toString().toLowerCase().contains(value.toLowerCase())) cidades!.add(cidade.toString());
    });
  }

  _escolherCidade(item) {
    Navigator.pop(context, item);
  }
}

import 'package:arnesrevisionsqlite/database/database.dart';
import 'package:arnesrevisionsqlite/model/arnes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'edit_arnes_page.dart';

class ArnesDetailPage extends StatefulWidget {
  final int arnesId;

  const ArnesDetailPage({
    Key? key,
    required this.arnesId,
  }) : super(key: key);

  @override
  _ArnesDetailPageState createState() => _ArnesDetailPageState();
}

class _ArnesDetailPageState extends State<ArnesDetailPage> {
  late Arnes arnes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshArnes();
  }

  Future refreshArnes() async {
    setState(() => isLoading = true);

    this.arnes = await ArnesDataBase.instance.readArnes(widget.arnesId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      arnes.nombre.toString(),
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ), //TODO añadir un titulo luego a la BBDD
                    SizedBox(height: 8),
                    Text(
                      "Revisión: " + DateFormat.yMMMMd().format(arnes.revision),
                    ),
                    SizedBox(height: 8),
                    Text(
                      arnes.observaciones,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ));
  }

  Widget deleteButton() => IconButton(
      icon: Icon(Icons.delete),
      onPressed: () async {
        await ArnesDataBase.instance.delete(widget.arnesId);

        Navigator.of(context).pop();
      });

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddEditArnesPage(arnes: arnes),
        ));

        refreshArnes();
      });
}

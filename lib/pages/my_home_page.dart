import 'package:arnesrevisionsqlite/database/database.dart';
import 'package:arnesrevisionsqlite/model/arnes.dart';
import 'package:arnesrevisionsqlite/pages/arnes_detail_page.dart';
import 'package:arnesrevisionsqlite/pages/edit_arnes_page.dart';
import 'package:arnesrevisionsqlite/widget/arnes_card_widget.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Arnes>? arneses = [];
  bool isLoading = false;

  @override
  void initstate() {
    super.initState();

    refreshArnes();
  }

  @override
  void dispose() {
    ArnesDataBase.instance.close();

    super.dispose();
  }

  Future refreshArnes() async {
    setState(() => isLoading = true);

    this.arneses = await ArnesDataBase.instance.readAllArnes();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : arneses!.isEmpty
                  ? Text(
                      'No hay arnes todavía.',
                      style: TextStyle(fontSize: 24),
                    )
                  : buildArneses(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: const Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddEditArnesPage()),
            );

            refreshArnes();
          },
        ),
      );

  Widget buildArneses() => ListView.builder(
        itemCount: arneses!.length,
        itemBuilder: (context, id) {
          final arnes = arneses![id];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => ArnesDetailPage(arnesId: arnes.id!),
              ));

              refreshArnes();
            },
            child: ArnesCardWidget(
              arnes: arnes,
              id: id,
            ),
          );
        },
      );
}

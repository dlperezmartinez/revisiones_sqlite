import 'package:arnesrevisionsqlite/database/database.dart';
import 'package:arnesrevisionsqlite/model/arnes.dart';
import 'package:arnesrevisionsqlite/widget/arnes_form_widget.dart';
import 'package:flutter/material.dart';

class AddEditArnesPage extends StatefulWidget {
  final Arnes? arnes;

  const AddEditArnesPage({
    Key? key,
    this.arnes,
  }) : super(key: key);
  @override
  _AddEditArnesPageState createState() => _AddEditArnesPageState();
}

class _AddEditArnesPageState extends State<AddEditArnesPage> {
  final _formKey = GlobalKey<FormState>();
  late int id;
  late String nombre;
  late DateTime revision;
  late String observaciones;

  @override
  void initState() {
    super.initState();

    id = widget.arnes?.id ?? 0;
    nombre = widget.arnes?.nombre ?? '';
    revision = widget.arnes?.revision ?? DateTime.now();
    observaciones = widget.arnes?.observaciones ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [buildButton()],
      ),
      body: Form(
        key: _formKey,
        child: ArnesFormWidget(
          id: id,
          nombre: nombre,
          revision: revision,
          observaciones: observaciones,
          onChangedId: (id) => setState(() => this.id = id),
          onChangedNombre: (nombre) => setState(() => this.nombre = nombre),
          onChangedRevision: (revision) =>
              setState(() => this.revision = revision),
          onChangedObservaciones: (observaciones) =>
              setState(() => this.observaciones = observaciones),
        ),
      ),
    );
  }

  Widget buildButton() {
    final isFormValid = nombre.isNotEmpty;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isFormValid ? null : Colors.green,
        ),
        onPressed: addOrUpdateArnes,
        child: Text('Guardar'),
      ),
    );
  }

  void addOrUpdateArnes() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.arnes != null;

      if (isUpdating) {
        await updateArnes();
      } else {
        await addArnes();
      }

      Navigator.of(context).pop();
    }
  }

  Future updateArnes() async {
    final arnes = widget.arnes!.copy(
      nombre: nombre,
      revision: revision,
      observaciones: observaciones,
    );

    await ArnesDataBase.instance.update(arnes);
  }

  Future addArnes() async {
    final arnes = Arnes(
      nombre: nombre,
      revision: revision,
      observaciones: observaciones,
    );

    await ArnesDataBase.instance.create(arnes);
  }
}

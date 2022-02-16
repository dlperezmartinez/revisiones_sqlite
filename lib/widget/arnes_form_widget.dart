import 'package:flutter/material.dart';

class ArnesFormWidget extends StatelessWidget {
  final int? id;
  final String? nombre;
  final DateTime? revision;
  final String? observaciones;
  final ValueChanged<int> onChangedId;
  final ValueChanged<String> onChangedNombre;
  final ValueChanged<DateTime> onChangedRevision;
  final ValueChanged<String> onChangedObservaciones;

  const ArnesFormWidget({
    Key? key,
    this.nombre = '',
    this.id = 0,
    this.revision,
    this.observaciones = '',
    required this.onChangedId,
    required this.onChangedNombre,
    required this.onChangedRevision,
    required this.onChangedObservaciones,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildNombre(),
              SizedBox(height: 8),
              buildRevision(),
              SizedBox(height: 8),
              buildObservaciones(),
              SizedBox(height: 16),
            ],
          ),
        ),
      );

  Widget buildNombre() => TextFormField(
        maxLines: 1,
        initialValue: observaciones,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Nombre',
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'Nombre requerido' : null,
        onChanged: onChangedNombre,
      );

  Widget buildRevision() => InputDatePickerFormField(
        initialDate: revision,
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 120),
        onDateSaved: onChangedRevision,
      );

  Widget buildObservaciones() => TextFormField(
        maxLines: 5,
        initialValue: observaciones,
        style: TextStyle(fontSize: 18),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Observaciones',
        ),
        onChanged: onChangedObservaciones,
      );
}

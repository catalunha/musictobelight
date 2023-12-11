import 'package:flutter/material.dart';

class DescriptionCard extends StatelessWidget {
  final String? description;
  const DescriptionCard({
    Key? key,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black12,
        height: 200,
        child: SingleChildScrollView(
          child: Text(description ?? 'Sem descrição.'),
        ),
      ),
    );
  }
}

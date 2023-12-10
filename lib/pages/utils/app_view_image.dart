import 'dart:developer';

import 'package:flutter/material.dart';

class AppViewImage extends StatelessWidget {
  final String? imageUrl;
  final double maxHeightImage;
  final double maxWidthImage;

  const AppViewImage({
    Key? key,
    this.imageUrl,
    this.maxHeightImage = 150,
    this.maxWidthImage = 150,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('AppViewImage.imageUrl = $imageUrl');

    return imageUrl == null
        ? Container(
            width: maxWidthImage,
            height: maxHeightImage,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Center(
              child: Icon(Icons.person_outline),
            ),
          )
        : ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.network(
              imageUrl!,
              height: maxHeightImage,
              width: maxWidthImage,
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return errorBuilderWidget();
              },
            ),
          );
  }

  Container errorBuilderWidget() {
    return Container(
      height: maxHeightImage,
      width: maxWidthImage,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Center(
        child: Text('Erro ao buscar esta imagem'),
      ),
    );
  }
}

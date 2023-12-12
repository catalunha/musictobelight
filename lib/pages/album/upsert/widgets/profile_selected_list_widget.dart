import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/providers.dart';
import 'profile_card.dart';

class ProfileSelectedListWidget extends ConsumerWidget {
  const ProfileSelectedListWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileSelected = ref.watch(profileSelectedProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Colors.black12,
        height: 200,
        // width: 300,
        child: SingleChildScrollView(
          child: Column(
            children: [
              ...profileSelected.list.map((e) => ProfileCard(model: e)).toList()
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../controller/providers.dart';
import 'profile_card.dart';

class ProfileSelectedWidget extends ConsumerWidget {
  const ProfileSelectedWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileSelected = ref.watch(profileSelectedProvider);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: profileSelected.author == null
          ? const Text('Defina um autor')
          : ProfileCard(model: profileSelected.author!),
    );
  }
}

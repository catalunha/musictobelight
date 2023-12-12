import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../routes_root.dart';
import '../../../services/providers.dart';

class HomePopMenu extends ConsumerWidget {
  const HomePopMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return PopupMenuButton(
      offset: Offset.fromDirection(120.0, 70.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Editar perfil'),
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pushNamed(RouteNameRoot.profileUpdate);
              },
              icon: const Icon(Icons.person_outline_outlined),
            ),
          ),
          PopupMenuItem(
            child: TextButton.icon(
              label: const Text('Sair'),
              onPressed: () async {
                ref.read(logoutProvider);
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ),
        ];
      },
      child: const Tooltip(
        message: 'Click para ver opções',
        child: Icon(Icons.settings),
      ),
    );
  }
}

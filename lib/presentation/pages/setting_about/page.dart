import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/extensions.dart';
import '../../../domain/usecases/check_update.dart';

@RoutePage()
class SettingAboutPage extends HookConsumerWidget {
  const SettingAboutPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tentang')),
      body: const Column(
        // Menampilkan Page 4 orang developer dengan gambar dan nama informasi developer
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.person),
            ),
            title: Text('Developer'),
            subtitle: Text(
              'Aldi, Daffa, Fikri, dan Rizky',
            ),
          ),
        ], 
      ),
    );
  }
}
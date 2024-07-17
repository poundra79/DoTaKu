import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils/extensions.dart';
import '../../../domain/usecases/check_update.dart';

@RoutePage()
class SettingUpdatePage extends HookConsumerWidget {
  const SettingUpdatePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCheckingUpdate = useState(false);

    return Scaffold(
      appBar: AppBar(title: const Text('Info Lanjut')),
      body: Column(
        children: [
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.info_outlined),
            ),
            title: const Text('Versi'),
            subtitle: FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) => Text(
                '${(snapshot.data?.version)}+${snapshot.data?.buildNumber}',
              ),
            ),
          ),
          ListTile(
            enabled: !isCheckingUpdate.value,
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.update_outlined),
            ),
            title: const Text('Periksa pembaruan'),
            subtitle: Text(
              isCheckingUpdate.value
                  ? 'Memeriksa pembaruan...'
                  : 'Tekan untuk memeriksa pembaruan',
            ),
            onTap: isCheckingUpdate.value
                ? null
                : () {
                    isCheckingUpdate.value = true;
                    ref
                        .read(checkUpdateUseCaseProvider)
                        .call()
                        .then(
                          (value) => value.fold(
                            (l) => context.showSnackBar(message: l.message),
                            (r) => r == null
                                ? context.showSnackBar(
                                    message: 'Tidak ada pembaruan!',
                                  )
                                : context.showSnackBar(
                                    message: 'Tersedia pembaruan!',
                                    action: SnackBarAction(
                                      label: 'Unduh',
                                      onPressed: () => launchUrl(
                                        Uri.parse(r.downloadUrl),
                                        mode: LaunchMode.externalApplication,
                                      ),
                                    ),
                                  ),
                          ),
                        )
                        .whenComplete(
                          () => isCheckingUpdate.value = false,
                        );
                  },
          ),
          // Buat Nama Kelompok 4 orang bernama poundra, danar, faris, dan revanza dengan gambar di kiri berukuran kecil serta ketika di klik akan muncul dialog nama nama developer beserta gambar developernya
          ListTile(
            leading: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Icon(Icons.person),
            ),
            title: const Text('Team DoTaku'),
            subtitle: const Text(
              'Tentang Kami',
            ),
            onTap: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Developer'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/danardi.jpg'),
                      ),
                      title: const Text('Danardi Listyono\n1152200022\nKetua dan Sub Progammer'),
                      
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/poundra.jpg'),
                      ),
                      title: const Text('Poundra Adiyatma\n1152200030\nProgammer'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/faris.jpg'),
                      ),
                      title: const Text('Ikhwan El Faris\n1152200009\nDesigner'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/revan.jpg'),
                      ),
                      title: const Text('Revanza Hadi Putra\n1152200029\nSystem Analyst'),
                    ),
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        child: Image.asset('assets/images/rizky.jpg'),
                      ),
                      title: const Text('Rizky Rahmanto\n1152200007\nDokumenter'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:dayshez_pt/service/database.dart';
import 'package:dayshez_pt/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DrawerNavigation extends StatelessWidget {
  const DrawerNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    var user = Database().SUPABASE_CLIENT!.auth.currentUser;
    return Drawer(
        width: MediaQuery.of(context).size.width * 0.70,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [_buildHeader(context, user!), _buildMenuItems(context)],
          ),
        ));
  }

  Widget _buildHeader(BuildContext context, User user) =>
      UserAccountsDrawerHeader(
          decoration: const BoxDecoration(color: primaryColor),
          accountName: Text(user.userMetadata!.isNotEmpty
              ? user.userMetadata!.values.first
              : user.email),
          accountEmail: Text(user.email!),
          currentAccountPicture: ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image(
              color: whiteColor,
              fit: BoxFit.fill,
              key: UniqueKey(),
              image: const AssetImage(assetLogo),
            ),
          ));
  Widget _buildMenuItems(BuildContext context) => Container(
        padding: const EdgeInsets.all(24),
        child: Wrap(
          children: [
            ListTile(
              title: const Text('Logut'),
              trailing: const Icon(Icons.logout_sharp),
              onTap: () async {
                var isLogout = await Database().logout(context);
                if (isLogout) {
                  Navigator.pushReplacementNamed(context, '/loading');
                }
              },
            ),
            const Divider()
          ],
        ),
      );
}

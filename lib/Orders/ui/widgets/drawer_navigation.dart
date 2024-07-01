// ignore_for_file: use_build_context_synchronously

import 'package:dayshez_pt/Log/domain/blocs/authentication/authentication_bloc.dart';
import 'package:dayshez_pt/Orders/data/service/database.dart';
import 'package:dayshez_pt/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
          accountName: FittedBox(
            child: Text(
              user.userMetadata!.isNotEmpty
                  ? getName(user.userMetadata)!
                  : user.email!,
            ),
          ),
          accountEmail: FittedBox(child: Text(user.email!)),
          currentAccountPicture: ClipRRect(
            borderRadius: BorderRadius.circular(100.0.r),
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
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400),
              ),
              trailing: const Icon(Icons.logout_sharp),
              onTap: () async {
                showAdaptiveDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (_) {
                      return AlertDialog.adaptive(
                        title: Text(
                          dialogLogout,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        actions: [
                          TextButton(
                              onPressed: () =>
                                  Navigator.of(context, rootNavigator: true)
                                      .pop(),
                              child: Text(cancel,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .color))),
                          TextButton(
                              onPressed: () {
                                context
                                    .read<AuthenticationBloc>()
                                    .add(AuthenticationLogoutRequest());
                                Navigator.of(context, rootNavigator: true)
                                    .pop();
                              },
                              child: Text(ok,
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .textTheme
                                          .titleSmall!
                                          .color))),
                        ],
                      );
                    });
              },
            ),
            const Divider()
          ],
        ),
      );

  String? getName(Map<String, dynamic>? userMetadata) {
    var name = userMetadata!.entries
        .map((e) {
          if (e.key.toLowerCase().contains('name')) {
            return e.value;
          } else {
            return '';
          }
        })
        .toList()
        .where((element) => element != '');
    return name.first;
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class GlobalBottomAppBar extends StatelessWidget {
  final bool isSubPage;
  final String onPageName;
  const GlobalBottomAppBar(
      {required this.isSubPage, required this.onPageName, super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: thirtyUIColor,
      height: defaultBottomAppBarHeight,
      child: SizedBox(
        height: defaultBottomAppBarHeight,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    tooltip: "Classroom",
                    icon: const Icon(
                      Icons.school,
                    ),
                    onPressed: () {
                      if (onPageName != "Home") {
                        Navigator.of(context).pushReplacementNamed(
                          '/Home',
                        );
                      }
                    },
                  ),
                  IconButton(
                    tooltip: "Logout",
                    icon: const Icon(
                      Icons.person,
                    ),
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      if (context.mounted) {
                        Navigator.of(context).pushReplacementNamed(
                          '/LoginPage',
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/controller/user_state.dart';
import 'package:flutter_bootstrap/widgets/global_buttom_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserState>(
      builder: (context, UserState userState, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text(
                "Welcome! ${userState.role} ${userState.username}!",
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                (userState.role == 'Instructor')
                    ? Center(
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushNamed(
                                "/AddClassroomPage",
                              );
                            },
                            child: const Text("Add another class")),
                      )
                    : const SizedBox()
              ],
            ),
            bottomNavigationBar:
                const GlobalBottomAppBar(isSubPage: false, onPageName: "Home"),
          );
      },
    );
  }

  @override
  void setState(fn) {
    if (context.mounted) {
      super.setState(fn);
    }
  }
}

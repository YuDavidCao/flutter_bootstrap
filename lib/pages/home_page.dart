import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/constants.dart';
import 'package:flutter_bootstrap/controller/user_state.dart';
import 'package:flutter_bootstrap/firebase/firebase_firestore_service.dart';
import 'package:flutter_bootstrap/widgets/global_buttom_navigation_bar.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Widget> loadClassroomCard(String classId) async {
    DocumentSnapshot classroomData =
        await FirebaseFirestoreService.getClassroomData(classId);
    Map<String, dynamic> data = classroomData.data()! as Map<String, dynamic>;
    return Container(
      padding: const EdgeInsets.fromLTRB(
          globalEdgePadding, globalEdgePadding, 0, globalEdgePadding),
      margin: globalMiddleWidgetPadding,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(25)),
          border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(data["Title"]),
              Text(data["Description"]),
              // Text(data["Student"].length)
            ],
          ),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamed("/InClassPage", arguments: {"classId": classId});
              },
              icon: const Icon(Icons.keyboard_arrow_right))
        ],
      ),
    );
  }

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
              const SizedBox(
                height: globalEdgePadding,
              ),
              const Text(
                "My classes:",
                style: TextStyle(fontSize: 18),
              ),
              const Divider(
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
                color: Colors.grey,
                thickness: 2,
              ),
              ...userState.classes.map((String classId) {
                return FutureBuilder<Widget>(
                  future: loadClassroomCard(classId),
                  builder:
                      (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(
                          strokeWidth: 1,
                        ),
                      );
                    }
                  },
                );
              }).toList(),
              (userState.role == 'Instructor')
                  ? Center(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(
                              "/AddClassroomPage",
                            );
                          },
                          child: const Text("Create a class")),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: globalEdgePadding,
              ),
              const Text(
                "Explore more classes:",
                style: TextStyle(fontSize: 18),
              ),
              const Divider(
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
                color: Colors.grey,
                thickness: 2,
              ),
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

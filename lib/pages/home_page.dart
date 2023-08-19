import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/constants.dart';
import 'package:flutter_bootstrap/controller/classroom_state.dart';
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
  Future<Widget> loadMyClassroomCard(String classId) async {
    DocumentSnapshot classroomData =
        await FirebaseFirestoreService.getClassroomData(classId);
    return ClassCard(data: classroomData, alreadyEnrolled: true);
  }

  Future<Widget> loadOtherClassroomCard(String classId) async {
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
          body: ListView(
            children: [
              const SizedBox(
                height: globalEdgePadding,
              ),
              const Center(
                child: Text(
                  "My classes:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Divider(
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
                color: Colors.grey,
                thickness: 2,
              ),
              ...userState.classes.map((String classId) {
                return FutureBuilder<Widget>(
                  future: loadMyClassroomCard(classId),
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
              const Center(
                child: Text(
                  "Explore more classes:",
                  style: TextStyle(fontSize: 18),
                ),
              ),
              const Divider(
                indent: globalEdgePadding,
                endIndent: globalEdgePadding,
                color: Colors.grey,
                thickness: 2,
              ),
              ChangeNotifierProvider(
                create: (_) => ClassroomState(
                    Provider.of<UserState>(context, listen: false).email),
                child: Consumer<ClassroomState>(
                  builder: (context, ClassroomState classroomState, child) {
                    return Column(
                      children: [
                        ...classroomState.loadedClassroom
                            .map((DocumentSnapshot data) {
                          return ClassCard(
                            data: data,
                            alreadyEnrolled: false,
                          );
                        }).toList(),
                      ],
                    );
                  },
                ),
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

class ClassCard extends StatelessWidget {
  final DocumentSnapshot data;
  final bool alreadyEnrolled;
  const ClassCard(
      {super.key, required this.data, required this.alreadyEnrolled});

  @override
  Widget build(BuildContext context) {
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
                if (alreadyEnrolled) {
                  Navigator.of(context).pushNamed("/InClassPage",
                      arguments: {"classId": data.id});
                } else {
                  FirebaseFirestoreService.enrollInClass(
                      data.id,
                      Provider.of<UserState>(context, listen: false).email,
                      Provider.of<UserState>(context, listen: false).role ?? "",
                      Provider.of<ClassroomState>(context, listen: false));
                }
              },
              icon: Icon(
                  (alreadyEnrolled) ? Icons.keyboard_arrow_right : Icons.add))
        ],
      ),
    );
  }
}

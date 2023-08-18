import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/constants.dart';
import 'package:flutter_bootstrap/controller/user_state.dart';
import 'package:flutter_bootstrap/firebase/firebase_firestore_service.dart';
import 'package:provider/provider.dart';

class AddClassroomPage extends StatefulWidget {
  const AddClassroomPage({super.key});

  @override
  State<AddClassroomPage> createState() => _AddClassroomPageState();
}

class _AddClassroomPageState extends State<AddClassroomPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(globalEdgePadding),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: const InputDecoration(
                    labelText: 'Enter class name',
                    border: OutlineInputBorder()),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Enter a class name';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: globalEdgePadding,
              ),
              TextFormField(
                controller: descriptionController,
                maxLines: null,
                decoration: const InputDecoration(
                    labelText: 'Enter class description',
                    border: OutlineInputBorder()),
                validator: (val) {
                  if (val!.isEmpty) {
                    return 'Description cannot be null';
                  } else {
                    return null;
                  }
                },
              ),
              const SizedBox(
                height: globalEdgePadding,
              ),
              ElevatedButton(
                  onPressed: () {
                    FirebaseFirestoreService.addClassroom(
                        titleController.text,
                        descriptionController.text,
                        Provider.of<UserState>(context, listen: false).email,
                        Provider.of<UserState>(context, listen: false)
                                .username ??
                            "");
                    Navigator.pop(context);
                  },
                  child: const Text("Create classroom"))
            ],
          ),
        ),
      ),
    );
  }
}

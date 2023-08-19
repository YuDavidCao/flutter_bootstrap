import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bootstrap/constants.dart';
import 'package:flutter_bootstrap/controller/class_activity_stream.dart';
import 'package:flutter_bootstrap/controller/user_state.dart';
import 'package:flutter_bootstrap/firebase/firebase_firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

class InClassPage extends StatefulWidget {
  final String classId;
  const InClassPage({super.key, required this.classId});

  @override
  State<InClassPage> createState() => _InClassPageState();
}

class _InClassPageState extends State<InClassPage> {
  final TextEditingController commentEditingController =
      TextEditingController();

  @override
  void dispose() {
    commentEditingController.dispose();
    super.dispose();
  }

  Future<Widget> loadClassroomActivity() async {
    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ChangeNotifierProvider(
        create: (_) => ClassActivityStream(widget.classId),
        child: Stack(
          children: [
            Consumer<ClassActivityStream>(
              builder: (context, ClassActivityStream classroomState, child) {
                return ListView(
                  children: [
                    ...classroomState.loadedActivity
                        .map((DocumentSnapshot documentSnapshot) {
                      return ActivityCard(
                          classId: widget.classId,
                          activityId: documentSnapshot.id,
                          activityPosterEmail: documentSnapshot["UserEmail"],
                          messageOwnerUserName: documentSnapshot["UserName"],
                          messageContent: documentSnapshot["Message"],
                          postDate: documentSnapshot["Time"].toDate());
                    }).toList(),
                  ],
                );
              },
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CommentField(
                classId: widget.classId,
                textEditingController: commentEditingController,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final String classId;
  final String activityId;
  final String activityPosterEmail;
  final String messageOwnerUserName;
  final String messageContent;
  final DateTime postDate;
  const ActivityCard(
      {super.key,
      required this.classId,
      required this.activityId,
      required this.activityPosterEmail,
      required this.messageOwnerUserName,
      required this.messageContent,
      required this.postDate});

  @override
  Widget build(BuildContext context) {
    bool isInstructor =
        Provider.of<UserState>(context, listen: false).role != null &&
            Provider.of<UserState>(context, listen: false).role == "Instructor";
    bool isMyOwnPost = Provider.of<UserState>(context, listen: false).email ==
        activityPosterEmail;
    return Padding(
      padding: globalMiddleWidgetPadding,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${timeago.format(postDate)} · $messageOwnerUserName",
                style: const TextStyle(color: Colors.grey),
              ),
              Text(messageContent),
              const Divider(
                color: Colors.grey,
                thickness: 2,
              )
            ],
          ),
          (isInstructor || isMyOwnPost)
              ? IconButton(onPressed: () {}, icon: const Icon(Icons.delete))
              : const SizedBox()
        ],
      ),
    );
  }
}

class CommentField extends StatelessWidget {
  final String classId;
  final TextEditingController textEditingController;
  const CommentField(
      {required this.classId, required this.textEditingController, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(globalEdgePadding),
      width: MediaQuery.of(context).size.width - 30,
      child: Row(
        children: [
          Expanded(
            child: Container(
                padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(35.0),
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(0, 3), blurRadius: 5, color: Colors.grey)
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: textEditingController,
                        decoration: const InputDecoration(
                            hintText: "  Leave a comment...",
                            border: InputBorder.none),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        FirebaseFirestoreService.postActivity(
                            textEditingController.text,
                            classId,
                            Provider.of<UserState>(context, listen: false)
                                .email,
                            Provider.of<UserState>(context, listen: false)
                                    .username ??
                                "");
                      },
                      icon: const Icon(
                        Icons.send,
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}

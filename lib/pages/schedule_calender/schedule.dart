import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/Recommendation/recommendation.dart';
import 'package:flutter_application_1/pages/personalpages/userinfo.dart';
import 'package:flutter_application_1/pages/schedule_calender/notification.dart';
import 'package:table_calendar/table_calendar.dart';

class schedule extends StatefulWidget {
  const schedule({super.key});

  @override
  State<schedule> createState() => _scheduleState();
}

class _scheduleState extends State<schedule> {
  DateTime today = DateTime.now();
  String title = '';
  late final NotificationApi service;
  String? message;
  @override
  void initState() {
    service = NotificationApi();
    service.initialize();
    super.initState();
    if (notificationdetails != null) {
      for (int i = 0; i < notificationdetails!.length; i++) {
        service.showscheduledNotification(
            id: i,
            title: "Hey!!$firstname",
            body: "It's time for your ${notificationdetails![i]['title']}");
        service.showscheduledNotification(
            id: i + 1,
            title: "Hey!!$firstname",
            body: "Don't forget to bring your water Bottle with you");
        print(notificationdetails![i]['title']);
      }
    }
  }

  Future<void> showEvent(DateTime selectedDay) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    final User user = auth.currentUser!;
    final uid = user.uid;
    List<Map<String, dynamic>> events = [];

    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (buildContext) {
          return FractionallySizedBox(
            heightFactor: 0.5,
            child: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                    Color(0x665ac18e),
                    Color(0x995ac18e),
                    Color(0xcc5ac18e),
                    Color(0xff5ac18e),
                  ])),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(50, 60, 50, 20),
                child: Column(
                  children: [
                    Text(
                      "Selected Day=" + today.toString().split(" ")[0],
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .collection('userdocuments')
                              .doc('calenderplan')
                              .collection('exerciseday')
                              .where('date',
                                  isEqualTo: today.toString().split(" ")[0])
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData ||
                                snapshot.data!.docs.isEmpty) {
                              return const Center(
                                child: Text('No events for today'),
                              );
                            }
                            events = List<Map<String, dynamic>>.from(
                                snapshot.data!.docs.first.get('Title'));
                            return ListView.builder(
                              itemCount: events.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic> data = events[index];
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Text((index + 1).toString() +
                                          ')\t\t' +
                                          data['title']),
                                    ),
                                    Divider(
                                      height: 2,
                                    )
                                  ],
                                );
                              },
                            );
                          }),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: Text('Add Event'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  decoration:
                                      InputDecoration(hintText: 'Title'),
                                  onChanged: (value) {
                                    setState(() {
                                      title = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  // service.showscheduledNotification(
                                  //     title: 'Notification', body: 'muji');
                                  setState(() {
                                    events.add({
                                      'title': title,
                                    });
                                    try {
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(uid)
                                          .collection('userdocuments')
                                          .doc('calenderplan')
                                          .collection('exerciseday')
                                          .doc(selectedDay
                                              .toString()
                                              .split(" ")[0])
                                          .set({
                                        'Title': events,
                                        'date': selectedDay
                                            .toString()
                                            .split(" ")[0],
                                      });
                                    } catch (e) {}
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('Save'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: Icon(Icons.add),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  void _dayselected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
    showEvent(day);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              focusedDay: DateTime.now(),
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              rowHeight: 60,
              headerStyle:
                  HeaderStyle(formatButtonVisible: false, titleCentered: true),
              availableGestures: AvailableGestures.all,
              onDaySelected: _dayselected,
              selectedDayPredicate: (day) => isSameDay(day, today),
            ),
          ),
          FloatingActionButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DisplayRecommendedExercises(),
              ),
            );
          }),
        ],
      ),
    );
  }
}

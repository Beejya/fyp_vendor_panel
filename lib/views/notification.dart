import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:vendor/services/baseUrl.dart';

import '../models/notification_model.dart';

class Notification_page extends StatefulWidget {
  const Notification_page({Key? key});

  @override
  State<Notification_page> createState() => _Notification_pageState();
}

class _Notification_pageState extends State<Notification_page> {
  bool _isChecked = false;
  List<Notificationdata> notification = [];

  Future<String> getnotification() async {
    var response =
        await http.get(Uri.parse("${baseUrl}vendornotificationlist.php"));
    setState(() {
      notification = notificationdataFromJson(response.body);
    });
    return "Success";
  }

  @override
  void initState() {
    super.initState();
    getnotification();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Notification"),
        ),
        body: FutureBuilder(
            future: getnotification(),
            builder: (context, snapshot) {
              if (snapshot.hasError) print(snapshot.error);
              return snapshot.hasData
                  ? ListView.builder(
                      itemCount: notification.length,
                      itemBuilder: ((context, index) {
                        return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListTile(
                              contentPadding: EdgeInsets.symmetric(vertical: 8),
                              tileColor: Colors.blue.shade50,
                              leading: Text('${index + 1}.'),
                              title: Text("${notification[index].title}"),
                              subtitle: Text("${notification[index].message}"),
                              trailing: Column(
                                children: [
                                  StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return Checkbox(
                                        value: _isChecked,
                                        onChanged: (bool? value) {
                                          setState(() {
                                            _isChecked = value!;
                                          });
                                        },
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ));
                      }))
                  : Center(
                      child: Container(
                        child: Text(
                          "No Notification to Show",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
            }));
  }
}

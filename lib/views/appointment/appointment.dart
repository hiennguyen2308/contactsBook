import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactsbook/views/appointment/update_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/crud_services.dart';

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  late Stream<QuerySnapshot> _stream;
  TextEditingController _searchController = TextEditingController();
  FocusNode _searchfocusNode = FocusNode();

  @override
  void initState() {
    _stream = CRUDService().getAppointments();
    super.initState();
  }

  @override
  void dispose() {
    _searchfocusNode.dispose();
    super.dispose();
  }
  searchContacts(String search) {
    _stream = CRUDService().getAppointments(searchQuery: search);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Appointment"),
        bottom: PreferredSize(
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: SizedBox(
                  width: MediaQuery.of(context).size.width * .9,
                  child: TextFormField(
                    onChanged: (value) {
                      searchContacts(value);
                      setState(() {});
                    },
                    focusNode: _searchfocusNode,
                    controller: _searchController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        label: Text("Search"),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: _searchController.text.isNotEmpty
                            ? IconButton(
                          onPressed: () {
                            _searchController.clear();
                            _searchfocusNode.unfocus();
                            _stream = CRUDService().getAppointments();
                            setState(() {});
                          },
                          icon: Icon(Icons.close),
                        )
                            : null),
                  )),
            ),
            preferredSize: Size(MediaQuery.of(context).size.width * 8, 90)),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something Went Wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Text("Loading"),
              );
            }
            return snapshot.data!.docs.length == 0
                ? Center(
              child: Text("No Appointments Found ..."),
            )
                : ListView(
              children: snapshot.data!.docs
                  .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                document.data()! as Map<String, dynamic>;
                return ListTile(
                  onTap: () => Navigator.push(
                      context, MaterialPageRoute(
                      builder: (context) => UpdateAppointment(
                        name: data["name"],
                        content: data["content"],
                        time: data["time"],
                        date: data["date"],
                        docID: document.id,))),
                  leading: CircleAvatar(child: Text(data["content"][0])),
                  title: Text(data["content"]),
                  subtitle: Text(data["name"]),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(data["time"]),
                      Text(data["date"])
                    ],
                  )
                );
              })
                  .toList()
                  .cast(),
            );
          }),
    );
  }
}

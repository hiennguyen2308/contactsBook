import 'package:contactsbook/controllers/notification.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../controllers/crud_services.dart';


class AddAppointment extends StatefulWidget {
  AddAppointment({super.key, required this.name});

  final String name;

  @override
  State<AddAppointment> createState() => _AddAppointmentState();
}

class _AddAppointmentState extends State<AddAppointment> {
  TextEditingController _nameAppointment = new TextEditingController();
  late String _dateAppointment;
  String ? _timeAppointment;
  DateTime _dateTime = DateTime.now();
  TimeOfDay _timeOfDay = TimeOfDay.now();
  final appointmentKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Add Appointment"),
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: appointmentKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child:Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        width: 100,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(),
                            shape: BoxShape.circle,
                            color: Colors.black12
                        ),
                        child: Center(
                          child: Text(
                            widget.name.toString()[0].toUpperCase(),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        child: Text(
                          widget.name.toString(),
                          style: TextStyle(
                              fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                TextFormField(
                  controller: _nameAppointment,
                  validator: (value) =>
                  value!.isEmpty ? "Enter any content" : null,
                  decoration: InputDecoration(
                    hintText: 'Enter content of appointment',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10,),
                Container(
                  decoration: BoxDecoration(
                      border:Border.all()
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Time",
                          style: TextStyle(fontSize: 15),),
                        CupertinoButton(
                          child: Text(
                            _timeOfDay.hour.toString() +":"+_timeOfDay.minute.toString(),),
                          onPressed: (){
                            _selectTime();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  decoration: BoxDecoration(
                    border:Border.all()
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Day", style: TextStyle(fontSize: 15),),
                        CupertinoButton(
                          child: Text('${_dateTime.month}-${_dateTime.day}-${_dateTime.year}'),
                          onPressed: (){
                            _selectDate();
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width * .9,
                    child: ElevatedButton(
                        onPressed: () {
                          if (appointmentKey.currentState!.validate()) {
                            CRUDService().addNewAppointment(
                                widget.name,
                                _nameAppointment.text,
                                _timeAppointment.toString(),
                                _dateAppointment.toString());
                            NotificationHelper.scheduledNotification("Scheduled", "This is sheduled notification",_dateAppointment.toString(),_timeAppointment.toString());
                            Navigator.pop(context);
                          }
                        },
                        child: Text(
                          "Create",
                          style: TextStyle(fontSize: 16),
                        ))),
              ],
            ),
          ),
        ),
      )
    );
  }
  Future<void> _selectTime() async {
    TimeOfDay ? _picker = await showTimePicker(
        context: context,
        initialTime: _timeOfDay);
    if (_picker != null) {
      setState(() {
        _timeOfDay = _picker;
        _timeAppointment = _timeOfDay.hour.toString() + ':' + _timeOfDay.minute.toString();
      });
    }
  }
  Future<void> _selectDate() async {
    DateTime? _pickerDate = await showDatePicker
      (context: context,
        firstDate: DateTime(2020),
        lastDate: DateTime(2055));
    if(_pickerDate != null){
      setState(() {
        _dateTime = _pickerDate;
        if (_dateTime.day.toString().length == 1){
          _dateAppointment = '0'+ _dateTime.day.toString() + '-' + _dateTime.month.toString() + '-' + _dateTime.year.toString();

        }if (_dateTime.month.toString().length == 1){
          _dateAppointment = _dateTime.day.toString() + '-' + '0' + _dateTime.month.toString() + '-' + _dateTime.year.toString();

        }
      });
    }
  }

}

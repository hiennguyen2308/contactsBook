import 'package:contactsbook/views/appointment/add_appointment.dart';
import 'package:contactsbook/views/send_email.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailContacts extends StatefulWidget {
  const DetailContacts({
    super.key,
    required this.docID,
    required this.name,
    required this.phone,
    required this.email,
    required this.note
  });
  final String docID, name, phone, email, note;
  
  @override
  State<DetailContacts> createState() => _DetailContactsState();
}

class _DetailContactsState extends State<DetailContacts> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _noteController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    _emailController.text = widget.email;
    _phoneController.text = widget.phone;
    _nameController.text = widget.name;
    _noteController.text = widget.note;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: Text("Detail Contact"),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                            _nameController.text[0].toUpperCase(),
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
                        _nameController.text,
                        style: TextStyle(
                            fontSize: 20
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("SDT", style: TextStyle(fontSize: 15),),
                            SizedBox(height: 5,),
                            Text(_phoneController.text, style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if(_emailController.text.isNotEmpty)
              SizedBox(height: 10,),
              if(_emailController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Email", style: TextStyle(fontSize: 15),),
                            SizedBox(height: 5,),
                            Text(_emailController.text, style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              if(_noteController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Note", style: TextStyle(fontSize: 15),),
                            SizedBox(height: 5,),
                            Text(_noteController.text, style: TextStyle(fontSize: 15),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              if(_noteController.text.isNotEmpty)
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                             child: Text("Add Appointment "),
                              onTap:()=> Navigator.push(context,MaterialPageRoute(builder: (context) => AddAppointment(name: _nameController.text,))),
                            ),
                            // TextButton(
                            //     onPressed: (){
                            //       Navigator.push(context, MaterialPageRoute(builder: (context)=> AddAppointment(name: _nameController.text,)));
                            //     },
                            //     child: Text('Tao lich hen')),
                            if(_emailController.text.isNotEmpty)
                            Divider(color: Colors.black,),
                            if(_emailController.text.isNotEmpty)
                            GestureDetector(
                              child: Text("Send Email"),
                              onTap: ()=> Navigator.push(context,MaterialPageRoute(builder: (context)=> EmailSender(email: _emailController.text,))),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

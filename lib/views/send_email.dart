import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

class EmailSender extends StatelessWidget {
  EmailSender({super.key, required this.email});
  final String email;

  final _keyemail = GlobalKey<FormState>();
  TextEditingController body = TextEditingController();
  TextEditingController subject = TextEditingController();
  // TextEditingController email = TextEditingController();

  sendEmail(String subject , String body, String recipientemail) async {
    final Email email = Email(
      body: body,
      subject: subject,
      recipients: [recipientemail],
      // cc: ['cc@example.com'],
      // bcc: ['bcc@example.com'],
      // attachmentPaths: ['/path/to/attachment.zip'],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _keyemail,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .9,
                // decoration: BoxDecoration(
                //   border: OutlineInputBorder()
                // ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Email"),
                    Text(email)
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: subject,
                decoration: InputDecoration(
                  hintText: 'enter subject',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: body,
                decoration: InputDecoration(
                  hintText: 'enter body',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: (){
                    _keyemail.currentState!.save();
                    print('${email}');
                    sendEmail(subject.text, body.text,email);
                  },
                  child: Text("Send Email")
              ),
            ],
          ),
        ),
      ),
    );
  }
}

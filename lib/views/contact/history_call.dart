import 'package:call_log/call_log.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCall extends StatelessWidget {
  const HistoryCall({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
      ),
      body: FutureBuilder<Iterable<CallLogEntry>>(
        future: CallLog.get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
            // return print(snapshot.error);
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                CallLogEntry entry = snapshot.data!.elementAt(index);

                // Check if entry.timestamp is not null before creating DateTime
                DateTime? timestamp = entry.timestamp != null
                    ? DateTime.fromMillisecondsSinceEpoch(entry.timestamp!)
                    : null;

                // Check if timestamp is not null before formatting
                String formattedDateTime = timestamp != null
                    ? DateFormat.yMd().add_Hms().format(timestamp)
                    : 'N/A';

                return ListTile(
                  leading: Icon(Icons.call),
                  title: Text('${entry.name ?? 'Unknown'}: ${entry.number}'),
                  subtitle:
                  Text('$formattedDateTime | ${entry.duration} seconds'),
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';

class WoundDetailsPage extends StatelessWidget {
  final Map<String, dynamic> wound;

  WoundDetailsPage({required this.wound});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details for ${wound['Type']}'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Steps : ${wound['steps'].length}",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 171, 11, 11),
                      ),
                    ),
                    SizedBox(height: 10),
                    ...List<Widget>.generate(
                        wound['steps'].length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                  '${index + 1}. ${wound['steps'][index]}',
                                  style: TextStyle(fontSize: 16)),
                            )),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Requirements:",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 171, 11, 11),
                      ),
                    ),
                    SizedBox(height: 10),
                    ...wound['requirements']
                        .map<Widget>((req) => Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text('- $req',
                                  style: TextStyle(fontSize: 16)),
                            ))
                        .toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

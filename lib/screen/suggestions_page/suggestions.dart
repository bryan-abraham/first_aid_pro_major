import 'package:flutter/material.dart';

import '../widgets/text_property.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({
    Key? key,
    required this.predictedWoundType,
    required this.predictedClass,
    required this.treatmentSteps,
  }) : super(key: key);

  final String predictedWoundType;
  final String predictedClass;
  final String treatmentSteps;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String cleanSteps = treatmentSteps;
    if (cleanSteps.startsWith('[') && cleanSteps.endsWith(']')) {
      cleanSteps = cleanSteps.substring(1, cleanSteps.length - 1);
    }
    List<String> stepsList =
        cleanSteps.split('.').where((s) => s.isNotEmpty).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Diagnose Report'),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.all(0.02 * size.height),
            child: Column(
              children: [
                Card(
                  child: TextProperty(
                    title: 'Type',
                    value: predictedWoundType,
                    height: size.height,
                  ),
                ),
                Card(
                  child: TextProperty(
                    title: 'Predicted class',
                    value: predictedClass,
                    height: size.height,
                  ),
                ),
                const SizedBox(height: 20),
                Card(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Treatment Steps',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...stepsList.asMap().entries.map((entry) {
                        int idx = entry.key;
                        String step = entry.value.trim();
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text('${idx + 1}.',
                              //     style: const TextStyle(
                              //         fontWeight: FontWeight.bold)),
                              const SizedBox(height: 4),
                              Text('${idx + 1})  $step',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.grey[800])),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

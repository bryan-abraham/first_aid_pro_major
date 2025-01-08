import 'package:flutter/material.dart';

class WoundDetailsPage extends StatelessWidget {
  final Map<String, dynamic> wound;

  const WoundDetailsPage({super.key, required this.wound});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFAB0B0B),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header section with wound type
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFAB0B0B),
                    Color(0xFFFF5252),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(
                        _getIconForWoundType(wound['Type']),
                        size: 40,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      wound['Type'],
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${wound['steps'].length} Steps • ${wound['requirements'].length} Requirements',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withOpacity(0.9),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Steps section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.format_list_numbered,
                          color: Color(0xFFAB0B0B), size: 24),
                      SizedBox(width: 10),
                      Text(
                        "Treatment Steps",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wound['steps'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Container(
                              width: 32,
                              height: 32,
                              decoration: const BoxDecoration(
                                color: Color(0xFFAB0B0B),
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            title: Text(
                              wound['steps'][index],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),

                  // Requirements section
                  const SizedBox(height: 32),
                  const Row(
                    children: [
                      Icon(Icons.medical_information,
                          color: Color(0xFFAB0B0B), size: 24),
                      SizedBox(width: 10),
                      Text(
                        "Requirements",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2D3142),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: wound['requirements'].length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                spreadRadius: 2,
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons.check_circle,
                              color: Color(0xFFAB0B0B),
                            ),
                            title: Text(
                              wound['requirements'][index],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF2D3142),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForWoundType(String type) {
    switch (type.toLowerCase()) {
      case 'burn':
        return Icons.local_fire_department;
      case 'cut':
        return Icons.content_cut;
      case 'bruise':
        return Icons.circle;
      case 'sprain':
        return Icons.fitness_center;
      case 'fracture':
        return Icons.healing;
      case 'laceration':
        return Icons.cut;
      case 'puncture':
        return Icons.push_pin;
      case 'avulsion':
        return Icons.tornado;
      case 'abrasions':
        return Icons.texture;
      case 'amputation':
        return Icons.cut_sharp;
      default:
        return Icons.medical_services;
    }
  }
}
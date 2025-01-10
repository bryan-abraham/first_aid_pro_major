import 'package:first_aid_pro_app/screen/pick_image/pick_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../core/const/constants.dart';
import '../../services/wound_model_services.dart';
import 'widget/wound_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List woundData = [
    {
      'Image': 'assets/images/Burn.png',
    },
    {
      'Image': 'assets/images/Cut.png',
    },
    {
      'Image': 'assets/images/Bruise.png',
    },
    {
      'Image': 'assets/images/Sprain.png',
    },
    {
      'Image': 'assets/images/Fracture.png',
    },
    {
      'Image': 'assets/images/Laceration.png',
    },
    {
      'Image': 'assets/images/Puncture.png',
    },
    {
      'Image': 'assets/images/Avulsion.png',
    },
    {
      'Image': 'assets/images/Abrasions.png',
    },
    {
      'Image': 'assets/images/Amputation.png',
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            automaticallyImplyLeading: false,
            pinned: false,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 171, 11, 11),
                    Color.fromARGB(255, 255, 255, 255)
                  ],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // leading: IconButton(
            //   icon: Icon(Icons.menu),
            //   onPressed: () {
            //     Navigator.of(context).push(
            //         MaterialPageRoute(builder: (context) => ProfileScreen()));
            //   },
            // ),
            actions: [
              IconButton(
                icon: Image.asset(
                  'assets/images/scanner.png',
                  width: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PickImage(),
                    ),
                  );
                },
              ),
              SizedBox(width: 10)
            ],
            expandedHeight: 100,
            centerTitle: true,
            title: const Column(
              children: [
                Text(
                  'First Aid Pro',
                  style: TextStyle(
                      fontFamily: 'SFBold', fontSize: (30), color: kWhite),
                ),
                Text(
                  'Your First Aid Companion',
                  style: TextStyle(fontSize: 10, color: kWhite),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 255, 194, 194),
                  ],
                  stops: [0, 1],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: FutureBuilder(
                future: loadWoundsData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    }
                    return Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, bottom: 10),
                      child: ListView.builder(
                        primary: false,
                        shrinkWrap: true,
                        itemCount: snapshot.data?.length ?? 0,
                        itemBuilder: (context, index) {
                          var wound = snapshot.data![index];
                          var woundimg = woundData[index];
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        WoundDetailsPage(wound: wound),
                                  ),
                                );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                                elevation: 5,
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  height: 200,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            // Background Image
                                            Container(
                                              height: 200,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20.0),
                                                image: DecorationImage(
                                                  image: AssetImage(
                                                      woundimg['Image']),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),

                                            Positioned(
                                              bottom: 0,
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(18.0),
                                                    bottomRight:
                                                        Radius.circular(18.0),
                                                  ), // Ro

                                                  color: Colors.black.withOpacity(
                                                      0.3), // Ensuring text is visible on any background
                                                ),
                                                height: 50,
                                                width: 340,
                                                padding:
                                                    const EdgeInsets.all(10),
                                                alignment: Alignment.center,
                                                child: Text(
                                                  wound['Type'],
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors
                                                        .white, // Ensuring text is visible on any background
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ));
                        },
                      ),
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

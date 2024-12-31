import 'package:first_aid_pro_app/screen/pick_image/pick_image.dart';
import 'package:flutter/material.dart';

import '../../core/const/constants.dart';
import '../../services/wound_model_services.dart';
import '../profile/profile_screen.dart';
import 'widget/wound_details.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
            leading: IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ProfileScreen()));
              },
            ),
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
                              child: Container(
                                width: double.infinity,
                                height: 200,
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      wound['Type'],
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
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

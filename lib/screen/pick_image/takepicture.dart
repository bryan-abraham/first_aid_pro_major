import 'package:flutter/material.dart';

import '../../core/const/constants.dart';

class TakePictureSection extends SliverFixedExtentList {
  TakePictureSection({Key? key})
      : super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 400,
                  decoration: BoxDecoration(
                    color: kWhite,
                    border: Border.all(color: Colors.redAccent, width: 5),
                    borderRadius: BorderRadius.circular((30)),
                    boxShadow: [
                      BoxShadow(
                        color: kMain.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 145,
                              width: 300,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image:
                                        AssetImage('assets/images/guide.png'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
            childCount: 1,
          ),
          itemExtent: 200,
        );
}

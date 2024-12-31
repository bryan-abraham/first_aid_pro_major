import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../core/const/constants.dart';
import '../../Model/wound_models/wound_model.dart';
import '../../services/hive_database.dart';
import '../../services/wound_provider.dart';

class HistorySection extends SliverFixedExtentList {
  HistorySection(Size size, BuildContext context, WoundService woundService,
      {Key? key})
      : super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return ValueListenableBuilder<Box<Wound>>(
                valueListenable: Boxes.getDiseases().listenable(),
                builder: (context, box, _) {
                  final woundData = box.values.toList().cast<Wound>();

                  if (woundData.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB((0.053 * size.height * 0.3),
                          (0.053 * size.height * 0.3), 0, 0),
                      child: SizedBox(
                          width: size.width,
                          child: ListView.builder(
                            itemCount: woundData.length,
                            padding: EdgeInsets.symmetric(
                                vertical: (0.035 * size.height * 0.3)),
                            itemExtent: size.width * 0.9,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _returnHistoryContainer(woundData[index],
                                  context, woundService, size);
                            },
                          )),
                    );
                  } else {
                    return _returnNothingToShow(size);
                  }
                },
              );
            },
            childCount: 1,
          ),
          itemExtent: size.height * 0.3,
        );
}

Widget _returnHistoryContainer(
    Wound wound, BuildContext context, WoundService woundService, Size size) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
        (0.053 * size.height * 0.3), 0, (0.053 * size.height * 0.3), 0),
    child: GestureDetector(
      onTap: () {
        // Set disease for Disease Service
        woundService.setDiseaseValue(wound);

        // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        //   return Suggestions();
        // }));
      },
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.file(
                File(wound.imagePath),
                fit: BoxFit.cover,
              ).image),
              boxShadow: [
                BoxShadow(
                  color: kAccent,
                  spreadRadius: 0.5,
                  blurRadius: (0.022 * size.height * 0.3),
                ),
              ],
              color: kSecondary,
              borderRadius: BorderRadius.circular((0.053 * size.height * 0.3))),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Type : ${wound.predictedWoundType}',
                    style: TextStyle(
                      color: kWhite,
                      fontSize: (0.066 * size.height * 0.3),
                      fontFamily: 'SFBold',
                    )),
                Text(
                    'Date: ${wound.dateTime.day}/${wound.dateTime.month}/${wound.dateTime.year}',
                    style: TextStyle(
                      color: kWhite,
                      fontSize: (0.066 * size.height * 0.3),
                      fontFamily: 'SFBold',
                    )),
              ],
            ),
          )),
    ),
  );
}

Widget _returnNothingToShow(Size size) {
  return Padding(
    padding: EdgeInsets.fromLTRB((0.053 * size.height * 0.3),
        (0.053 * size.height * 0.3), (0.053 * size.height * 0.3), 0),
    child: Container(
        decoration: BoxDecoration(
            color: kSecondary,
            borderRadius: BorderRadius.circular((0.053 * size.height * 0.3))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, (0.066 * size.height * 0.3)),
          child: const Center(
              child: Text(
            'Nothing to show',
            style: TextStyle(color: kWhite),
          )),
        )),
  );
}

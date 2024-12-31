import 'dart:typed_data';

import 'package:first_aid_pro_app/screen/pick_image/instructions.dart';
import 'package:first_aid_pro_app/services/repository.dart';
import 'package:first_aid_pro_app/services/wound_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Model/Image_upload_model/image_upload_ser.dart';
import '../../core/const/constants.dart';
import '../../Model/wound_models/wound_model.dart';
import '../../services/hive_database.dart';
import '../suggestions_page/suggestions.dart';
import '../widgets/titlesection.dart';
import 'history.dart';
import 'takepicture.dart';

class PickImage extends StatefulWidget {
  const PickImage({Key? key}) : super(key: key);

  static const routeName = '/';

  @override
  State<PickImage> createState() => _PickImageState();
}

class _PickImageState extends State<PickImage> {
  Uint8List? _image;
  XFile? selectedImage;
  late ImageUploadViewModel imageUploadViewModel;

  @override
  void initState() {
    imageUploadViewModel =
        ImageUploadViewModel(repository: context.read<Repository>());
    super.initState();
  }
  // void dispose() {

  //   Hive.close();
  //   super.dispose();
  // }

  Future<void> _handleRefresh() async {}
  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _woundService = Provider.of<WoundService>(context);

    // Hive service
    HiveService _hiveService = HiveService();

    //model
    late Wound _wound;
    // Data
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SpeedDial(
        backgroundColor: kWhite,
        animatedIconTheme: const IconThemeData(size: 28.0),
        elevation: 30,
        tooltip: 'Diagnose',
        label: const Text(
          'Diagnose',
        ),
        icon: Icons.camera,
        spacing: 10,
        children: [
          SpeedDialChild(
            child: const FaIcon(
              FontAwesomeIcons.file,
              color: kWhite,
            ),
            label: "Upload image",
            backgroundColor: kMain,
            onTap: () async {
              await _pickImage(ImageSource.gallery);
              if (selectedImage != null) {
                imageUploadViewModel.uploadUserProfile(
                    selectedImage!.path, context);
                // _wound = Wound(

                //   imagePath: selectedImage!.path,
                // );
                // _woundService.setDiseaseValue(_wound);
                // _hiveService.addDisease(_wound);

                // Navigator.of(context).push(MaterialPageRoute(
                //   builder: (context) {
                //     return Suggestions();
                //   },
                // ));
              }
            },
          ),
          SpeedDialChild(
            child: const FaIcon(
              FontAwesomeIcons.camera,
              color: kWhite,
            ),
            label: "Take photo",
            backgroundColor: kMain,
            onTap: () async {
              _pickImage(ImageSource.camera);
              if (selectedImage != null) {
                imageUploadViewModel.uploadUserProfile(
                    selectedImage!.path, context);
              }
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg4.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: false,
              flexibleSpace: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 171, 11, 11),
                      Color(0xffe8f5fd)
                    ],
                    stops: [0, 1],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                ),
                color: kWhite,
              ),
              expandedHeight: 50,
              centerTitle: true,
              title: const Column(
                children: [
                  Text(
                    'WoundScan',
                    style: TextStyle(
                        fontFamily: 'SFBold', fontSize: (30), color: kWhite),
                  ),
                ],
              ),
            ),
            TitleSection('  Your Report History  ', size.height * 0.044),
            HistorySection(size, context, _woundService),
            TitleSection('  Guide  ', size.height * 0.044),
            TakePictureSection(),
            InstructionsSection(size),
          ],
        ),
        //  ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image != null) {
      selectedImage = image;
      // print(selectedImage!.path);
      Vx.log(selectedImage!.path);
      Vx.log(image);

      // previewImage(
      //     context,
      //     File(
      //       image.path,
      //     ));
    }
  }
}

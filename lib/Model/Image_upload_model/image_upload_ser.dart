import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'package:velocity_bloc/velocity_bloc.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../screen/suggestions_page/suggestions.dart';
import '../../services/repository.dart';

// class ImageUploadViewModel {
//   final Repository repository;

//   ImageUploadViewModel({required this.repository});

//   final VelocityBloc<bool> isLoadingBloc = VelocityBloc<bool>(false);
//   uploadUserProfile(String filePath, context) async {
//     isLoadingBloc.onUpdateData(true);

//     try {
//       var userProfileImgData =
//           await repository.imageUploadViewModelRepo.imageUpload(
//         filePath,
//         context,
//       );

//       Vx.log(userProfileImgData.predictedWoundType.toString());

//       if (userProfileImgData.predictedClass != null) {
//         Vx.log(userProfileImgData.treatmentSteps.toString());
//         Navigator.of(context).push(MaterialPageRoute(
//           builder: (context) {
//             return Suggestions(
//               predictedWoundType:
//                   userProfileImgData.predictedWoundType.toString(),
//               predictedClass: userProfileImgData.predictedClass.toString(),
//               treatmentSteps: userProfileImgData.treatmentSteps.toString(),
//             );
//           },
//         ));
//       } else {
//         return SnackBar(
//           content: Text("Image Not Uploaded"),
//         );
//       }
//     } catch (e) {
//       Vx.log(e.toString());
//     } finally {
//       isLoadingBloc.onUpdateData(false);
//     }
//   }
// }

class ImageUploadViewModel {
  final Repository repository;
  final VelocityBloc<bool> isLoadingBloc = VelocityBloc<bool>(false);

  ImageUploadViewModel({required this.repository});

  uploadUserProfile(String filePath, BuildContext context) async {
    OverlayEntry? loadingOverlay = _createLoadingOverlay(context);
    isLoadingBloc.onUpdateData(true);
    Overlay.of(context).insert(loadingOverlay);

    try {
      var userProfileImgData = await repository.imageUploadViewModelRepo
          .imageUpload(filePath, context);

      Vx.log(userProfileImgData.predictedWoundType.toString());

      if (userProfileImgData.predictedClass != null) {
        Vx.log(userProfileImgData.treatmentSteps.toString());
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => Suggestions(
            predictedWoundType:
                userProfileImgData.predictedWoundType.toString(),
            predictedClass: userProfileImgData.predictedClass.toString(),
            treatmentSteps: userProfileImgData.treatmentSteps.toString(),
          ),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Image Not Uploaded")),
        );
      }
    } catch (e) {
      Vx.log(e.toString());
    } finally {
      isLoadingBloc.onUpdateData(false);
      loadingOverlay.remove();
    }
  }

  OverlayEntry _createLoadingOverlay(BuildContext context) {
    return OverlayEntry(
      builder: (context) => Center(
        child: Lottie.asset(
          'assets/animation/run.json',
          height: 200,
          repeat: true,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

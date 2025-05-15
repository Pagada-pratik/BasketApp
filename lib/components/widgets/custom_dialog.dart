import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/app_colors.dart';

Future<dynamic> customDialog(
    BuildContext context, {
      required String? svgIconPath,
      Color? svgIconColor = AppColors.primaryAppColor,
      required String? dialogText,
      required VoidCallback? onTapForCancel,
      required VoidCallback? onTapForApprove,
      String? cancelText = 'Cancel',
      String? approveText = 'Yes',
    }) {
  return showCupertinoDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: Column(
          children: [
            SvgPicture.asset(
              svgIconPath!,
              height: 60,
              width: 60,
              colorFilter: ColorFilter.mode(
                svgIconColor!,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 10),
            Text(dialogText!, style: const TextStyle(fontSize: 16)),
          ],
        ),
        actions: <Widget>[
          CupertinoDialogAction(
            onPressed: onTapForCancel,
            child: Text(cancelText!, style: const TextStyle(color: AppColors.errorColor)),
          ),
          CupertinoDialogAction(
            onPressed: onTapForApprove,
            child: Text(approveText!, style: const TextStyle(color: AppColors.primaryAppColor)),
          ),
        ],
      );
    },
  );
}
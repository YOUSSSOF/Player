import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:music_test/colors.dart';

class TextIconButton extends StatelessWidget {
  const TextIconButton({
    Key? key,
    required this.text,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  final String text;
  final String icon;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        width: Get.width / 3 - 32,
        padding: const EdgeInsets.only(right: 15),
        decoration: BoxDecoration(
          color: Palette.primary,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 8,
            ),
            SvgPicture.asset(
              icon,
              height: 17,
              width: 17,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.clip,
              ),
            )
          ],
        ),
      ),
    );
  }
}

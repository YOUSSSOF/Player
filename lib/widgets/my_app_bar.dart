import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:music_test/colors.dart';

class MyAppBar extends StatelessWidget {
  const MyAppBar({
    Key? key,
    required this.text,
    required this.icon,
  }) : super(key: key);
  final String text;
  final String icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 19),
      child: Row(
        children: [
          Expanded(
            flex: 8,
            child: Container(
              height: 70,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Palette.primary.withOpacity(1),
                    Palette.primary.withOpacity(0.8),
                    Palette.primary.withOpacity(0.7),
                    Palette.primary.withOpacity(0.6),
                    Palette.primary.withOpacity(0.5),
                    Palette.primary.withOpacity(0.1),
                  ],
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(40),
                  bottomLeft: Radius.circular(5),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  SvgPicture.asset(
                    icon,
                    height: 30,
                    width: 30,
                  ),
                  const SizedBox(
                    width: 13,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            height: 70,
            width: 70,
            decoration: BoxDecoration(
              color: Palette.primary,
              borderRadius: BorderRadius.circular(50),
            ),
            child: SvgPicture.asset(
              'assets/person.svg',
              height: 40,
              width: 40,
            ),
          ),
        ],
      ),
    );
  }
}

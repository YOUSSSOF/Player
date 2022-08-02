import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'package:music_test/colors.dart';
import 'package:music_test/controllers/bottom_navigator_controller.dart';
import 'package:music_test/screens/main.dart';

class MyBottomNavigation extends StatelessWidget {
  MyBottomNavigation(
      {Key? key, this.color = Palette.primary, this.border, this.borderRadius})
      : super(key: key);
  Color color;
  Border? border;
  BorderRadius? borderRadius;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: color,
        border: border ??
            Border.all(
              color: Colors.black,
              width: 1,
            ),
        borderRadius: borderRadius ??
            const BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavIcon(
            icon: 'assets/home.svg',
            text: 'Home',
            index: 0,
            onDoubleTap: () => Get.find<BottomNavigatorController>()
                .scrollToTop(BottomNavigatorIndex.home),
          ),
          BottomNavIcon(
            icon: 'assets/explore.svg',
            text: 'Albums',
            index: 1,
            onDoubleTap: () => Get.find<BottomNavigatorController>()
                .scrollToTop(BottomNavigatorIndex.artists),
          ),
          BottomNavIcon(
            icon: 'assets/playlist.svg',
            text: 'Playlist',
            index: 2,
            onDoubleTap: () => Get.find<BottomNavigatorController>()
                .scrollToTop(BottomNavigatorIndex.playlist),
          ),
        ],
      ),
    );
  }
}

class BottomNavIcon extends StatelessWidget {
  const BottomNavIcon({
    Key? key,
    required this.text,
    required this.icon,
    required this.index,
    required this.onDoubleTap,
  }) : super(key: key);
  final String text;
  final String icon;
  final int index;
  final VoidCallback onDoubleTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<BottomNavigatorController>().index.value == 3 ? Get.to(()=>const Main()) : null;
        Get.find<BottomNavigatorController>().changeIndex(index);
      },
      onDoubleTap: onDoubleTap,
      child: Obx(
        () => Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              width: 40,
              height: 40,
              color: index == Get.find<BottomNavigatorController>().index.value
                  ? Colors.black
                  : Colors.grey.shade800,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: TextStyle(
                color:
                    index == Get.find<BottomNavigatorController>().index.value
                        ? Colors.black
                        : Colors.grey.shade800,
                fontWeight: FontWeight.w100,
              ),
            )
          ],
        ),
      ),
    );
  }
}

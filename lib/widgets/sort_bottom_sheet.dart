import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:music_test/colors.dart';
import 'package:music_test/controllers/music_controller.dart';

class SortBottomSheet extends StatelessWidget {
  const SortBottomSheet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      height: 253,
      decoration: const BoxDecoration(
        color: Color(0xff4C4C4C),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(29),
          topRight: Radius.circular(29),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: const [
              BottomSheetItem(
                text: 'By Title',
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                songSortType: SongSortType.TITLE,
              ),
              SizedBox(
                height: 6,
              ),
              BottomSheetItem(
                text: 'By Artist name',
                songSortType: SongSortType.ARTIST,
              ),
              SizedBox(
                height: 6,
              ),
              BottomSheetItem(
                text: 'By Size',
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(25),
                  bottomRight: Radius.circular(25),
                ),
                songSortType: SongSortType.SIZE,
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 14),
            width: double.infinity,
            height: 39,
            decoration: BoxDecoration(
              color: Palette.primary,
              borderRadius: BorderRadius.circular(25),
            ),
            child: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Center(
                child: ElevatedButton(
                  child: Image.asset('assets/close.png'),
                  onPressed: () => Get.back(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BottomSheetItem extends StatelessWidget {
  const BottomSheetItem({
    Key? key,
    required this.text,
    this.borderRadius,
    required this.songSortType,
  }) : super(key: key);
  final String text;
  final BorderRadius? borderRadius;
  final SongSortType songSortType;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<MusicController>().changeOrder(sort: songSortType),
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.2),
          borderRadius: borderRadius,
        ),
        child: Container(
          margin: const EdgeInsets.only(left: 20),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(text),
          ),
        ),
      ),
    );
  }
}

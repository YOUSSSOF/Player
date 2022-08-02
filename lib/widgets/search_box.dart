import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_test/colors.dart';
import 'package:music_test/controllers/music_controller.dart';

class SearchBox extends StatelessWidget {
  SearchBox({Key? key, required this.onChanged}) : super(key: key);
  final Function(String?) onChanged;
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(
            5,
          ),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(255, 255, 255, 0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            width: Get.width / 3 - 5,
            height: 25,
            child: TextField(
              controller: searchController,
              onChanged: onChanged,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFF707070),
                hintText: 'Search',
                contentPadding: const EdgeInsets.only(top: 10, left: 10),
                hintStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            height: 35,
            width: 35,
            padding: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Palette.primary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: IconButton(
              onPressed: () =>
                  Get.find<MusicController>().search(searchController.text),
              icon: SvgPicture.asset(
                'assets/search.svg',
                height: 35,
                width: 35,
              ),
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}

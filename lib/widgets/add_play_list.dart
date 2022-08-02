import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_test/colors.dart';
import 'package:music_test/controllers/music_controller.dart';
import 'package:music_test/controllers/playlist_controller.dart';

class AddToPLayList extends StatelessWidget {
  AddToPLayList({
    Key? key,
  }) : super(key: key);
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ElevatedButton(
        style: ButtonStyle(
          padding: MaterialStateProperty.all<EdgeInsets>(
            const EdgeInsets.all(15),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(Palette.primary),
        ),
        onPressed: () {
          Get.defaultDialog(
            backgroundColor: Colors.transparent,
            title: 'Create new play list',
            content: TextField(
              controller: controller,
              style: const TextStyle(color: Colors.white),
              autofocus: true,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                border: OutlineInputBorder(),
                hintText: 'Play list name',
                hintStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 8,
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text(
                  'Cancel',
                ),
              ),
              TextButton(
                onPressed: () {
                  if(controller.text.trim().isNotEmpty) {
                    Get.back();
                    Get.find<PlayListController>().createPlaylist(controller.text);
                  }
                },
                child: const Text('Create'),
              ),
            ],
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}

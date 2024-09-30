import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_practice/presentation/home_screen/controller/home_screen_controller.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeScreenController controller =
        Get.put(HomeScreenController(), permanent: true);

    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Obx(() {
              return Stack(
                children: [
                  if (controller.selectedImage.value == null)
                    const CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.amberAccent,
                    )
                  else
                    InkWell(
                      onTap: () {
                        controller.openImage();
                      },
                      child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.amberAccent,
                        backgroundImage:
                            FileImage(controller.selectedImage.value!),
                      ),
                    ),
                  Positioned(
                    top: 85,
                    bottom: 0,
                    left: 80,
                    child: InkWell(
                      onTap: () {
                        controller.pickImage();
                      },
                      child: CircleAvatar(
                        radius: 30,
                        child: Icon(Icons.add),
                      ),
                    ),
                  )
                ],
              );
            })
          ],
        ),
      ),
    );
  }
}

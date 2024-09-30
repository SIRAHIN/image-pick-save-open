import 'dart:io';

import 'package:gal/gal.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';

class HomeScreenController extends GetxController {
  final ImagePicker picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null); // Rx for storing selected image
  final fileName = ''.obs;

  // Method to pick image from camera
  Future<void> pickImage() async {
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final File imageFile = File(pickedFile.path);
      await saveImageToDirectory(imageFile); // Save and display
    }
  }

  // Method to save the image to the application's directory
  Future<void> saveImageToDirectory(File imgFile) async {
    final Directory? appDir = await getExternalStorageDirectory();
    // Use just the file name, not the full path, to save the image
    final String imageName = 'IMG_${DateTime.now().millisecondsSinceEpoch}.jpg';
    fileName.value = '${appDir!.path}/$imageName'; 
    
    final File savedImage = await imgFile.copy(fileName.value);
    await Gal.putImage(fileName.value);
    
    selectedImage.value = savedImage;
  
  }

  // Method to open the saved image using open_file_plus
  Future<void> openImage() async {
    await OpenFile.open(fileName.value);
  }
}
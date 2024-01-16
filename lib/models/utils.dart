import 'package:image_picker/image_picker.dart';

class Utils {
  static Future<String?> pickVideo() async {
    final picker = ImagePicker();
    XFile? videoFile;

    try {
      videoFile = await picker.pickVideo(source: ImageSource.gallery);
      if (videoFile != null) {
        return videoFile.path;
      }
    } catch (e) {
      print('Error Picking Video: $e');
    }
    return null; // Return null if there's any error or no video selected
  }
}

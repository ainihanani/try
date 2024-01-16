import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StoreData {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String?> uploadVideo(String videoPath) async {
    try {
      File videoFile = File(videoPath);
      Reference ref = _storage.ref().child('videos/${DateTime.now().millisecondsSinceEpoch}.mp4');
      await ref.putFile(videoFile);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading video: $e');
      return null;
    }
  }

  Future<void> saveVideoData(String? videoDownloadURL) async {
    if (videoDownloadURL == null) {
      print('Invalid video URL');
      return;
    }
    try {
      await _firestore.collection('videos').add({
        'url': videoDownloadURL,
        'timeStamp': FieldValue.serverTimestamp(),
        'name': 'User Video'
      });
    } catch (e) {
      print('Error saving video data: $e');
    }
  }
}

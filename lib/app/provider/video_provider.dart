import 'package:flutter/material.dart';
import 'package:ruang_ngaji_kita/app/model/video_result.dart';
import 'package:ruang_ngaji_kita/helper/database_helper.dart';

class VideoProvider extends ChangeNotifier {
  List<VideoResult> _videos = [];
  List<VideoResult> get videos => _videos;

  bool _isOnSearch = false;
  bool get isOnSearch => _isOnSearch;

  Future<void> loadVideos() async {
    _videos = await DatabaseHelper.instance.getAllVideoResults();
    notifyListeners();
  }

  Future<int> addVideo(VideoResult video) async {
    return await DatabaseHelper.instance.insertVideoResult(video);
  }

  Future<void> deleteVideo(int id) async {
    await DatabaseHelper.instance.delete(id);
    notifyListeners();
  }

  Future updateVideo(VideoResult video) async {
    await DatabaseHelper.instance.updateVideoResultTitle(video);
    notifyListeners();
  }

  Future<void> searchVideos(query) async {
    _videos = await DatabaseHelper.instance.searchVideos(query);
    notifyListeners();
  }

  void setIsOnSearch(bool val) {
    _isOnSearch = val;
    notifyListeners();
  }
}

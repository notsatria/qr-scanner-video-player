import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:ruang_ngaji_kita/app/home/home_page.dart';
import 'package:ruang_ngaji_kita/app/model/video_result.dart';
import 'package:ruang_ngaji_kita/helper/database_helper.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class VideoPlayerPage extends StatefulWidget {
  const VideoPlayerPage(
      {super.key,
      required this.url,
      this.title = 'Video player',
      this.isFromHome = false});

  final String url;
  final String title;
  final bool isFromHome;

  @override
  State<StatefulWidget> createState() {
    return _VideoPlayerPageState();
  }
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerController _videoPlayerController;
  ChewieController? _chewieController;
  int? bufferDelay;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final dbHelper = DatabaseHelper.instance;
  bool isTitleEmpty = false;
  bool isFormatFileError = false;
  PlayerType playerType = PlayerType.audio;
  final webController = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted);

  @override
  void initState() {
    super.initState();
    getMimeType(widget.url).then((mimeType) {
      if (mimeType?.contains("video") == true) {
        log("Ini adalah file video");
        initializePlayer();
        setState(() {
          playerType = PlayerType.video;
        });
      } else if (mimeType?.contains("html") == true) {
        log("Ini adalah file html");
        setState(() {
          playerType = PlayerType.audio;
          webController.loadRequest(Uri.parse(widget.url));
        });
      } else {
        log("Format tidak dikenali");
        setState(() {
          isFormatFileError = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _chewieController?.dispose();
    titleController.dispose();
    descController.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(widget.url));

    try {
      await Future.wait([
        _videoPlayerController.initialize(),
      ]);
    } on PlatformException catch (e) {
      log('Error on initializePlayer: $e');
      setState(() {
        isFormatFileError = true;
      });
    }
    _createChewieController();
    setState(() {});
  }

  void _createChewieController() {
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      autoPlay: true,
      looping: true,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
      hideControlsTimer: const Duration(seconds: 1),
      allowFullScreen: true,
      showOptions: false,
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      deviceOrientationsOnEnterFullScreen: [DeviceOrientation.landscapeRight],
      autoInitialize: true,
      placeholder: Container(
        color: Colors.grey,
      ),
    );
  }

  Future<String?> getMimeType(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      log('Response ${response.headers}');
      return response
          .headers['content-type']; // e.g. "video/mp4" atau "audio/mpeg"
    } catch (e) {
      log("Error fetching mime type: $e");
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              if (widget.isFromHome) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              } else {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(
          widget.title,
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        backgroundColor: theme.primaryColor,
        actions: [
          (widget.isFromHome || isFormatFileError)
              ? Container()
              : IconButton(
                  onPressed: () {
                    _showSaveVideoConfirmation(context, onSaved: () async {
                      if (titleController.text.isNotEmpty) {
                        int result = await dbHelper.insertVideoResult(
                            VideoResult(
                                title: titleController.text,
                                description: (descController.text.isEmpty)
                                    ? null
                                    : descController.text,
                                url: widget.url));

                        if (result > 0) {
                          descController.clear();
                          titleController.clear();
                          if (widget.isFromHome) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const HomePage()));
                          }
                        }
                      } else {
                        setState(() {
                          isTitleEmpty = true;
                        });
                      }
                    });
                  },
                  icon: Icon(
                    Icons.save,
                    color: theme.indicatorColor,
                  ))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: isFormatFileError
                ? Center(
                    child: _emptyStateWidget(),
                  )
                : (playerType == PlayerType.video)
                    ? Center(
                        child: _chewieController != null &&
                                _chewieController!
                                    .videoPlayerController.value.isInitialized
                            ? Chewie(
                                controller: _chewieController!,
                              )
                            : const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(),
                                  SizedBox(height: 20),
                                  Text('Loading'),
                                ],
                              ),
                      )
                    : WebViewWidget(controller: webController),
          ),
        ],
      ),
    );
  }

  Widget _emptyStateWidget() {
    return Container(
      width: 500,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/quran.png',
            height: 220,
          ),
          const Text(
            'Terjadi kesalahan. Format file tidak didukung',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }

  void _showSaveVideoConfirmation(BuildContext context,
      {required VoidCallback onSaved}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              title: const Text("Simpan hasil scan"),
              content: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        hintText: 'Masukkan judul video',
                        label: const Text('Judul video'),
                        border: const OutlineInputBorder(),
                        errorText:
                            isTitleEmpty ? "Judul tidak boleh kosong" : null),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Masukkan deskripsi video',
                      label: Text('Deskripsi (opsional)'),
                      border: OutlineInputBorder(),
                    ),
                    controller: descController,
                  ),
                ],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      descController.clear();
                      titleController.clear();
                      Navigator.pop(context);
                    },
                    child: const Text("Batal")),
                TextButton(onPressed: onSaved, child: const Text("Simpan"))
              ],
            ));
  }
}

enum PlayerType { video, audio }

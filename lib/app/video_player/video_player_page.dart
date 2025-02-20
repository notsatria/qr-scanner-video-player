import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ruang_ngaji_kita/app/home/home_page.dart';
import 'package:ruang_ngaji_kita/app/model/video_result.dart';
import 'package:ruang_ngaji_kita/helper/database_helper.dart';
import 'package:video_player/video_player.dart';

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

  @override
  void initState() {
    super.initState();
    initializePlayer();
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
    await Future.wait([
      _videoPlayerController.initialize(),
    ]);
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
          (widget.isFromHome)
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
                            Navigator.pop(context);
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
            child: Center(
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
            ),
          ),
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

import 'package:flutter/material.dart';
import 'package:qr_video_player/app/model/video_result.dart';
import 'package:qr_video_player/app/scanner/scanner_page.dart';
import 'package:qr_video_player/helper/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  List<VideoResult> videoResult = [];

  @override
  void initState() {
    super.initState();
    _refreshVideoResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FloatingActionButton.extended(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const ScannerPage()));
            },
            label: const Row(
              spacing: 10,
              children: [Icon(Icons.qr_code_scanner), Text("Scan QR")],
            )),
      ),
      body: ListView.builder(
        itemCount: videoResult.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(videoResult[index].title),
          contentPadding: const EdgeInsets.only().copyWith(left: 12, right: 8),
          trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
        ),
      ),
    );
  }

  Future<void> _refreshVideoResults() async {
    final data = await dbHelper.getAllVideoResults();
    setState(() {
      videoResult = data;
    });
  }
}

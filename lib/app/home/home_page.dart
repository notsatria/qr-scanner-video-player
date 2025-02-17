import 'package:flutter/material.dart';
import 'package:qr_video_player/app/scanner/scanner_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ScannerPage()));
          },
          label: const Row(
            spacing: 5,
            children: [Icon(Icons.qr_code_scanner), Text("Scan QR")],
          )),
    );
  }
}

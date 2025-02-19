import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ruang Ngaji Kita',
          style: TextStyle(color: theme.colorScheme.onPrimary),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
      ),
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0)
                .copyWith(top: 20.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Cari Video',
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                hintText: 'Cari Video',
                suffixIcon: const Icon(Icons.search),
              ),
              onChanged: (query) async {
                final result = await dbHelper.searchVideos(query);
                setState(() {
                  videoResult = result;
                });
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          (videoResult.isNotEmpty)
              ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: videoResult.length,
                    itemBuilder: (context, index) =>
                        _slidableItem(index, theme),
                  ),
                )
              : _emptyStateWidget()
        ],
      ),
    );
  }

  Slidable _slidableItem(int index, ThemeData theme) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {},
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {
              showDeleteConfirmDialog(
                  videoResult[index].id!, videoResult[index].title);
            },
            backgroundColor: theme.colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.restore_from_trash,
            label: 'Hapus',
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          height: 35,
          width: 35,
          decoration: ShapeDecoration(
            shape: StarBorder(
              side: BorderSide(color: theme.primaryColor),
              points: 10.00,
              rotation: 0.00,
              innerRadiusRatio: 0.60,
              pointRounding: 0.35,
              valleyRounding: 0.00,
              squash: 0.00,
            ),
          ),
          child: Center(
              child: Text(
            "${index + 1}".toString(),
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer),
          )),
        ),
        title: Text(
          videoResult[index].title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 18,
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: (videoResult[index].description != null)
            ? Text(
                videoResult[index].description!,
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.outline),
              )
            : null,
        contentPadding: const EdgeInsets.only().copyWith(left: 12, right: 8),
      ),
    );
  }

  void showDeleteConfirmDialog(int id, String title) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Konfirmasi'),
              content: Text('Apakah Anda yakin ingin menghapus item $title?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal')),
                TextButton(
                    onPressed: () {
                      dbHelper.delete(id);
                      Navigator.pop(context);
                    },
                    child: const Text('Hapus'))
              ],
            ));
  }

  Widget _emptyStateWidget() {
    return Container(
      width: 500,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/quran.png',
            height: 220,
          ),
          const Text(
            'Anda belum mengaji hari ini. Klik Scan QR untuk memulai.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          )
        ],
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

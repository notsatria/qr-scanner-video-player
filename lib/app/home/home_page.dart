import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ruang_ngaji_kita/app/model/video_result.dart';
import 'package:ruang_ngaji_kita/app/scanner/scanner_page.dart';
import 'package:ruang_ngaji_kita/app/video_player/video_player_page.dart';
import 'package:ruang_ngaji_kita/helper/database_helper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final dbHelper = DatabaseHelper.instance;
  List<VideoResult> videoResult = [];
  late TextEditingController titleController;
  late TextEditingController descController;
  bool onSearch = false;

  @override
  void initState() {
    super.initState();
    _refreshVideoResults();
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    super.dispose();
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
                  onSearch = query.isNotEmpty;
                });
              },
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          (videoResult.isNotEmpty)
              ? Expanded(
                  child: ListView.separated(
                      separatorBuilder: (_, index) => const Divider(
                            color: Colors.black12,
                          ),
                      shrinkWrap: true,
                      itemCount: videoResult.length,
                      itemBuilder: (context, index) {
                        final video = videoResult[index];
                        return _slidableItem(index, theme, video);
                      }),
                )
              : Expanded(child: _emptyStateWidget(onSearch))
        ],
      ),
    );
  }

  Slidable _slidableItem(int index, ThemeData theme, VideoResult video) {
    return Slidable(
      key: ValueKey(index),
      endActionPane: ActionPane(
        motion: const BehindMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              titleController = TextEditingController(text: video.title);
              descController = TextEditingController(text: video.description);
              _showUpdateVideoConfirmation(context, video);
            },
            backgroundColor: theme.colorScheme.primary,
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Edit',
          ),
          SlidableAction(
            onPressed: (context) {
              showDeleteConfirmDialog(video);
            },
            backgroundColor: theme.colorScheme.error,
            foregroundColor: Colors.white,
            icon: Icons.restore_from_trash,
            label: 'Hapus',
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(
                        url: video.url,
                        title: video.title,
                        isFromHome: true,
                      )));
        },
        leading: Container(
          height: 35,
          width: 35,
          decoration: ShapeDecoration(
            shape: StarBorder(
              side: BorderSide(color: theme.primaryColor, width: 1.50),
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
          video.title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontSize: 18,
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: (video.description != null)
            ? Text(
                video.description!,
                style: theme.textTheme.labelLarge
                    ?.copyWith(color: theme.colorScheme.outline),
              )
            : null,
        contentPadding: const EdgeInsets.only().copyWith(left: 12, right: 8),
      ),
    );
  }

  void _showUpdateVideoConfirmation(BuildContext context, VideoResult video) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog.adaptive(
              title: const Text("Edit Item"),
              content: Column(
                spacing: 16,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Edit judul video',
                      label: Text('Judul video'),
                      border: OutlineInputBorder(),
                    ),
                    controller: titleController,
                  ),
                  TextField(
                    decoration: const InputDecoration(
                      hintText: 'Edit deskripsi video',
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
                TextButton(
                    onPressed: () async {
                      final updatedVideo = VideoResult(
                          id: video.id,
                          title: titleController.text,
                          description: descController.text,
                          url: video.url);
                      final res =
                          await dbHelper.updateVideoResultTitle(updatedVideo);

                      if (res > 0) {
                        descController.clear();
                        titleController.clear();
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Data berhasil diperbarui')));
                        _refreshVideoResults();
                      }
                    },
                    child: const Text("Simpan"))
              ],
            ));
  }

  void showDeleteConfirmDialog(VideoResult video) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text('Konfirmasi'),
              content: Text(
                  'Apakah Anda yakin ingin menghapus item ${video.title}?'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Batal')),
                TextButton(
                    onPressed: () async {
                      final resDelete = await dbHelper.delete(video.id!);
                      if (resDelete > 0) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: const Text('Item berhasill dihapus'),
                          action: SnackBarAction(
                              label: 'Batalkan',
                              onPressed: () async {
                                final res =
                                    await dbHelper.insertVideoResult(video);
                                if (res > 0) {
                                  _refreshVideoResults();
                                }
                              }),
                        ));
                        Navigator.pop(context);
                        _refreshVideoResults();
                      }
                    },
                    child: const Text('Hapus'))
              ],
            ));
  }

  Widget _emptyStateWidget(bool onSearch) {
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
          Text(
            onSearch
                ? 'Hasil tidak ditemukan'
                : 'Anda belum mengaji hari ini. Klik Scan QR untuk memulai.',
            style: const TextStyle(fontSize: 18),
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

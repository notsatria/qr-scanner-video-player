import 'package:flutter/material.dart';
import 'package:qr_video_player/app/home/home_page.dart';
import 'package:qr_video_player/utils/util.dart';
import 'package:qr_video_player/utils/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final brightness = View.of(context).platformDispatcher.platformBrightness;
    TextTheme textTheme = createTextTheme(context, "Source Sans 3", "Source Sans 3");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Ruang Ngaji Kita',
      theme: brightness == Brightness.light ? theme.light() : theme.dark(),
      home: const HomePage(),
    );
  }
}

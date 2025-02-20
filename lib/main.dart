import 'package:flutter/material.dart';
import 'package:ruang_ngaji_kita/app/home/home_page.dart';
import 'package:ruang_ngaji_kita/utils/theme.dart';
import 'package:ruang_ngaji_kita/utils/util.dart';

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
    TextTheme textTheme =
        createTextTheme(context, "Source Sans 3", "Source Sans 3");
    MaterialTheme theme = MaterialTheme(textTheme);
    return MaterialApp(
      title: 'Ruang Ngaji Kita',
      theme: brightness == Brightness.light
          ? theme.light().copyWith(
              appBarTheme: const AppBarTheme(
                  iconTheme: IconThemeData(color: Colors.white)))
          : theme.dark(),
      home: const HomePage(),
    );
  }
}

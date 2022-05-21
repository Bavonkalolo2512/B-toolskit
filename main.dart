import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'data.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _iconBool = false;

  final IconData _iconLight = Icons.wb_sunny;

  final IconData _iconDark = Icons.nights_stay;

  final ThemeData _themeLight = ThemeData(
    primaryColor: Colors.amberAccent,
    brightness: Brightness.light,
  );

  final ThemeData _themeDark = ThemeData(
      primaryColor: Colors.redAccent,
      brightness: Brightness.dark,
      appBarTheme: const AppBarTheme(backgroundColor: Colors.amber));

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _iconBool ? _themeDark : _themeLight,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          centerTitle: true,
          title: const Text('B-Toolskit'),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _iconBool = !_iconBool;
                  });
                },
                icon: Icon(
                  _iconBool ? _iconDark : _iconLight,
                ))
          ],
        ),
        body: const HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: data.map((item) {
        return Card(
          child: ListTile(
            onTap: () => _launchUrl(item['url']),
            leading: CircleAvatar(
                backgroundColor: (Colors.white),
                child: FaIcon(
                  item['icon'],
                  color: item['color'],
                )),
            title: Text(item['name']),
            subtitle: Text(item['Description']),
          ),
        );
      }).toList(),
    );
  }
}

void _launchUrl(String _url) async {
  if (!await launchUrlString(_url)) throw 'Could not launch $_url';
}

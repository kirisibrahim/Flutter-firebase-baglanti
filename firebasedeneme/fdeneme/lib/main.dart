import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String yazi = "";
  final DatabaseReference _led =
      FirebaseDatabase.instance.ref().child("isOpen");
  bool? isOpen;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 152, 74),
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Center(
            child: Text(
              "Arduino Kontrol",
              style: TextStyle(color: Colors.black, shadows: [
                Shadow(color: Colors.black, blurRadius: 6, offset: Offset(4, 4))
              ]),
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                CircleAvatar(
                  radius: 80,
                  //backgroundImage: AssetImage("images/logo.png"),
                ),
              ],
            ),
            const SizedBox(height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isOpen = true;
                      _led.set(isOpen);
                      yazi = "Işık Yandı!!!";
                    });
                  },
                  child: const Text("Yak"),
                ),
                const SizedBox(
                  width: 50,
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isOpen = false;
                      _led.set(isOpen);
                      yazi = "Işık Söndü!!!";
                    });
                  },
                  child: const Text("Söndür"),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  yazi,
                  style: const TextStyle(fontSize: 30),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

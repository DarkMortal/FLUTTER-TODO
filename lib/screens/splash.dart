import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todolistapp/screens/home.dart';

class spalshScreen extends StatefulWidget {
  const spalshScreen({super.key});

  @override
  State<spalshScreen> createState() => _spalshScreenState();
}

class _spalshScreenState extends State<spalshScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    Future.delayed(
        const Duration(seconds: 2),
        () => Navigator.of(context)
            .pushReplacement(MaterialPageRoute(builder: (_) => Home())));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            /*gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.blue.shade500],
                begin: Alignment.topRight,
                end: Alignment.bottomLeft)),*/
            color: Color.fromARGB(255, 238, 237, 238)),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "images/logo.png",
                height: 200,
                width: 200,
              ),
              const SizedBox(height: 15),
              Text("Todos App\nMade by Saptarshi Dey",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abel(
                      textStyle: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 33, 37, 41))))
            ]),
      ),
    );
  }
}

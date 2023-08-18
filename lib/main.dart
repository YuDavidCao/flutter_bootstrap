import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.top]);  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'App',
        theme: ThemeData(
          primarySwatch: const MaterialColor(0xFF0E2C71, {
            50: Color(0xFF0E2C71),
            100: Color(0xFF0E2C71),
            200: Color(0xFF0E2C71),
            300: Color(0xFF0E2C71),
            400: Color(0xFF0E2C71),
            500: Color(0xFF0E2C71),
            600: Color(0xFF0E2C71),
            700: Color(0xFF0E2C71),
            800: Color(0xFF0E2C71),
            900: Color(0xFF0E2C71),
          }),
        ),
        initialRoute: '/Home',
        routes: {
          '/Home': (context) => const HomePage(),
        },
      ),
    );
  }
}

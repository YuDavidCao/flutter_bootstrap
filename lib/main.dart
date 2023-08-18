import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bootstrap/controller/user_state.dart';
import 'package:flutter_bootstrap/pages/add_classroom_page.dart';
import 'package:flutter_bootstrap/pages/login_page.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserState()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'App',
          theme: ThemeData(
            primarySwatch: Colors.amber,
          ),
          initialRoute: '/LoginPage',
          routes: {
            '/LoginPage': (context) => const LoginPage(),
            '/Home': (context) => const HomePage(),
            '/AddClassroomPage': (context) => const AddClassroomPage(),
          },
        ),
      ),
    );
  }
}

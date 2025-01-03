import 'package:chatify_app/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import '../services/navigation_service.dart';
import 'package:get_it/get_it.dart';
import '../firebase_options.dart';
import '../services/media_service.dart';
import '../services/cloud_storage_service.dart';

class SplashPage extends StatefulWidget {
  final VoidCallback onInitializationComplete;

  const SplashPage({
    super.key,
    required this.onInitializationComplete,
  });

  @override
  State<SplashPage> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      Duration(seconds: 5),
    ).then((_) {
      _setup().then((_) {
        return widget.onInitializationComplete();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chatify',
      theme: ThemeData(scaffoldBackgroundColor: Color.fromRGBO(36, 35, 49, 1)),
      home: Scaffold(
        body: Center(
          child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.contain,
                  image: AssetImage('assets/images/meetme.png')),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _setup() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    _registerServices();
  }

  void _registerServices() {
    GetIt.instance.registerSingleton<NavigationService>(
      NavigationService(),
    );

    GetIt.instance.registerSingleton<MediaService>(
      MediaService(),
    );

    GetIt.instance.registerSingleton<CloudStorageService>(
      CloudStorageService(),
    );

    GetIt.instance.registerSingleton<DatabaseService>(
      DatabaseService(),
    );
  }
}

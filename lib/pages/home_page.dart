//packages
import 'package:flutter/material.dart';
//providers
import '../provider/authentication_provider.dart';
//services
import '../services/navigation_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  late AuthenticationProvider _auth;
  late NavigationService _navigation;
  @override
  Widget build(BuildContext context) {
    return _buildUI();
  }

  Widget _buildUI() {
    return const Scaffold();
  }
}

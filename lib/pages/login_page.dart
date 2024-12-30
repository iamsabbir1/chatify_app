//package
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

//providers
import 'package:provider/provider.dart';
import '../provider/authentication_provider.dart';

//widgets
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';

//services
import '../services/navigation_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  String? email;
  String? password;

  late AuthenticationProvider _auth;
  late NavigationService _navigation;

  final _longinFormKey = GlobalKey<FormState>();
  late double _deviceHeight;
  late double _deviceWidth;
  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    _auth = Provider.of<AuthenticationProvider>(context);
    _navigation = GetIt.instance.get<NavigationService>();

    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: _deviceWidth * 0.03,
          vertical: _deviceHeight * 0.02,
        ),
        height: _deviceHeight * 0.98,
        width: _deviceWidth * 0.97,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _pageTitle(),
            SizedBox(
              height: _deviceHeight * 0.04,
            ),
            _loginForm(),
            SizedBox(
              height: _deviceHeight * 0.04,
            ),
            _loginButton(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _registerAccountLink(),
          ],
        ),
      ),
    );
  }

  Widget _pageTitle() {
    return SizedBox(
      height: _deviceHeight * 0.10,
      child: const Text(
        'Chatify',
        style: TextStyle(
          color: Colors.white,
          fontSize: 40.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _loginForm() {
    return SizedBox(
      height: _deviceHeight * 0.18,
      child: Form(
        key: _longinFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  email = value;
                });
              },
              regEx: '',
              hintText: 'Email',
              obscureText: false,
              keyboardType: TextInputType.emailAddress,
            ),
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  password = value;
                });
              },
              regEx: r'.{8,}',
              hintText: 'Password',
              obscureText: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _loginButton() {
    return RoundedButton(
      height: _deviceHeight * 0.065,
      name: 'Login',
      onPressed: () {
        if (_longinFormKey.currentState!.validate()) {
          _longinFormKey.currentState!.save();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$email and $password'),
            ),
          );

          _auth.loginUsingEmailAndPassword(email!, password!);
        }
      },
      width: _deviceWidth * 0.65,
    );
  }

  Widget _registerAccountLink() {
    return GestureDetector(
      onTap: () {
        _navigation.removeAndNavigateToRoute('/register');
      },
      child: const SizedBox(
        child: Text(
          'Don\'t have an account',
          style: TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}

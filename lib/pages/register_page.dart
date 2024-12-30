//packages
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'dart:io';
//services
import '../services/media_service.dart';
import '../services/database_service.dart';
import '../services/cloud_storage_service.dart';

//widget
import '../widgets/custom_input_field.dart';
import '../widgets/rounded_button.dart';
import '../widgets/rounded_image.dart';

//providers
import '../provider/authentication_provider.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends State<RegisterPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  late AuthenticationProvider _auth;
  late DatabaseService _firestore;
  late CloudStorageService _cloudStorageService;

  //PlatformFile? _platformFile;
  File? _file;

  final _registerFormKey = GlobalKey<FormState>();

  String? _name;
  String? _email;
  String? _password;
  @override
  Widget build(BuildContext context) {
    _auth = Provider.of<AuthenticationProvider>(context);
    _firestore = GetIt.instance.get<DatabaseService>();
    _cloudStorageService = GetIt.instance.get<CloudStorageService>();
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;
    return _buildUI();
  }

  Widget _buildUI() {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            _profileImageField(),
            SizedBox(
              height: _deviceHeight * 0.05,
            ),
            _registerForm(),
            SizedBox(
              height: _deviceHeight * 0.02,
            ),
            _registerButton(),
          ],
        ),
      ),
    );
  }

  Widget _profileImageField() {
    return GestureDetector(
      onTap: () {
        GetIt.instance.get<MediaService>().pickImageFromLibray().then((file) {
          if (file != null) {
            setState(() {
              _file = file;
            });
          } else {
            print('no file selected');
          }
        });
      },
      child: _file != null
          ? RoundedImageFile(
              key: UniqueKey(),
              image: _file!,
              size: _deviceHeight * 0.15,
            )
          : RoundedImageNetwork(
              imagePath: 'assets/images/meetme.png',
              size: _deviceHeight * 0.15,
              key: UniqueKey(),
            ),
    );
  }

  Widget _registerForm() {
    return Container(
      height: _deviceHeight * 0.35,
      child: Form(
        key: _registerFormKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CustomTextFormField(
              onSaved: (value) {
                setState(() {
                  _name = value;
                });
              },
              regEx: '',
              hintText: 'Name',
              obscureText: false,
            ),
            CustomTextFormField(
              onSaved: (value) {
                _email = value;
              },
              regEx: '',
              hintText: 'Email',
              obscureText: false,
            ),
            CustomTextFormField(
              onSaved: (value) {
                _password = value;
              },
              regEx: '',
              hintText: 'Password',
              obscureText: true,
            )
          ],
        ),
      ),
    );
  }

  Widget _registerButton() {
    return RoundedButton(
      height: _deviceHeight * 0.065,
      width: _deviceWidth * 0.65,
      name: 'Register',
      onPressed: () async {
        if (_registerFormKey.currentState!.validate() && _file != null) {
          _registerFormKey.currentState!.save();
          String? uid =
              await _auth.registerUsingEmailAndPassword(_email!, _password!);
          String? imageURL =
              await _cloudStorageService.saveUserImageToStorage(uid!, _file!);

          _firestore.createUser(uid, _email!, _name!, imageURL!);
        }
      },
    );
  }
}

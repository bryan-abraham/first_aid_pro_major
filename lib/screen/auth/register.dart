import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/const/validator.dart';
import '../../services/my_app_functions.dart';
import '../widgets/subtitle_text.dart';
import '../widgets/title_text.dart';
import 'widget/image_picker_widget.dart';
import 'widget/loading_manager.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  late final TextEditingController _nameController,
      _emailController,
      _passwordController,
      _repeatPasswordController;

  late final FocusNode _nameFocusNode,
      _emailFocusNode,
      _passwordFocusNode,
      _repeatPasswordFocusNode;

  final _formkey = GlobalKey<FormState>();
  XFile? _pickedImage;
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;
  String? userImageUrl;

  @override
  void initState() {
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _repeatPasswordController = TextEditingController();
    _nameFocusNode = FocusNode();
    _emailFocusNode = FocusNode();
    _passwordFocusNode = FocusNode();
    _repeatPasswordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    if (mounted) {
      _nameController.dispose();
      _emailController.dispose();
      _passwordController.dispose();
      _repeatPasswordController.dispose();
      _nameFocusNode.dispose();
      _emailFocusNode.dispose();
      _passwordFocusNode.dispose();
      _repeatPasswordFocusNode.dispose();
    }
    super.dispose();
  }

  Future<void> _registerFCT() async {
    final isValid = _formkey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (_pickedImage == null) {
      MyAppFunctions.showErrorOrWarningDialog(
        context: context,
        subtitle: "Please pick an image",
        fct: () {},
      );
      return;
    }
    if (isValid) {
      try {
        setState(() {
          _isLoading = true;
        });

        await auth.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final User? user = auth.currentUser;
        final String uid = user!.uid;
        final ref = FirebaseStorage.instance
            .ref()
            .child("usersImages")
            .child("${_emailController.text.trim()}.jpg");
        await ref.putFile(File(_pickedImage!.path));
        userImageUrl = await ref.getDownloadURL();
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'userId': uid,
          'userName': _nameController.text,
          'userImage': userImageUrl,
          'userEmail': _emailController.text.toLowerCase(),
          'createdAt': Timestamp.now(),
          'userWish': [],
          'userCart': [],
        });
        Fluttertoast.showToast(
          msg: "Account created successfully",
          textColor: Colors.white,
        );
        if (!mounted) return;
        // Navigate to the appropriate screen after registration
      } on FirebaseException catch (error) {
        await MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.message.toString(),
          fct: () {},
        );
      } catch (error) {
        await MyAppFunctions.showErrorOrWarningDialog(
          context: context,
          subtitle: error.toString(),
          fct: () {},
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> localImagePicker() async {
    final ImagePicker imagePicker = ImagePicker();
    await MyAppFunctions.imagePickerDialog(
      context: context,
      cameraFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.camera);
        setState(() {});
      },
      galleryFCT: () async {
        _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
        setState(() {});
      },
      removeFCT: () {
        setState(() {
          _pickedImage = null;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: LoadingManager(
          isLoading: _isLoading,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(255, 171, 11, 11),
                  Color.fromARGB(255, 255, 194, 194),
                ],
              ),
            ),
            child: SafeArea(
              child: Center(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.local_hospital,
                          size: 80,
                          color: Colors.white,
                        ),
                        SizedBox(height: 24),
                        TitlesTextWidget(
                          label: "Create Account",
                          fontSize: 32,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        SubtitleTextWidget(
                          label: "Join First Aid Pro",
                          color: Colors.white70,
                        ),
                        SizedBox(height: 32),
                        SizedBox(
                          height: size.width * 0.3,
                          width: size.width * 0.3,
                          child: PickImageWidget(
                            pickedImage: _pickedImage,
                            function: () async {
                              await localImagePicker();
                            },
                          ),
                        ),
                        SizedBox(height: 24),
                        Form(
                          key: _formkey,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: _nameController,
                                focusNode: _nameFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.name,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: 'Full Name',
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(Icons.person, color: Colors.white70),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white70),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_emailFocusNode),
                                validator: (value) => MyValidators.displayNamevalidator(value),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _emailController,
                                focusNode: _emailFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Email address",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(Icons.email, color: Colors.white70),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white70),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_passwordFocusNode),
                                validator: (value) => MyValidators.emailValidator(value),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _passwordController,
                                focusNode: _passwordFocusNode,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: obscureText,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Password",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(Icons.lock, color: Colors.white70),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() => obscureText = !obscureText),
                                    icon: Icon(
                                      obscureText ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white70),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(_repeatPasswordFocusNode),
                                validator: (value) => MyValidators.passwordValidator(value),
                              ),
                              SizedBox(height: 16),
                              TextFormField(
                                controller: _repeatPasswordController,
                                focusNode: _repeatPasswordFocusNode,
                                textInputAction: TextInputAction.done,
                                keyboardType: TextInputType.visiblePassword,
                                obscureText: obscureText,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Repeat password",
                                  hintStyle: TextStyle(color: Colors.white70),
                                  prefixIcon: Icon(Icons.lock, color: Colors.white70),
                                  suffixIcon: IconButton(
                                    onPressed: () => setState(() => obscureText = !obscureText),
                                    icon: Icon(
                                      obscureText ? Icons.visibility : Icons.visibility_off,
                                      color: Colors.white70,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white70),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                onFieldSubmitted: (_) => _registerFCT(),
                                validator: (value) => MyValidators.repeatPasswordValidator(
                                  value: value,
                                  password: _passwordController.text,
                                ),
                              ),
                              SizedBox(height: 24),
                              ElevatedButton(
                                onPressed: _registerFCT,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Color.fromARGB(255, 171, 11, 11), backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text("Sign Up", style: TextStyle(fontSize: 18)),
                              ),
                              SizedBox(height: 16),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context); // Navigate back to login screen
                                },
                                child: Text(
                                  "Already have an account? Login",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:turisteando_ando/resources/auth_methods.dart';
import 'package:turisteando_ando/screensDev/utils/colors.dart';
import 'package:turisteando_ando/screensDev/widgets/text_field_input.dart';
import 'package:turisteando_ando/screensDev/utils/utils.dart';

import 'package:turisteando_ando/screensDev/core/app_export.dart';
import 'package:turisteando_ando/screensDev/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/screensDev/widgets/custom_text_form_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode lasnameFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  Uint8List? _image;
  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _nameController.dispose();
    _lastNameController.dispose();
    nameFocusNode.dispose();
    lasnameFocusNode.dispose();
    passwordFocusNode.dispose();
    emailFocusNode.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void signup() async {
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        name: _nameController.text,
        lastName: _lastNameController.text);
    if (res != 'success') {
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 14.h,
            vertical: 38.v,
          ),
          child: Column(
            children: [
              SizedBox(height: 4.v),
              Container(
                width: 328.h,
                decoration: AppDecoration.outlineBlack,
                child: Text(
                  "Estás a unos pasos de una experiencia turística más personal!",
                  maxLines: null,
                  //overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.headlineSmall!.copyWith(
                    height: 1.41,
                  ),
                ),
              ),
              SizedBox(height: 36.v),
              _buildUser(context),
              SizedBox(height: 16.v),
              _buildTextFieldOutline(context),
              SizedBox(height: 14.v),
              _buildVector(context),
              SizedBox(height: 16.v),
              _buildTextFieldOutline1(context),
              Spacer(),
              _buildRegistrarme(context),
              SizedBox(height: 8.v),
              _buildCancelarQuieroSeguirComo(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUser(BuildContext context) {
    return TextFieldInput(
      focusNode: nameFocusNode,
      textEditingController: _nameController,
      hintText: 'Nombre',
      textInputType: TextInputType.text,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 16.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgUserUser,
          height: 25.v,
          width: 24.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTextFieldOutline(BuildContext context) {
    return TextFieldInput(
      focusNode: lasnameFocusNode,
      textEditingController: _lastNameController,
      hintText: 'Apellidos',
      textInputType: TextInputType.text,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 16.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgPassword1,
          height: 25.v,
          width: 24.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildVector(BuildContext context) {
    return TextFieldInput(
      focusNode: emailFocusNode,
      textEditingController: _emailController,
      hintText: 'Correo',
      textInputType: TextInputType.emailAddress,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 16.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgVector,
          height: 25.v,
          width: 24.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildTextFieldOutline1(BuildContext context) {
    return TextFieldInput(
      focusNode: passwordFocusNode,
      textEditingController: _passwordController,
      hintText: 'Enter your password',
      textInputType: TextInputType.text,
      isPass: true,
      prefix: Container(
        margin: EdgeInsets.fromLTRB(16.h, 17.v, 16.h, 16.v),
        child: CustomImageView(
          imagePath: ImageConstant.imgPassword1,
          height: 25.v,
          width: 24.h,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRegistrarme(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () async {
        String res = await AuthMethods().signUpUser(
            email: _emailController.text,
            password: _passwordController.text,
            name: _nameController.text,
            lastName: _lastNameController.text);
        if (res != 'success') {
          showSnackBar(res, context);
        }
      },
      height: 45.v,
      text: "Registrarme",
      buttonStyle: CustomButtonStyles.fillPrimaryTL22,
      buttonTextStyle: theme.textTheme.titleSmall!,
    );
  }

  /// Section Widget
  Widget _buildCancelarQuieroSeguirComo(BuildContext context) {
    return CustomElevatedButton(
      height: 46.v,
      text: "Cancelar. \nQuiero seguir como invitado.",
      buttonStyle: CustomButtonStyles.radiusTL23,
      buttonTextStyle: theme.textTheme.titleSmall!,
    );
  }
}

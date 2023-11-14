import 'package:flutter/material.dart';
import 'package:turisteando_ando/screensDev/core/app_export.dart';
import 'package:turisteando_ando/screensDev/widgets/custom_elevated_button.dart';
import 'package:turisteando_ando/screensDev/widgets/custom_text_form_field.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'package:turisteando_ando/screensDev/utils/utils.dart';
import 'package:turisteando_ando/resources/auth_methods.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController userNameEditTextController = TextEditingController();

  TextEditingController emailEditTextController = TextEditingController();

  TextEditingController addressEditTextController = TextEditingController();

  TextEditingController passwordEditTextController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Uint8List? _image;

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void updateData() async {
    String res = await AuthMethods().updateProfile(
        email: emailEditTextController.text,
        password: passwordEditTextController.text,
        address: addressEditTextController.text,
        name: userNameEditTextController.text,
        file: _image);
    //if (res != 'success') {
    showSnackBar(res, context);
    //}
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        //resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildEditProfileColumn(context),
              Container(
                decoration: AppDecoration.outlineBlack,
                child: Text(
                  "Cambiar foto",
                  style:
                      TextStyle(fontFamily: 'NunitoBold', color: Colors.black),
                ),
              ),
              SizedBox(height: 23.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Text(
                    "Nombre en pantalla",
                    style: TextStyle(
                        fontFamily: 'NunitoBold', color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 2.v),
              _buildUserNameEditText(context),
              SizedBox(height: 18.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Text(
                    "E-mail",
                    style: TextStyle(
                        fontFamily: 'NunitoBold', color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 3.v),
              _buildEmailEditText(context),
              SizedBox(height: 14.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Text(
                    "Dirección",
                    style: TextStyle(
                        fontFamily: 'NunitoBold', color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 7.v),
              _buildAddressEditText(context),
              SizedBox(height: 17.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 21.h),
                  child: Text(
                    "Contraseña",
                    style: TextStyle(
                        fontFamily: 'NunitoBold', color: Colors.black),
                  ),
                ),
              ),
              SizedBox(height: 4.v),
              _buildPasswordEditText(context),
              SizedBox(height: 65.v),
              _buildUpdateInfoButton(context),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildEditProfileColumn(BuildContext context) {
    return SizedBox(
      height: 200.v,
      width: double.maxFinite,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 135.h,
                vertical: 31.v,
              ),
              //decoration: Border:
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 55.v),
                  Text(
                    " ",
                    style: TextStyle(fontFamily: 'NunitoBold'),
                  ),
                ],
              ),
            ),
          ),
          Stack(
            children: [
              _image != null
                  ? CircleAvatar(
                      radius: 64,
                      backgroundImage: MemoryImage(_image!),
                    )
                  : const CircleAvatar(
                      radius: 64,
                      backgroundImage: NetworkImage(
                          'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'),
                    ),
              Positioned(
                  bottom: -10,
                  left: 80,
                  child: IconButton(
                    onPressed: selectImage,
                    icon: const Icon(Icons.add_a_photo),
                  ))
            ],
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildUserNameEditText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.h),
      child: CustomTextFormField(
        textStyle: TextStyle(color: Colors.black),
        controller: userNameEditTextController,
        hintText: "Nombre",
        hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
        contentPadding: EdgeInsets.all(11.h),
      ),
    );
  }

  /// Section Widget
  Widget _buildEmailEditText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.h),
      child: CustomTextFormField(
        textStyle: TextStyle(color: Colors.black),
        controller: emailEditTextController,
        hintText: "yanchui@gmail.com",
        hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
        textInputType: TextInputType.emailAddress,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 11.v,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildAddressEditText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.h),
      child: CustomTextFormField(
        textStyle: TextStyle(color: Colors.black),
        controller: addressEditTextController,
        hintText: "Calle 123, Colonia Siempreviva, Estado de México...",
        hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.h,
          vertical: 11.v,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildPasswordEditText(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 21.h),
      child: CustomTextFormField(
        textStyle: TextStyle(color: Colors.black),
        controller: passwordEditTextController,
        hintText: "password",
        hintStyle: TextStyle(color: Color(0xFFCCCCCC)),
        textInputAction: TextInputAction.done,
        textInputType: TextInputType.visiblePassword,
        suffix: Container(
          margin: EdgeInsets.fromLTRB(30.h, 10.v, 8.h, 10.v),
          child: CustomImageView(
            imagePath: ImageConstant.imgPassword1,
            height: 17.v,
            width: 18.h,
          ),
        ),
        suffixConstraints: BoxConstraints(
          maxHeight: 40.v,
        ),
        obscureText: true,
        contentPadding: EdgeInsets.only(
          left: 12.h,
          top: 11.v,
          bottom: 11.v,
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildUpdateInfoButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: CustomElevatedButton(
        onPressed: updateData,
        height: 45.v,
        text: "Actualizar información",
        buttonStyle: CustomButtonStyles.fillPrimaryTL22,
        buttonTextStyle: theme.textTheme.titleSmall!,
      ),
    );
  }
}

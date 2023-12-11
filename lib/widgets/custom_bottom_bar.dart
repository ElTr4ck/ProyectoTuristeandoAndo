import 'package:flutter/material.dart';
import 'package:turisteando_ando/core/app_export.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;
  List<bool> selectedStates = [true, false, false, false];

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgIconlyCurvedHome,
      activeIcon: ImageConstant.imgIconlyCurvedHome,
      type: BottomBarEnum.Iconlycurvedhome,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconlyLightTicket,
      activeIcon: ImageConstant.imgIconlyLightTicket,
      type: BottomBarEnum.Iconlylightticket,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconlyLightOutlineHeart,
      activeIcon: ImageConstant.imgIconlyLightOutlineHeart,
      type: BottomBarEnum.Iconlylightoutlineheart,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgIconlyLightProfile,
      activeIcon: ImageConstant.imgIconlyLightProfile,
      type: BottomBarEnum.Iconlylightprofile,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72.v,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          33.h,
        ),
        gradient: LinearGradient(
          begin: Alignment(1, 0.5),
          end: Alignment(-0.76, 0.12),
          colors: [
            appTheme.whiteA700,
            appTheme.gray10002,
          ],
        ),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
            icon: CustomImageView(
              imagePath: bottomMenuList[index].icon,
              height: 24.adaptSize,
              width: 24.adaptSize,
              color: selectedStates[index]
                  ? const Color.fromARGB(255, 20, 76, 95)
                  : Colors.grey,
            ),
            activeIcon: CustomImageView(
              imagePath: bottomMenuList[index].activeIcon,
              height: 20.adaptSize,
              width: 20.adaptSize,
              color: selectedStates[index]
                  ? const Color.fromARGB(255, 20, 76, 95)
                  : Colors.grey,
            ),
            label: '',
          );
        }),
        onTap: (index) {
          for (int i = 0; i < selectedStates.length; i++) {
            selectedStates[i] = (i == index);
          }
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

enum BottomBarEnum {
  Iconlycurvedhome,
  Iconlylightticket,
  Iconlylightoutlineheart,
  Iconlylightprofile,
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  String icon;

  String activeIcon;

  BottomBarEnum type;
}

class DefaultWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetMode extends StatefulWidget {
  @override
  State<BottomSheetMode> createState() => _BottomSheetModeState();
}

class _BottomSheetModeState extends State<BottomSheetMode> {
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.06, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [

          InkWell(
            onTap: () {
             provider.changeAppTheme(ThemeMode.light);
             Navigator.pop(context);
            },
            child: selectedRowLang('Light', provider.appTheme==ThemeMode.light),
          ),
          InkWell(
            onTap: () {
              provider.changeAppTheme(ThemeMode.dark);
              Navigator.pop(context);
            },
            child: selectedRowLang('Dark', provider.appTheme==ThemeMode.dark),
          )
        ],
      ),
    );
  }

  Widget selectedRowLang(String mode, bool isSelected) {
    if (isSelected) {
      return Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${mode}',
              style: TextStyle(
                  color: MyThemeData.primaryLightColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 18),
            ),
            Icon(
              Icons.check,
              color: MyThemeData.greenColor,
            ),
          ],
        ),
      );
    } else
      return Container(
        padding: EdgeInsets.all(8),
        child: Text(
          '${mode}',
          style: TextStyle(
              color: MyThemeData.primaryLightColor,
              fontWeight: FontWeight.w400,
              fontSize: 18),
        ),
      );
  }
}

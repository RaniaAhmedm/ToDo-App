import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomSheetLang extends StatefulWidget {
  @override
  State<BottomSheetLang> createState() => _BottomSheetLangState();
}

class _BottomSheetLangState extends State<BottomSheetLang> {
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
             provider.changeAppLanguage('en');
             Navigator.pop(context);
            },
            child: selectedRowLang('English', provider.appLanguage=='en'),
          ),
          InkWell(
            onTap: () {
              provider.changeAppLanguage('ar');
              Navigator.pop(context);
            },
            child: selectedRowLang('العربية', provider.appLanguage=='ar'),
          )
        ],
      ),
    );
  }

  Widget selectedRowLang(String lang, bool isSelected) {
    if (isSelected) {
      return Container(
        padding: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${lang}',
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
          '${lang}',
          style: TextStyle(
              color: MyThemeData.primaryLightColor,
              fontWeight: FontWeight.w400,
              fontSize: 18),
        ),
      );
  }
}

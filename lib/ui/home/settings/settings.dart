import 'package:app_todo/ui/home/app-provider/app_provider.dart';
import 'package:app_todo/ui/home/my-theme.dart';
import 'package:app_todo/ui/home/settings/bottom-sheet-Lang.dart';
import 'package:app_todo/ui/home/settings/bottom-sheet-Mode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TapSettings extends StatefulWidget {
  static const String routeName = 'settings';

  @override
  State<TapSettings> createState() => _TapSettingsState();
}

class _TapSettingsState extends State<TapSettings> {
  late AppProvider provider;
  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .02,
              horizontal: MediaQuery.of(context).size.height * .02,
            ),
            child: Text(
              AppLocalizations.of(context)!.language,
              style: TextStyle(
                  fontSize: 16,
                  color: provider.appTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .07,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: MyThemeData.primaryLightColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    provider.appLanguage == 'en' ? 'English' : 'العربية',
                    style: TextStyle(
                        color: MyThemeData.primaryLightColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showBotmSheetLang();
                  },
                  icon: Icon(Icons.arrow_drop_down_sharp),
                  color: MyThemeData.primaryLightColor,
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.height * .02,
              horizontal: MediaQuery.of(context).size.height * .02,
            ),
            child: Text(
              AppLocalizations.of(context)!.mode,
              style: TextStyle(
                  fontSize: 16,
                  color: provider.appTheme == ThemeMode.light
                      ? Colors.black
                      : Colors.white,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * .07,
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
                border: Border.all(color: MyThemeData.primaryLightColor)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    provider.appTheme == ThemeMode.light ? 'Light' : 'Dark',
                    style: TextStyle(
                        color: MyThemeData.primaryLightColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showBotmSheetmMode();
                  },
                  icon: Icon(Icons.arrow_drop_down_sharp),
                  color: MyThemeData.primaryLightColor,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void showBotmSheetLang() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        context: (context),
        builder: (context) => BottomSheetLang());
  }

  void showBotmSheetmMode() {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )),
        context: (context),
        builder: (context) => BottomSheetMode());
  }
}

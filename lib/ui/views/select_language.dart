import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poolheatercalculator/app_language.dart';
import 'package:poolheatercalculator/localization.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:poolheatercalculator/ui/widgets/custom_widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SelectLanguageView extends StatefulWidget {
  static const String pathName = 'language';

  @override
  _SelectLanguageViewState createState() => _SelectLanguageViewState();
}

class _SelectLanguageViewState extends State<SelectLanguageView> {
  String groupValue;

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.getString('language_code') == null) {
        groupValue = 'en';
      } else {
        groupValue = prefs.getString('language_code');
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    var appLanguage = Provider.of<AppLanguage>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Text(
            '${AppLocalizations.of(context).translate("change_language")}',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  MobiText(
                    text: AppLocalizations.of(context)
                        .translate("select_language"),
                    textStyle: Theme.of(context)
                        .textTheme
                        .headline6
                        .copyWith(color: Colors.white),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        activeColor: kAccentColor,
                        groupValue: groupValue,
                        value: "en",
                        onChanged: (String value) {
                          setState(() {
                            groupValue = value;
                          });
                        },
                      ),
                      Text(
                        "English",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        activeColor: kAccentColor,
                        groupValue: groupValue,
                        value: "it",
                        onChanged: (String value) {
                          setState(() {
                            groupValue = value;
                          });
                        },
                      ),
                      Text(
                        "Italiano",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        activeColor: kAccentColor,
                        groupValue: groupValue,
                        value: "fr",
                        onChanged: (String value) {
                          setState(() {
                            groupValue = value;
                          });
                        },
                      ),
                      Text(
                        "Français",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        activeColor: kAccentColor,
                        groupValue: groupValue,
                        value: "es",
                        onChanged: (String value) {
                          setState(() {
                            groupValue = value;
                          });
                        },
                      ),
                      Text(
                        "Español",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Radio(
                        activeColor: kAccentColor,
                        groupValue: groupValue,
                        value: "pt",
                        onChanged: (String value) {
                          setState(() {
                            groupValue = value;
                          });
                        },
                      ),
                      Text(
                        "Português",
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  MobiButton(
                    color: kButtonColor,
                    textColor: Colors.black,
                    text:
                        '${AppLocalizations.of(context).translate("set_language")}',
                    onPressed: () async {
                      print(groupValue);
                      await appLanguage.changeLanguage(Locale(groupValue));
                      print(AppLocalizations.of(context)
                          .translate("select_language"));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

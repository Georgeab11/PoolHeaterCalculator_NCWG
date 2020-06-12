import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poolheatercalculator/core/services/authentication_service.dart';
import 'package:poolheatercalculator/core/utils/shared_pref_util.dart';
import 'package:poolheatercalculator/locator.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:poolheatercalculator/ui/views/home_view.dart';
import 'package:poolheatercalculator/ui/views/login_view.dart';
import 'package:poolheatercalculator/ui/widgets/custom_widgets.dart';
import '../../localization.dart';

class IntroductionView extends StatefulWidget {
  static const String pathName = '/';
  bool isFromApp = false;

  setStatus(bool isFromApp) {
    this.isFromApp = isFromApp;
  }

  @override
  _IntroductionViewState createState() => _IntroductionViewState();
}

class _IntroductionViewState extends State<IntroductionView> {
  bool dontShowMessageAgain = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SharedPrefUtil.shouldShowMessageAgain().then((value) {
      dontShowMessageAgain = !value;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: AssetImage('images/logo.png'),
                    width: 200,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text("Pool Heater Calculator",
                      style: Theme.of(context).primaryTextTheme.headline6),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    AppLocalizations.of(context).translate("instructions"),
                    style: TextStyle(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ), //keytool -lis
                  Row(
                    children: <Widget>[
                      Checkbox(
                        activeColor: kAccentColor,
                        value: dontShowMessageAgain,
                        onChanged: (bool value) {
                          dontShowMessageAgain = value;
                          SharedPrefUtil.setDontShowMessageAgain(
                              dontShowMessageAgain);
                          setState(() {});
                        },
                      ),
                      Text(
                        AppLocalizations.of(context)
                            .translate("dont_show_message_again"),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            .copyWith(color: Colors.white),
                      ),
                    ],
                  ),
                  MobiButton(
                    color: kButtonColor,
                    textColor: Colors.black,
                    text: 'OK',
                    onPressed: () async {
                      Navigator.pop(context);
                      if (!widget.isFromApp) {
                        AuthenticationService authenticationServie =
                            locator<AuthenticationService>();
                        String user =
                            await authenticationServie.getCurrentUser();
                        Navigator.pushNamed(
                            context,
                            user != null
                                ? HomeView.pathName
                                : LoginView.pathName);
                      }
                    },
                  ),
                  SizedBox(
                    height: 20,
                  ), //k
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

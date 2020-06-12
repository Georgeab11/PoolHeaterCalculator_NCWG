import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:poolheatercalculator/core/models/user.dart';
import 'package:poolheatercalculator/core/viewmodels/base_model.dart';
import 'package:poolheatercalculator/core/viewmodels/login_model.dart';
import 'package:poolheatercalculator/locator.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:poolheatercalculator/ui/views/base_view.dart';
import 'package:poolheatercalculator/ui/views/home_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  static const pathName = 'login';

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model) {},
      builder: (context, model, child) => Scaffold(
        appBar: null,
        body: Container(
          color: kBackgroundColor,
          child: LoginForm(),
        ),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  LoginForm({
    Key key,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      onModelReady: (model) {
        model.state == ViewState.Busy
            ? BotToast.showLoading()
            : BotToast.closeAllLoading();
      },
      builder: (context, model, child) => Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
            Image(image: AssetImage('images/logo.png')),
            SizedBox(
              height: 150,
            ),
            Center(
              child: GoogleSignInButton(
                onPressed: () async {
                  User response = await model.login();
                  if (response != null) {
                    bool res = await model.updateOrInsertUserToken(response);
                    if (res) {
                      Navigator.pop(context);
                      Navigator.pushNamed(context, HomeView.pathName);
                    } else {
                      BotToast.showText(text: model.errorMessage);
                    }
                  } else {
                    BotToast.showText(text: model.errorMessage);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

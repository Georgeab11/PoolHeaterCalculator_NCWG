import 'package:poolheatercalculator/core/models/user.dart';
import 'package:poolheatercalculator/core/services/authentication_service.dart';
import 'package:poolheatercalculator/core/viewmodels/base_model.dart';
import 'package:poolheatercalculator/locator.dart';

class LoginModel extends BaseModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  Future<User> login() async {
    setState(ViewState.Busy);
    var loginResponse = await _authenticationService.login();
    setState(ViewState.Idle);
    if (loginResponse != null) {
      return loginResponse;
    } else {
      errorMessage = "Sign In failed";
      return loginResponse;
    }
  }

  Future<bool> updateOrInsertUserToken(User user) async {
    setState(ViewState.Busy);
    var loginResponse =
        await _authenticationService.updateOrInsertUserToken(user);
    setState(ViewState.Idle);
    if (loginResponse != null && loginResponse) {
      return true;
    } else {
      errorMessage = "Sign In failed";
      return false;
    }
  }
}

import 'package:get_it/get_it.dart';
import 'package:poolheatercalculator/core/services/api.dart';
import 'package:poolheatercalculator/core/services/authentication_service.dart';
import 'package:poolheatercalculator/core/services/firebase_utils.dart';
import 'package:poolheatercalculator/core/services/home_service.dart';
import 'package:poolheatercalculator/core/utils/shared_pref_util.dart';
import 'package:poolheatercalculator/core/viewmodels/home_model.dart';
import 'package:poolheatercalculator/core/viewmodels/login_model.dart';
import 'package:poolheatercalculator/ui/views/contact_view.dart';
import 'package:poolheatercalculator/ui/views/feedback_view.dart';
import 'package:poolheatercalculator/ui/views/home_view.dart';
import 'package:poolheatercalculator/ui/views/new_reading_view.dart';
import 'package:poolheatercalculator/ui/views/intro_view.dart';
import 'package:poolheatercalculator/ui/views/login_view.dart';
import 'package:poolheatercalculator/ui/views/result_view.dart';
import 'package:poolheatercalculator/ui/views/select_language.dart';

import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => AuthenticationService());
  locator.registerFactory(() => LoginView());
  locator.registerFactory(() => IntroductionView());
  locator.registerFactory(() => LoginModel());

  locator.registerFactory(() => HomeService());
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => NewReadingView());
  locator.registerFactory(() => HomeView());
  locator.registerFactory(() => SharedPrefUtil());
  locator.registerFactory(() => FirebaseUtils());

  locator.registerFactory(() => ResultView());
  locator.registerFactory(() => FeedBackView());
  locator.registerFactory(() => SelectLanguageView());
  locator.registerFactory(() => ContactView());
  locator.registerLazySingleton(() => Api());
}

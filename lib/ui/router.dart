import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poolheatercalculator/locator.dart';
import 'package:poolheatercalculator/ui/views/contact_view.dart';
import 'package:poolheatercalculator/ui/views/feedback_view.dart';
import 'package:poolheatercalculator/ui/views/home_view.dart';

import 'package:poolheatercalculator/ui/views/new_reading_view.dart';
import 'package:poolheatercalculator/ui/views/intro_view.dart';
import 'package:poolheatercalculator/ui/views/login_view.dart';
import 'package:poolheatercalculator/ui/views/result_view.dart';
import 'package:poolheatercalculator/ui/views/select_language.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case IntroductionView.pathName:
        IntroductionView introductionView = locator<IntroductionView>();
        if (settings.arguments != null) {
          introductionView.setStatus(settings.arguments);
        }
        return MaterialPageRoute(builder: (_) => introductionView);
      case HomeView.pathName:
        return MaterialPageRoute(
            builder: (_) => locator<HomeView>(),
            settings: RouteSettings(name: HomeView.pathName));
      case NewReadingView.pathName:
        NewReadingView newReadingView = locator<NewReadingView>();
        if (settings.arguments != null) {
          newReadingView.setPoolData(settings.arguments);
        }
        return MaterialPageRoute(
            builder: (_) => newReadingView,
            settings: RouteSettings(name: NewReadingView.pathName));
      case LoginView.pathName:
        return MaterialPageRoute(
            builder: (_) => locator<LoginView>(),
            settings: RouteSettings(name: LoginView.pathName));
      case FeedBackView.pathName:
        return MaterialPageRoute(
            builder: (_) => locator<FeedBackView>(),
            settings: RouteSettings(name: FeedBackView.pathName));
      case ContactView.pathName:
        return MaterialPageRoute(
            builder: (_) => locator<ContactView>(),
            settings: RouteSettings(name: ContactView.pathName));
      case ResultView.pathName:
        ResultView resultView = locator<ResultView>();
        resultView.setPoolData(settings.arguments);
        return MaterialPageRoute(
            builder: (_) => resultView,
            settings: RouteSettings(name: ResultView.pathName));
      case SelectLanguageView.pathName:
        SelectLanguageView selectLanguageView = locator<SelectLanguageView>();
        return MaterialPageRoute(
            builder: (_) => selectLanguageView,
            settings: RouteSettings(name: SelectLanguageView.pathName));
      default:
        return MaterialPageRoute(builder: (_) {
          return Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          );
        });
    }
  }
}

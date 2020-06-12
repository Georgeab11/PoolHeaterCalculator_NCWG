import 'package:bot_toast/bot_toast.dart';
import 'package:charcode/charcode.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poolheatercalculator/core/models/pool.dart';
import 'package:poolheatercalculator/core/viewmodels/base_model.dart';
import 'package:poolheatercalculator/core/viewmodels/home_model.dart';
import 'package:poolheatercalculator/localization.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:poolheatercalculator/ui/views/base_view.dart';
import 'package:poolheatercalculator/ui/views/contact_view.dart';
import 'package:poolheatercalculator/ui/views/feedback_view.dart';
import 'package:poolheatercalculator/ui/views/intro_view.dart';
import 'package:poolheatercalculator/ui/views/new_reading_view.dart';
import 'package:poolheatercalculator/ui/views/result_view.dart';
import 'package:poolheatercalculator/ui/views/select_language.dart';
import 'package:poolheatercalculator/ui/widgets/custom_widgets.dart';
import 'package:share/share.dart';

class HomeView extends StatefulWidget {
  static const pathName = 'home';

  @override
  _HomeViewState createState() => _HomeViewState();
}

enum ConfirmAction { CANCEL, ACCEPT }

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image(
                  image: AssetImage('images/logo.png'),
                ),
                decoration: BoxDecoration(
                  color: kAccentColor,
                ),
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context).translate("about_app")),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, IntroductionView.pathName,
                      arguments: true);
                },
              ),
              ListTile(
                title:
                    Text(AppLocalizations.of(context).translate("share_app")),
                onTap: () {
                  Navigator.pop(context);
                  final RenderBox box = context.findRenderObject();
                  Share.share(
                      "http://play.google.com/store/apps/details?id=com.georgeabdelnour.poolheatercalculator",
                      subject: "Check out this app",
                      sharePositionOrigin:
                          box.localToGlobal(Offset.zero) & box.size);
                },
              ),
              ListTile(
                title: Text(
                    AppLocalizations.of(context).translate("Contact_Supplier")),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, ContactView.pathName);
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context).translate("Feedback")),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, FeedBackView.pathName);
                },
              ),
              ListTile(
                title: Text(AppLocalizations.of(context).translate("language")),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SelectLanguageView.pathName);
                },
              ),
            ],
          ),
        ),
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Image(
                width: 40,
                image: AssetImage('images/logo.png'),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                AppLocalizations.of(context).translate("saved_projects_list"),
                style: TextStyle(color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: kAccentColor,
          onPressed: () {
            Navigator.pushNamed(context, NewReadingView.pathName);
          },
          child: Icon(
            Icons.add,
            color: Colors.black,
          ),
        ),
        body: BaseView<HomeModel>(
          onModelReady: (model) async {
            model.state == ViewState.Busy
                ? BotToast.showLoading()
                : BotToast.closeAllLoading();
          },
          builder: (context, model, child) => FutureBuilder<String>(
            future: model.getCurrentUser(),
            builder: (context, snapshot) {
              return StreamBuilder<QuerySnapshot>(
                  stream: model.getAllReadingsForCurrentUser(snapshot.data),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<Pool> poolReadings =
                          snapshot.data.documents.map((e) {
                        Pool pool = Pool.fromJson(e.data);
                        pool.uid = e.documentID;
                        return pool;
                      }).toList();
                      return ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemCount: poolReadings.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Dismissible(
                            background: Container(
                              color: Colors.red,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                ),
                              ),
                            ),
                            confirmDismiss: (direction) async {
                              return _asyncConfirmDialog(context);
                            },
                            key: Key(poolReadings[index].uid),
                            direction: DismissDirection.endToStart,
                            onDismissed: (direction) async {
                              await model.deleteEntry(poolReadings[index].uid);
                              BotToast.showText(
                                  text:
                                      '${poolReadings[index].name} deleted successfully');
                            },
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, ResultView.pathName,
                                    arguments: poolReadings[index]);
                              },
                              child: Card(
                                color: Colors.white,
                                elevation: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      MobiText(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                  color: Colors.blue[800]),
                                          text: poolReadings[index].name),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Expanded(
                                            child: MobiText(
                                                textStyle: TextStyle(
                                                    color: Colors.black),
                                                text:
                                                    '${poolReadings[index].waterVolume} m${String.fromCharCodes([
                                                  $sup3
                                                ])}'),
                                          ),
                                          Spacer(),
                                          Expanded(
                                            child: Container(
                                              alignment: Alignment.topRight,
                                              child: MobiText(
                                                  textStyle: TextStyle(
                                                      color: Colors.black),
                                                  text: poolReadings[index]
                                                      .date
                                                      .toString()),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return Container(
                      child: Text('No data found'),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }

  Future<bool> _asyncConfirmDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${AppLocalizations.of(context).translate("delete_project")}',
          ),
          content: Text(
            '${AppLocalizations.of(context).translate("are_you_sure")}',
          ),
          actions: <Widget>[
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate("cancel"),
              ),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            FlatButton(
              child: Text(
                AppLocalizations.of(context).translate("proceed"),
              ),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            )
          ],
        );
      },
    );
  }
}

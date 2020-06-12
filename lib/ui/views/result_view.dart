import 'dart:collection';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:poolheatercalculator/core/models/pool.dart';
import 'package:poolheatercalculator/core/viewmodels/base_model.dart';
import 'package:poolheatercalculator/core/viewmodels/home_model.dart';
import 'package:poolheatercalculator/localization.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:poolheatercalculator/ui/views/base_view.dart';
import 'package:poolheatercalculator/ui/views/home_view.dart';
import 'package:poolheatercalculator/ui/views/new_reading_view.dart';
import 'package:poolheatercalculator/ui/widgets/custom_widgets.dart';

class ResultView extends StatefulWidget {
  Pool _pool;

  static const pathName = "result";

  setPoolData(Pool pool) {
    this._pool = pool;

    this._pool.generateDecimalPoints();
  }

  @override
  _ResultViewState createState() => _ResultViewState();
}

class _ResultViewState extends State<ResultView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget._pool.generateUnits(context);
    print(widget._pool.uid);
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: kAccentColor,
          title: Text(
            '${AppLocalizations.of(context).translate("pool_input_results")} ',
            style: TextStyle(color: Colors.black),
          ),
        ),
        floatingActionButton: Visibility(
            visible: widget._pool.uid != null,
            child: Container(
              margin: EdgeInsets.only(bottom: 60),
              child: FloatingActionButton(
                backgroundColor: kButtonColor,
                child: Icon(Icons.edit),
                onPressed: () {
                  Navigator.popUntil(
                      context, ModalRoute.withName(HomeView.pathName));
                  Navigator.pushNamed(context, NewReadingView.pathName,
                      arguments: widget._pool);
                },
              ),
            )),
        body: BaseView<HomeModel>(
          onModelReady: (model) async {
            model.state == ViewState.Busy
                ? BotToast.showLoading()
                : BotToast.closeAllLoading();
            model.pool = widget._pool;
          },
          builder: (context, model, child) => ResultWidget(model),
        ),
      ),
    );
  }
}

class ResultWidget extends StatefulWidget {
  HomeModel model;

  ResultWidget(this.model);

  @override
  _ResultWidgetState createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
  double gap = 20;
  List<String> keys = [];
  List<String> values = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    keys = widget.model.pool.toJson().keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: keys.length,
              itemBuilder: (BuildContext context, int index) {
                if (index == 0) {
                  return Container();
                } else {
                  String text;
                  if (index > 3) {
                    if (widget.model.pool.toJson()[keys[index]] == null) {
                      text = '-';
                    } else {
                      text = widget.model.pool
                          .toJson()[keys[index]]
                          .toStringAsFixed(
                              widget.model.pool.getDecimalPoints(keys[index]));
                    }
                  } else {
                    text = widget.model.pool.toJson()[keys[index]].toString();
                  }

                  return Column(
                    children: <Widget>[
                      MobiText(
                        textStyle: TextStyle(color: kAccentColor),
                        text: AppLocalizations.of(context)
                                .translate(keys[index]) ??
                            keys[index]
                                .replaceRange(
                                    0,
                                    1,
                                    keys[index]
                                        .substring(
                                          0,
                                          1,
                                        )
                                        .toUpperCase())
                                .replaceAll("_", " "),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      MobiText(
                        border: keys[index] ==
                            'Required_heater_power_in_required_heating_first_time',
                        suffixIcon: Text(
                          widget.model.pool.getUnit(keys[index]),
                          style: Theme.of(context)
                              .textTheme
                              .headline5
                              .copyWith(color: Colors.white),
                        ),
                        textStyle: Theme.of(context)
                            .textTheme
                            .headline6
                            .copyWith(color: Colors.white),
                        text: text,
                      ),
                      SizedBox(
                        height: gap,
                      ),
                    ],
                  );
                }
              },
            ),
          ),
          MobiButton(
            color: kButtonColor,
            textColor: Colors.black,
            text:
                AppLocalizations.of(context).translate("button_save_and_share"),
            onPressed: () async {
              BotToast.showLoading();
              try {
                await widget.model.saveReading();
                await widget.model.generatePDF(context);
              } catch (e) {
                print(e);
              }
              BotToast.closeAllLoading();
              BotToast.showText(
                text:
                    '${AppLocalizations.of(context).translate("project_saved_successfully")} ',
              );
              Navigator.popUntil(
                  context, ModalRoute.withName(HomeView.pathName));
            },
          )
        ],
      ),
    );
  }
}

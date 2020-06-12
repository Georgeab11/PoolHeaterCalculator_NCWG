import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:poolheatercalculator/core/models/elevation.dart' as elvObj;
import 'package:poolheatercalculator/core/models/pool.dart';
import 'package:poolheatercalculator/core/models/weather.dart';
import 'package:poolheatercalculator/core/viewmodels/base_model.dart';
import 'package:poolheatercalculator/core/viewmodels/home_model.dart';
import 'package:poolheatercalculator/localization.dart';
import 'package:poolheatercalculator/ui/shared/constants.dart';
import 'package:poolheatercalculator/ui/views/base_view.dart';
import 'package:poolheatercalculator/ui/views/result_view.dart';
import 'package:poolheatercalculator/ui/widgets/custom_widgets.dart';

class NewReadingView extends StatefulWidget {
  static const pathName = 'newReading';
  Pool _pool;

  @override
  _NewReadingViewState createState() => _NewReadingViewState();

  setPoolData(Pool pool) {
    this._pool = pool;
  }
}

class _NewReadingViewState extends State<NewReadingView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: kBackgroundColor,
          appBar: AppBar(
            backgroundColor: kAccentColor,
            title: Text(
              AppLocalizations.of(context).translate("new_project"),
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: NewReadingWidget(widget._pool)),
    );
  }
}

class NewReadingWidget extends StatefulWidget {
  Pool pool;

  NewReadingWidget(this.pool);

  @override
  _NewReadingWidgetState createState() => _NewReadingWidgetState();
}

class _NewReadingWidgetState extends State<NewReadingWidget> {
  double gap = 20;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('build called');
    final _formKey = GlobalKey<FormState>();
    return BaseView<HomeModel>(
        onModelReady: (model) async {
          if (widget.pool != null) {
            model.pool = widget.pool;
            model.heightLevelController.text = model.pool.heightAboveSeaLevel
                .toStringAsFixed(
                    model.pool.getDecimalPoints('Height_above_sea_level'));
            ;
            model.windSpeedController.text = model.pool.windSpeedOverPoolSurface
                .toStringAsFixed(model.pool
                    .getDecimalPoints('Wind_speed_over_pool_surface'));
            model.relativeHumidityAirController.text =
                model.pool.relativeHumidityTair.toStringAsFixed(
                    model.pool.getDecimalPoints('Relative_humidity_tair'));
            model.ambientAirTempController.text =
                model.pool.ambientAirTemperature.toStringAsFixed(
                    model.pool.getDecimalPoints('Ambient_air_temperature'));
            ;
            model.dateController.text = model.pool.date;
          } else {
            model.pool.activityFactor = 0.1;
            model.pool.heatPumpCOP = 5;
            model.dateController.text =
                DateFormat('dd/MM/yyyy').format(DateTime.now());
            model.pool.date = DateFormat('dd/MM/yyyy').format(DateTime.now());
          }
          model.pool.generateUnits(context);
          model.pool.generateDecimalPoints();

          model.state == ViewState.Busy
              ? BotToast.showLoading()
              : BotToast.closeAllLoading();
        },
        builder: (context, model, child) => Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate('name')} *',
                        keyboardType: TextInputType.text,
                        initialValue: model.pool.name,
                        onChanged: (newText) {
                          model.pool.name = newText;
                        },
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      InkWell(
                        onTap: () async {
                          DateTime date = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2100));
                          model.dateController.text =
                              DateFormat("dd/MM/yyyy").format(date);
                          model.pool.date =
                              DateFormat("dd/MM/yyyy").format(date);
                        },
                        child: MobiTextFormField(
                          label:
                              '${AppLocalizations.of(context).translate('date')} *',
                          isEnabled: false,
                          keyboardType: TextInputType.text,
                          onChanged: (newText) {
                            model.pool.date = newText;
                          },
                          controller: model.dateController,
                          suffixIcon: Icon(
                            Icons.today,
                            color: kAccentColor,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate('pool_length')} *',
                        initialValue: model.pool.poolLength != null
                            ? model.pool.poolLength.toString()
                            : '',
                        keyboardType: TextInputType.number,
                        onChanged: (newText) {
                          model.pool.poolLength = double.parse(newText);
                        },
                        suffixText: model.pool.getUnit("Pool_length"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate('pool_width')} *',
                        initialValue: model.pool.poolWidth != null
                            ? model.pool.poolWidth.toString()
                            : '',
                        keyboardType: TextInputType.number,
                        onChanged: (newText) {
                          model.pool.poolWidth = double.parse(newText);
                        },
                        suffixText: model.pool.getUnit("Pool_width"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate("pool_depth")} *',
                        initialValue: model.pool.poolDepth != null
                            ? model.pool.poolDepth.toString()
                            : '',
                        keyboardType: TextInputType.number,
                        onChanged: (newText) {
                          model.pool.poolDepth = double.parse(newText);
                        },
                        suffixText: model.pool.getUnit("Pool_depth"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                            child: MobiTextFormField(
                              label:
                                  '${AppLocalizations.of(context).translate("elevation_sea_level")} *',
                              keyboardType: TextInputType.number,
                              controller: model.heightLevelController,
                              onChanged: (newText) {
                                model.pool.heightAboveSeaLevel =
                                    double.parse(newText);
                              },
                              suffixText:
                                  model.pool.getUnit("Height_above_sea_level"),
                            ),
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.my_location,
                                color: kAccentColor,
                                size: 40,
                              ),
                            ),
                            onTap: () async {
                              BotToast.showLoading();
                              model.setState(ViewState.Busy);
                              LocationData location = await getLocation();

                              try {
                                WeatherData weatherData =
                                    await model.getWeatherData(location);
                                if (weatherData != null) {
                                  model.ambientAirTempController.text =
                                      (weatherData.main.temp - 273.15)
                                          .toDouble()
                                          .toStringAsFixed(model.pool
                                              .getDecimalPoints(
                                                  'Ambient_air_temperature'));
                                  model.pool.ambientAirTemperature =
                                      (weatherData.main.temp - 273.15)
                                          .toDouble();
                                  model.windSpeedController.text =
                                      weatherData.wind.speed.toStringAsFixed(
                                          model.pool.getDecimalPoints(
                                              'Wind_speed_over_pool_surface'));
                                  model.pool.windSpeedOverPoolSurface =
                                      weatherData.wind.speed.toDouble();

                                  model.relativeHumidityAirController.text =
                                      weatherData.main.humidity.toStringAsFixed(
                                          model.pool.getDecimalPoints(
                                              'Relative_humidity_tair'));
                                  model.pool.relativeHumidityTair =
                                      weatherData.main.humidity.toDouble();
                                } else {
                                  BotToast.showText(
                                      text: 'Error getting weather data');
                                }
                              } catch (e) {
                                BotToast.showText(
                                    text: 'Error getting weather data');
                              }

                              try {
                                elvObj.Elevation elevation =
                                    await model.getElevation(location);
                                if (elevation != null &&
                                    elevation.results.isNotEmpty) {
                                  model.heightLevelController.text = elevation
                                      .results[0].elevation
                                      .toStringAsFixed(model.pool
                                          .getDecimalPoints(
                                              'Height_above_sea_level'));
                                  model.pool.heightAboveSeaLevel =
                                      elevation.results[0].elevation;
                                } else {
                                  BotToast.showText(
                                      text: 'Error getting elevation');
                                }
                              } catch (e) {
                                BotToast.showText(
                                    text: 'Error getting elevation');
                              }

                              model.setState(ViewState.Idle);
                              BotToast.closeAllLoading();
                            },
                          )
                        ],
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate("initial_temp")} *',
                        keyboardType: TextInputType.number,
                        initialValue: model.pool.initialPoolTemperature != null
                            ? model.pool.initialPoolTemperature.toString()
                            : null,
                        onChanged: (newText) {
                          model.pool.initialPoolTemperature =
                              double.parse(newText);
                        },
                        suffixText:
                            model.pool.getUnit("Initial_pool_temperature"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate("desired_temp")} *',
                        initialValue: model.pool.desiredPoolTemperature != null
                            ? model.pool.desiredPoolTemperature.toString()
                            : null,
                        keyboardType: TextInputType.number,
                        onChanged: (newText) {
                          model.pool.desiredPoolTemperature =
                              double.parse(newText);
                        },
                        suffixText:
                            model.pool.getUnit("Desired_pool_temperature"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate("ambient_temp")} *',
                        keyboardType: TextInputType.number,
                        controller: model.ambientAirTempController,
                        onChanged: (newText) {
                          model.pool.ambientAirTemperature =
                              double.parse(newText);
                        },
                        suffixText:
                            model.pool.getUnit("Ambient_air_temperature"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate("humidity")} *',
                        keyboardType: TextInputType.number,
                        controller: model.relativeHumidityAirController,
                        onChanged: (newText) {
                          model.pool.relativeHumidityTair =
                              double.parse(newText);
                        },
                        suffixText:
                            model.pool.getUnit("Relative_humidity_tair"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate("wind_speed")} *',
                        keyboardType: TextInputType.number,
                        controller: model.windSpeedController,
                        onChanged: (newText) {
                          model.pool.windSpeedOverPoolSurface =
                              double.parse(newText);
                        },
                        suffixText:
                            model.pool.getUnit("Wind_speed_over_pool_surface"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiDropDown(
                        hint:
                            '${AppLocalizations.of(context).translate("activity_factor")} *',
                        onChanged: (newText) {
                          model.pool.activityFactor = double.parse(newText);
                          model.setState(ViewState.Idle);
                        },
                        value: model.pool.activityFactor.toString(),
                        items: getActivityFactorDropDowns(),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        validator: (String value) {
                          if (value.isNotEmpty &&
                              model.pool
                                      .timeRequiredToHeatUpThePoolForFirstTime !=
                                  null &&
                              (model.pool.timeRequiredToHeatUpThePoolForFirstTime
                                          .toDouble() >
                                      100 ||
                                  model.pool
                                          .timeRequiredToHeatUpThePoolForFirstTime
                                          .toDouble() <
                                      1)) {
                          } else {
                            return null;
                          }
                        },
                        label:
                            '${AppLocalizations.of(context).translate("time_required_heating")}',
                        keyboardType: TextInputType.number,
                        onChanged: (newText) {
                          model.pool.timeRequiredToHeatUpThePoolForFirstTime =
                              double.parse(newText);
                        },
                        initialValue: model.pool
                                    .timeRequiredToHeatUpThePoolForFirstTime !=
                                null
                            ? model.pool.timeRequiredToHeatUpThePoolForFirstTime
                                .toString()
                            : '',
                        suffixText: model.pool.getUnit(
                            "Time_required_to_heat_up_the_pool_for_first_time"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiTextFormField(
                        label:
                            '${AppLocalizations.of(context).translate("cop_heatpump")} *',
                        keyboardType: TextInputType.number,
                        initialValue: model.pool.heatPumpCOP != null
                            ? model.pool.heatPumpCOP.toString()
                            : '',
                        onChanged: (newText) {
                          model.pool.heatPumpCOP = double.parse(newText);
                        },
                        suffixText: model.pool.getUnit("Heat_pump_COP"),
                      ),
                      SizedBox(
                        height: gap,
                      ),
                      MobiButton(
                        color: kButtonColor,
                        textColor: Colors.black,
                        onPressed: () {
                          print(model.pool.relativeHumidityAtAirTemp);
                          if (!_formKey.currentState.validate()) {
                            BotToast.showText(
                              text:
                                  '${AppLocalizations.of(context).translate("fill_empty_fields")} ',
                            );
                          } else {
                            model.doCalculations();
                            Navigator.pushNamed(context, ResultView.pathName,
                                arguments: model.pool);
                          }
                        },
                        text:
                            '${AppLocalizations.of(context).translate("submit")}',
                      )
                    ],
                  ),
                ),
              ),
            ));
  }

  getLocation() async {
    Location location = new Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    return _locationData;
  }

  getActivityFactorDropDowns() {
    return <DropdownMenuItem<String>>[
      DropdownMenuItem<String>(
        value: '0.1',
        child: Text(
          '${AppLocalizations.of(context).translate("pool_cover")} *',
          style: TextStyle(color: kAccentColor),
        ),
      ),
      DropdownMenuItem<String>(
        value: '0.5',
        child: Text(
            '${AppLocalizations.of(context).translate("residential_pool")} *',
            style: TextStyle(color: kAccentColor)),
      ),
      DropdownMenuItem<String>(
        value: '0.650',
        child: Text(
            '${AppLocalizations.of(context).translate("condominium_pool")} *',
            style: TextStyle(color: kAccentColor)),
      ),
      DropdownMenuItem<String>(
        value: '0.65',
        child: Text(
            '${AppLocalizations.of(context).translate("therapy_pool")} *',
            style: TextStyle(color: kAccentColor)),
      ),
      DropdownMenuItem<String>(
        value: '0.8',
        child: Text('${AppLocalizations.of(context).translate("hotel_pool")} *',
            style: TextStyle(color: kAccentColor)),
      ),
      DropdownMenuItem<String>(
        value: '1',
        child: Text(
            '${AppLocalizations.of(context).translate("public_school_pool")} *',
            style: TextStyle(color: kAccentColor)),
      ),
      DropdownMenuItem<String>(
        value: '1.0',
        child: Text(
            '${AppLocalizations.of(context).translate("whilpool_spa")} *',
            style: TextStyle(color: kAccentColor)),
      ),
      DropdownMenuItem<String>(
        value: '1.5',
        child: Text(
            '${AppLocalizations.of(context).translate("waves_pool_water_slides")} *',
            style: TextStyle(color: kAccentColor)),
      ),
    ];
  }
}

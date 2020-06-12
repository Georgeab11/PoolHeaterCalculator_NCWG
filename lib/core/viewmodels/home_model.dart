import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:location_platform_interface/location_platform_interface.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poolheatercalculator/core/models/pool.dart';
import 'package:poolheatercalculator/core/models/weather.dart';
import 'package:poolheatercalculator/core/services/home_service.dart';
import 'package:poolheatercalculator/core/viewmodels/base_model.dart';
import 'package:poolheatercalculator/localization.dart';
import 'package:poolheatercalculator/locator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class HomeModel extends BaseModel {
  final HomeService _homeService = locator<HomeService>();
  Pool pool = new Pool();
  TextEditingController heightLevelController = new TextEditingController();
  TextEditingController ambientAirTempController = new TextEditingController();
  TextEditingController relativeHumidityAirController =
      new TextEditingController();
  TextEditingController windSpeedController = new TextEditingController();

  TextEditingController dateController = new TextEditingController();

  HomeModel() {
    heightLevelController.text = '';
    ambientAirTempController.text = '';
    relativeHumidityAirController.text = '';
    windSpeedController.text = '';
    dateController.text = '';
  }

  void doCalculations() {
    pool.waterSurfaceArea = pool.poolWidth * pool.poolLength;
    pool.waterVolume = pool.poolWidth * pool.poolLength * pool.poolDepth;
    pool.waterAirTempDiff =
        pool.desiredPoolTemperature - pool.ambientAirTemperature;
    pool.heatTransferCoefficient = 3.53 * pool.windSpeedOverPoolSurface + 11.35;
    pool.nonEvaporativeHeatLoss = pool.waterSurfaceArea *
        pool.heatTransferCoefficient *
        pool.waterAirTempDiff /
        1000;
    pool.airVelocity = 0.2778 * pool.windSpeedOverPoolSurface;
    pool.evaporationCoefficient = 25 + 19 * pool.airVelocity;
    pool.relativeHumidityAtAirTemp = pool.relativeHumidityTair;
    pool.airTemperature = pool.ambientAirTemperature;
    pool.waterTemperature = pool.desiredPoolTemperature;
    pool.atmosphericPressure = 101325 *
        pow((1 - 2.25577 * pow(10, -5) * pool.heightAboveSeaLevel), 5.25588);
    pool.absAirTemperature = pool.airTemperature + 273;
    pool.absWaterTemperature = pool.waterTemperature + 273;
    pool.correlationExp = 77.345 +
        (0.0057 * pool.absWaterTemperature) -
        (7235 / pool.absWaterTemperature);
    pool.saturatedVapourPressureAtTWater =
        exp(pool.correlationExp) / pow(pool.absWaterTemperature, 8.2);
    pool.saturatedHumidityRatioAtWaterTemp = 0.62198 *
        pool.saturatedVapourPressureAtTWater /
        (pool.atmosphericPressure - pool.saturatedVapourPressureAtTWater);
    pool.correlationAirExp = 77.345 +
        (0.0057 * pool.absAirTemperature) -
        (7235 / pool.absAirTemperature);
    pool.saturatedVapourPressureAtTAir =
        exp(pool.correlationAirExp) / pow(pool.absAirTemperature, 8.2);
    pool.partialVapourPressureAtAirTemp = pool.relativeHumidityAtAirTemp *
        pool.saturatedVapourPressureAtTAir /
        100;
    pool.humidityRatioInAirAtAirTemp = 0.62198 *
        pool.partialVapourPressureAtAirTemp /
        (pool.atmosphericPressure - pool.partialVapourPressureAtAirTemp);
    // check this with george
    pool.rateOrWaterEvaporation = pool.evaporationCoefficient *
        pool.waterSurfaceArea *
        (pool.saturatedHumidityRatioAtWaterTemp -
            pool.humidityRatioInAirAtAirTemp) /
        3600;
    pool.activityCorrectedWaterVapour =
        pool.activityFactor * pool.rateOrWaterEvaporation;
    pool.latentHeatOfWaterEvaporation = 2270.0;
    pool.evaporativeHeatLoss =
        pool.activityCorrectedWaterVapour * pool.latentHeatOfWaterEvaporation;

    pool.installedHeaterEffectivePower =
        pool.nonEvaporativeHeatLoss + pool.evaporativeHeatLoss;
    pool.waterTemperatureIncrease =
        pool.desiredPoolTemperature - pool.initialPoolTemperature;
    pool.specificHeatOfWater = 4.184;
    pool.massOfWater = 1000 * pool.waterVolume;
    pool.warmUpTime = pool.installedHeaterEffectivePower == 0
        ? 0
        : pool.massOfWater *
            pool.specificHeatOfWater *
            pool.waterTemperatureIncrease /
            (3600 * pool.installedHeaterEffectivePower);

    pool.minHeaterPowerRequiredToMaintainPoolTemperature =
        pool.nonEvaporativeHeatLoss + pool.evaporativeHeatLoss;

    pool.energyUsedInPoolWarmingElectricHeater =
        pool.warmUpTime * pool.installedHeaterEffectivePower;

    pool.energyUsedInPoolWarmingHeatPump =
        pool.energyUsedInPoolWarmingElectricHeater / pool.heatPumpCOP;

    pool.warmUpTimeMinimumPowerHeater =
        pool.minHeaterPowerRequiredToMaintainPoolTemperature == 0
            ? pool.minHeaterPowerRequiredToMaintainPoolTemperature
            : pool.energyUsedInPoolWarmingElectricHeater /
                pool.minHeaterPowerRequiredToMaintainPoolTemperature;

    pool.waterLossFromPoolByEvaporation = 3600 * pool.rateOrWaterEvaporation;
    pool.energyRequired = 1000 *
        pool.specificHeatOfWater *
        pool.waterTemperatureIncrease *
        pool.waterVolume;

    if (pool.timeRequiredToHeatUpThePoolForFirstTime == 0 ||
        pool.timeRequiredToHeatUpThePoolForFirstTime == null) {
      pool.requiredHeaterPowerInRequiredHeatingFirstTime =
          pool.energyRequired / pool.warmUpTime / 3600;
    } else {
      pool.requiredHeaterPowerInRequiredHeatingFirstTime = pool.energyRequired /
          pool.timeRequiredToHeatUpThePoolForFirstTime /
          3600;
    }
  }

  Future<WeatherData> getWeatherData(LocationData location) {
    return _homeService.getWeatherData(location);
  }

  getElevation(LocationData locationData) {
    return _homeService.getElevation(locationData);
  }

  saveReading() {
    return _homeService.saveReading(pool);
  }

  getAllReadingsForCurrentUser(String currentUser) {
    return _homeService.getAllReadingsForCurrentUser(currentUser);
  }

  getCurrentUser() {
    return _homeService.getCurrentUser();
  }

  generatePDF(BuildContext buildContext) async {
    final pdf = pw.Document();

    Uint8List bytes =
        (await rootBundle.load('images/logo.jpeg')).buffer.asUint8List();

    final image = PdfImage.file(
      pdf.document,
      bytes: bytes,
    );

    List<pw.TableRow> rows = [];
    pool.toJson().forEach((key, value) {
      if (key == 'uid' || key == 'name' || key == 'date') {
        return;
      }
      if (key == 'Pool_length') {
        List<pw.Widget> list = [];
        list.add(pw.Text(
            AppLocalizations.of(buildContext).translate("input_data"),
            style: pw.TextStyle(color: PdfColor.fromHex('0000FF'))));
        rows.add(new pw.TableRow(children: list));
      }

      List<pw.Widget> list = [];
      list.add(pw.Text(AppLocalizations.of(buildContext).translate(key) ??
          key.replaceAll("_", " ")));
      String data;
      if (value == null) {
        data = "-";
      } else {
        data = value is double
            ? value.toStringAsFixed(pool.getDecimalPoints(key)) +
                ' ' +
                pool.getUnit(key)
            : value;
      }

      list.add(pw.Text(data));
      rows.add(new pw.TableRow(children: list));

      if (key == 'Heat_pump_COP') {
        List<pw.Widget> list = [];
        list.add(pw.Text(
            AppLocalizations.of(buildContext).translate(
                "calculation_heat_required_to_maintain_desired_temp"),
            style: pw.TextStyle(color: PdfColor.fromHex('0000FF'))));
        rows.add(new pw.TableRow(children: list));
      } else if (key == 'Evaporative_heat_loss') {
        List<pw.Widget> list = [];
        list.add(pw.Text(
            AppLocalizations.of(buildContext)
                .translate("calculation_of_pool_warmup_time"),
            style: pw.TextStyle(color: PdfColor.fromHex('0000FF'))));
        rows.add(new pw.TableRow(children: list));
      } else if (key == 'Warm_up_time') {
        List<pw.Widget> list = [];
        list.add(pw.Text(AppLocalizations.of(buildContext).translate("result"),
            style: pw.TextStyle(color: PdfColor.fromHex('0000FF'))));
        rows.add(new pw.TableRow(children: list));
      } else if (key == 'Water_loss_from_pool_by_evaporation') {
        List<pw.Widget> list = [];
        list.add(pw.Text(
            AppLocalizations.of(buildContext).translate("final_results"),
            style: pw.TextStyle(color: PdfColor.fromHex('FF0000'))));
        rows.add(new pw.TableRow(children: list));
      }
    });
    pdf.addPage(
      pw.MultiPage(
        margin: pw.EdgeInsets.only(left: 20, top: 10, right: 20, bottom: 10),
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) => <pw.Widget>[
          pw.Column(
            mainAxisAlignment: pw.MainAxisAlignment.start,
            crossAxisAlignment: pw.CrossAxisAlignment.stretch,
            children: [
              pw.Header(
                  level: 0,
                  child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      children: <pw.Widget>[
                        pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.start,
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(pool.name, textScaleFactor: 1.2),
                              pw.SizedBox(height: 10),
                              pw.Text(
                                  '${AppLocalizations.of(buildContext).translate('date')} ${pool.date}',
                                  textScaleFactor: 0.8),
                            ]),
                        pw.Image(image, width: 50, height: 50),
                      ])),
              pw.Table(children: rows),
            ],
          )
        ],
      ),
    );
    // Page
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final String path = '$dir/Report_${pool.name}.pdf';
    final file = File(path);
    await file.writeAsBytes(pdf.save());
    await OpenFile.open(file.path);
  }

  Future<void> deleteEntry(String uid) {
    _homeService.deleteEntry(uid);
  }
}

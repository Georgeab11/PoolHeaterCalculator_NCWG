/*
{
    "waterVolume": 0.1,
    "waterSurfaceArea": 0.1,
    "heightAboveSeaLevel": 0.1,
    "initialPoolTemperature": 0.1,
    "desiredPoolTemperature": 0.1,
    "ambientAirTemperature": 0.1,
    "relativeHumidityTair": 0.1,
    "windSpeedOverPoolSurface": 0.1,
    "activityFactor": 0.1,
    "poolLength": 0.1,
    "poolWidth": 0.1,
    "poolDepth": 0.1,
    "timeRequiredToHeatUpThePoolForFirstTime": 0.1,
    "heatPumpCOP": 0.1,
    "waterAirTempDiff": 0.1,
    "heatTransferCoefficient": 0.1,
    "nonEvaporativeHeatLoss": 0.1,
    "airVelocity": 0.1,
    "evaporationCoefficient": 0.1,
    "relativeHumidityAtAirTemp": 0.1,
    "airTemperature": 0.1,
    "waterTemperature": 0.1,
    "atmosphericPressure": 0.1,
    "absAirTemperature": 0.1,
    "absWaterTemperature": 0.1,
    "correlationExp": 0.1,
    "saturatedVapourPressureAtTWater": 0.1,
    "saturatedHumidityRatioAtWaterTemp": 0.1,
    "correlationAirExp": 0.1,
    "saturatedVapourPressureAtTAir": 0.1,
    "partialVapourPressureAtAirTemp": 0.1,
    "humidityRatioInAirAtAirTemp": 0.1,
    "rateOrWaterEvaporation": 0.1,
    "activityCorrectedWaterVapour": 0.1,
    "latentHeatOfWaterEvaporation": 0.1,
    "evaporativeHeatLoss": 0.1,
    "installedHeaterEffectivePower": 0.1,
    "waterTemperatureIncrease": 0.1,
    "specificHeatOfWater": 0.1,
    "massOfWater": 0.1,
    "warmUptime": 0.1,
    "minHeaterPowerRequiredToMaintainPoolTemperature": 0.1,
    "warmUpTimeMinimumPowerHeater": 0.1,
    "poolWarmUpTimeUsingInstalledHeater": 0.1,
    "energyUsedInPoolWarmingElectricHeater": 0.1,
    "energyUsedInPoolWarmingHeatPump": 0.1,
    "waterLossFromPoolByEvaporation": 0.1,
    "energyRequired":0.1,
    "difference": 0.1,
    "percentage": 0.1,
    "requiredHeaterPowerInRequiredHeatingFirstTime": 0.2
}
 */

/*
{
    "Pool_length": 0.1,
    "Pool_width": 0.1,
    "Pool_depth": 0.1,
    "Water_volume": 0.1,
    "Water_surface_area": 0.1,
    "Height_above_sea_level": 0.1,
    "Initial_pool_temperature": 0.1,
    "Desired_pool_temperature": 0.1,
    "Ambient_air_temperature": 0.1,
    "Relative_humidity_tair": 0.1,
    "Wind_speed_over_pool_surface": 0.1,
    "Activity_factor": 0.1,
    "Time_required_to_heat_up_the_pool_for_first_time": 0.1,
    "Heat_pump_COP": 0.1,
    "Water_air_temp_diff": 0.1,
    "Heat_transfer_coefficient": 0.1,
    "Non_evaporative_heat_loss": 0.1,
    "Air_velocity": 0.1,
    "Evaporation_coefficient": 0.1,
    "Relative_humidity_at_air_temp": 0.1,
    "Air_temperature": 0.1,
    "Water_temperature": 0.1,
    "Atmospheric_pressure": 0.1,
    "Abs_air_temperature": 0.1,
    "Abs_water_temperature": 0.1,
    "Correlation_exp": 0.1,
    "Saturated_vapour_pressure_at_TWater": 0.1,
    "Saturated_humidity_ratio_at_water_temp": 0.1,
    "Correlation_air_exp": 0.1,
    "Saturated_vapour_pressure_at_TAir": 0.1,
    "Partial_vapour_pressure_at_air_temp": 0.1,
    "Humidity_ratio_in_air_at_air_temp": 0.1,
    "Rate_or_water_evaporation": 0.1,
    "Activity_corrected_water_vapour": 0.1,
    "Latent_heat_of_water_evaporation": 0.1,
    "Evaporative_heat_loss": 0.1,
    "Installed_heater_effective_power": 0.1,
    "Water_temperature_increase": 0.1,
    "Specific_heat_of_water": 0.1,
    "Mass_of_water": 0.1,
    "Warm_up_time": 0.1,
    "Min_heater_power_required_to_maintain_pool_temperature": 0.1,
    "Warm_up_time_minimum_power_heater": 0.1,
    "Pool_warm_up_time_using_installed_heater": 0.1,
    "Energy_used_in_pool_warming_electric_heater": 0.1,
    "Energy_used_in_pool_warming_heat_pump": 0.1,
    "Water_loss_from_pool_by_evaporation": 0.1,
    "Energy_required": 0.1,
    "Difference": 0.1,
    "Percentage": 0.1,
    "Required_heater_power_in_required_heating_first_time": 0.2
}
 */

import 'package:charcode/charcode.dart';
import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart';
import 'package:poolheatercalculator/localization.dart';

class Pool {
  String uid;
  String name;
  String date;
  double poolLength;
  double poolWidth;
  double poolDepth;
  double waterVolume;
  double waterSurfaceArea;
  double heightAboveSeaLevel;
  double initialPoolTemperature;
  double desiredPoolTemperature;
  double ambientAirTemperature;
  double relativeHumidityTair;
  double windSpeedOverPoolSurface;
  double activityFactor;
  double timeRequiredToHeatUpThePoolForFirstTime;
  double heatPumpCOP;
  double waterAirTempDiff;
  double heatTransferCoefficient;
  double nonEvaporativeHeatLoss;
  double airVelocity;
  double evaporationCoefficient;
  double relativeHumidityAtAirTemp;
  double airTemperature;
  double waterTemperature;
  double atmosphericPressure;
  double absAirTemperature;
  double absWaterTemperature;
  double correlationExp;
  double saturatedVapourPressureAtTWater;
  double saturatedHumidityRatioAtWaterTemp;
  double correlationAirExp;
  double saturatedVapourPressureAtTAir;
  double partialVapourPressureAtAirTemp;
  double humidityRatioInAirAtAirTemp;
  double rateOrWaterEvaporation;
  double activityCorrectedWaterVapour;
  double latentHeatOfWaterEvaporation;
  double evaporativeHeatLoss;
  double installedHeaterEffectivePower;
  double waterTemperatureIncrease;
  double specificHeatOfWater;
  double massOfWater;
  double warmUpTime;
  double minHeaterPowerRequiredToMaintainPoolTemperature;
  double warmUpTimeMinimumPowerHeater;
  double energyUsedInPoolWarmingElectricHeater;
  double energyRequired;
  double requiredHeaterPowerInRequiredHeatingFirstTime;
  double energyUsedInPoolWarmingHeatPump;
  double waterLossFromPoolByEvaporation;

  Pool({
    this.uid,
    this.name,
    this.date,
    this.poolLength,
    this.poolWidth,
    this.poolDepth,
    this.waterVolume,
    this.waterSurfaceArea,
    this.heightAboveSeaLevel,
    this.initialPoolTemperature,
    this.desiredPoolTemperature,
    this.ambientAirTemperature,
    this.relativeHumidityTair,
    this.windSpeedOverPoolSurface,
    this.activityFactor,
    this.timeRequiredToHeatUpThePoolForFirstTime,
    this.heatPumpCOP,
    this.waterAirTempDiff,
    this.heatTransferCoefficient,
    this.nonEvaporativeHeatLoss,
    this.airVelocity,
    this.evaporationCoefficient,
    this.relativeHumidityAtAirTemp,
    this.airTemperature,
    this.waterTemperature,
    this.atmosphericPressure,
    this.absAirTemperature,
    this.absWaterTemperature,
    this.correlationExp,
    this.saturatedVapourPressureAtTWater,
    this.saturatedHumidityRatioAtWaterTemp,
    this.correlationAirExp,
    this.saturatedVapourPressureAtTAir,
    this.partialVapourPressureAtAirTemp,
    this.humidityRatioInAirAtAirTemp,
    this.rateOrWaterEvaporation,
    this.activityCorrectedWaterVapour,
    this.latentHeatOfWaterEvaporation,
    this.evaporativeHeatLoss,
    this.installedHeaterEffectivePower,
    this.waterTemperatureIncrease,
    this.specificHeatOfWater,
    this.massOfWater,
    this.warmUpTime,
    this.minHeaterPowerRequiredToMaintainPoolTemperature,
    this.warmUpTimeMinimumPowerHeater,
    this.waterLossFromPoolByEvaporation,
    this.energyRequired,
    this.requiredHeaterPowerInRequiredHeatingFirstTime,
    this.energyUsedInPoolWarmingElectricHeater,
    this.energyUsedInPoolWarmingHeatPump,
  });

  Pool.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    date = json['date'];
    poolLength = json['Pool_length'];
    poolWidth = json['Pool_width'];
    poolDepth = json['Pool_depth'];
    waterVolume = json['Water_volume'];
    waterSurfaceArea = json['Water_surface_area'];
    heightAboveSeaLevel = json['Height_above_sea_level'];
    initialPoolTemperature = json['Initial_pool_temperature'];
    desiredPoolTemperature = json['Desired_pool_temperature'];
    ambientAirTemperature = json['Ambient_air_temperature'];
    relativeHumidityTair = json['Relative_humidity_tair'];
    windSpeedOverPoolSurface = json['Wind_speed_over_pool_surface'];
    activityFactor = json['Activity_factor'];
    timeRequiredToHeatUpThePoolForFirstTime =
        json['Time_required_to_heat_up_the_pool_for_first_time'];
    heatPumpCOP = json['Heat_pump_COP'];
    waterAirTempDiff = json['Water_air_temp_diff'];
    heatTransferCoefficient = json['Heat_transfer_coefficient'];
    nonEvaporativeHeatLoss = json['Non_evaporative_heat_loss'];
    airVelocity = json['Air_velocity'];
    evaporationCoefficient = json['Evaporation_coefficient'];
    relativeHumidityAtAirTemp = json['Relative_humidity_at_air_temp'];
    airTemperature = json['Air_temperature'];
    waterTemperature = json['Water_temperature'];
    atmosphericPressure = json['Atmospheric_pressure'];
    absAirTemperature = json['Abs_air_temperature'];
    absWaterTemperature = json['Abs_water_temperature'];
    correlationExp = json['Correlation_exp'];
    saturatedVapourPressureAtTWater =
        json['Saturated_vapour_pressure_at_TWater'];
    saturatedHumidityRatioAtWaterTemp =
        json['Saturated_humidity_ratio_at_water_temp'];
    correlationAirExp = json['Correlation_air_exp'];
    saturatedVapourPressureAtTAir = json['Saturated_vapour_pressure_at_TAir'];
    partialVapourPressureAtAirTemp =
        json['Partial_vapour_pressure_at_air_temp'];
    humidityRatioInAirAtAirTemp = json['Humidity_ratio_in_air_at_air_temp'];
    rateOrWaterEvaporation = json['Rate_or_water_evaporation'];
    activityCorrectedWaterVapour = json['Activity_corrected_water_vapour'];
    latentHeatOfWaterEvaporation = json['Latent_heat_of_water_evaporation'];
    evaporativeHeatLoss = json['Evaporative_heat_loss'];
    installedHeaterEffectivePower = json['Installed_heater_effective_power'];
    waterTemperatureIncrease = json['Water_temperature_increase'];
    specificHeatOfWater = json['Specific_heat_of_water'];
    massOfWater = json['Mass_of_water'];
    warmUpTime = json['Warm_up_time'];
    minHeaterPowerRequiredToMaintainPoolTemperature =
        json['Min_heater_power_required_to_maintain_pool_temperature'];
    warmUpTimeMinimumPowerHeater = json['Warm_up_time_minimum_power_heater'];
    waterLossFromPoolByEvaporation =
        json['Water_loss_from_pool_by_evaporation'];
    energyRequired = json['Energy_required'];
    requiredHeaterPowerInRequiredHeatingFirstTime =
        json['Required_heater_power_in_required_heating_first_time'];
    energyUsedInPoolWarmingElectricHeater =
        json['Energy_used_in_pool_warming_electric_heater'];
    energyUsedInPoolWarmingHeatPump =
        json['Energy_used_in_pool_warming_heat_pump'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['date'] = this.date;
    data['Pool_length'] = this.poolLength;
    data['Pool_width'] = this.poolWidth;
    data['Pool_depth'] = this.poolDepth;
    data['Water_volume'] = this.waterVolume;
    data['Water_surface_area'] = this.waterSurfaceArea;
    data['Height_above_sea_level'] = this.heightAboveSeaLevel;
    data['Initial_pool_temperature'] = this.initialPoolTemperature;
    data['Desired_pool_temperature'] = this.desiredPoolTemperature;
    data['Ambient_air_temperature'] = this.ambientAirTemperature;
    data['Relative_humidity_tair'] = this.relativeHumidityTair;
    data['Wind_speed_over_pool_surface'] = this.windSpeedOverPoolSurface;
    data['Activity_factor'] = this.activityFactor;
    data['Time_required_to_heat_up_the_pool_for_first_time'] =
        this.timeRequiredToHeatUpThePoolForFirstTime;
    data['Heat_pump_COP'] = this.heatPumpCOP;
    data['Water_air_temp_diff'] = this.waterAirTempDiff;
    data['Heat_transfer_coefficient'] = this.heatTransferCoefficient;
    data['Non_evaporative_heat_loss'] = this.nonEvaporativeHeatLoss;
    data['Air_velocity'] = this.airVelocity;
    data['Evaporation_coefficient'] = this.evaporationCoefficient;
    data['Relative_humidity_at_air_temp'] = this.relativeHumidityAtAirTemp;
    data['Air_temperature'] = this.airTemperature;
    data['Water_temperature'] = this.waterTemperature;
    data['Atmospheric_pressure'] = this.atmosphericPressure;
    data['Abs_air_temperature'] = this.absAirTemperature;
    data['Abs_water_temperature'] = this.absWaterTemperature;
    data['Correlation_exp'] = this.correlationExp;
    data['Saturated_vapour_pressure_at_TWater'] =
        this.saturatedVapourPressureAtTWater;
    data['Saturated_humidity_ratio_at_water_temp'] =
        this.saturatedHumidityRatioAtWaterTemp;
    data['Correlation_air_exp'] = this.correlationAirExp;
    data['Saturated_vapour_pressure_at_TAir'] =
        this.saturatedVapourPressureAtTAir;
    data['Partial_vapour_pressure_at_air_temp'] =
        this.partialVapourPressureAtAirTemp;
    data['Humidity_ratio_in_air_at_air_temp'] =
        this.humidityRatioInAirAtAirTemp;
    data['Rate_or_water_evaporation'] = this.rateOrWaterEvaporation;
    data['Activity_corrected_water_vapour'] = this.activityCorrectedWaterVapour;
    data['Latent_heat_of_water_evaporation'] =
        this.latentHeatOfWaterEvaporation;
    data['Evaporative_heat_loss'] = this.evaporativeHeatLoss;
    data['Installed_heater_effective_power'] =
        this.installedHeaterEffectivePower;
    data['Water_temperature_increase'] = this.waterTemperatureIncrease;
    data['Specific_heat_of_water'] = this.specificHeatOfWater;
    data['Mass_of_water'] = this.massOfWater;
    data['Warm_up_time'] = this.warmUpTime;
    data['Min_heater_power_required_to_maintain_pool_temperature'] =
        this.minHeaterPowerRequiredToMaintainPoolTemperature;
    data['Warm_up_time_minimum_power_heater'] =
        this.warmUpTimeMinimumPowerHeater;
    data['Water_loss_from_pool_by_evaporation'] =
        this.waterLossFromPoolByEvaporation;
    data['Energy_required'] = this.energyRequired;
    data['Required_heater_power_in_required_heating_first_time'] =
        this.requiredHeaterPowerInRequiredHeatingFirstTime;
    data['Energy_used_in_pool_warming_electric_heater'] =
        this.energyUsedInPoolWarmingElectricHeater;
    data['Energy_used_in_pool_warming_heat_pump'] =
        this.energyUsedInPoolWarmingHeatPump;
    return data;
  }

  String getUnit(key) {
    return unitsData[key];
  }

  Map<String, dynamic> unitsData;

  void generateUnits(BuildContext context) {
    unitsData = new Map<String, dynamic>();
    unitsData['name'] = ' ';
    unitsData['date'] = ' ';
    unitsData['Pool_length'] = 'm';
    unitsData['Pool_width'] = 'm';
    unitsData['Pool_depth'] = 'm';
    unitsData['Water_volume'] = 'm' + String.fromCharCodes([$sup3]);
    unitsData['Water_surface_area'] = 'm' + String.fromCharCodes([$sup2]);
    unitsData['Height_above_sea_level'] = 'm';
    unitsData['Initial_pool_temperature'] = String.fromCharCodes([$deg]) + 'C';
    unitsData['Desired_pool_temperature'] = String.fromCharCodes([$deg]) + 'C';
    unitsData['Ambient_air_temperature'] = String.fromCharCodes([$deg]) + 'C';
    unitsData['Relative_humidity_tair'] = '%';
    unitsData['Wind_speed_over_pool_surface'] = 'km/h';
    unitsData['Activity_factor'] = ' ';
    unitsData['Time_required_to_heat_up_the_pool_for_first_time'] =
        AppLocalizations.of(context).translate("hours");
    unitsData['Heat_pump_COP'] = ' ';
    unitsData['Water_air_temp_diff'] = String.fromCharCodes([$deg]) + 'C';
    unitsData['Heat_transfer_coefficient'] = 'W/m' +
        String.fromCharCodes([$sup2]) +
        String.fromCharCodes([$deg]) +
        'C';
    unitsData['Non_evaporative_heat_loss'] = 'kW';
    unitsData['Air_velocity'] = 'm/s';
    unitsData['Evaporation_coefficient'] =
        'kg/m' + String.fromCharCodes([$sup2]) + 'h';
    unitsData['Relative_humidity_at_air_temp'] = '%';
    unitsData['Air_temperature'] = String.fromCharCodes([$deg]) + 'C';
    unitsData['Water_temperature'] = String.fromCharCodes([$deg]) + 'C';
    unitsData['Atmospheric_pressure'] = 'Pa';
    unitsData['Abs_air_temperature'] = String.fromCharCodes([$deg]) + 'K';
    unitsData['Abs_water_temperature'] = String.fromCharCodes([$deg]) + 'K';
    unitsData['Correlation_exp'] = '-';
    unitsData['Saturated_vapour_pressure_at_TWater'] = 'Pa';
    unitsData['Saturated_humidity_ratio_at_water_temp'] = 'kg/kg';
    unitsData['Correlation_air_exp'] = '-';
    unitsData['Saturated_vapour_pressure_at_TAir'] = 'Pa';
    unitsData['Partial_vapour_pressure_at_air_temp'] = 'Pa';
    unitsData['Humidity_ratio_in_air_at_air_temp'] = ' ';
    unitsData['Rate_or_water_evaporation'] = 'kg/s';
    unitsData['Activity_corrected_water_vapour'] = 'kg/s';
    unitsData['Latent_heat_of_water_evaporation'] = 'kJ/kg';
    unitsData['Evaporative_heat_loss'] = 'kW';
    unitsData['Installed_heater_effective_power'] = 'kW';
    unitsData['Water_temperature_increase'] =
        String.fromCharCodes([$deg]) + 'C';
    unitsData['Specific_heat_of_water'] =
        'kJ/kg' + String.fromCharCodes([$deg]) + 'C';
    unitsData['Mass_of_water'] = 'kg';
    unitsData['Warm_up_time'] = AppLocalizations.of(context).translate("hours");
    unitsData['Min_heater_power_required_to_maintain_pool_temperature'] = 'kW';
    unitsData['Warm_up_time_minimum_power_heater'] =
        AppLocalizations.of(context).translate("hours");
    unitsData['Water_loss_from_pool_by_evaporation'] = 'kg/h';
    unitsData['Energy_required'] = 'kJ';
    unitsData['Required_heater_power_in_required_heating_first_time'] = 'kW';
    unitsData['Energy_used_in_pool_warming_electric_heater'] = 'kWh';
    unitsData['Energy_used_in_pool_warming_heat_pump'] = 'kWh';
  }

  Map<String, int> decimalData;

  getDecimalPoints(key) {
    if (decimalData.containsKey(key)) {
      return decimalData[key];
    } else {
      return 2;
    }
  }

  void generateDecimalPoints() {
    decimalData = new Map<String, int>();
    decimalData['Name'] = 0;
    decimalData['Date'] = 0;
    decimalData['Heat_pump_COP'] = 0;
    decimalData['Relative_humidity_at_air_temp'] = 3;
    decimalData['Air_temperature'] = 3;
    decimalData['Water_temperature'] = 3;
    decimalData['Atmospheric_pressure'] = 3;
    decimalData['Abs_air_temperature'] = 3;
    decimalData['Abs_water_temperature'] = 3;
    decimalData['Correlation_exp'] = 3;
    decimalData['Saturated_vapour_pressure_at_TWater'] = 3;
    decimalData['Saturated_humidity_ratio_at_water_temp'] = 4;
    decimalData['Correlation_air_exp'] = 3;
    decimalData['Saturated_vapour_pressure_at_TAir'] = 3;
    decimalData['Partial_vapour_pressure_at_air_temp'] = 3;
    decimalData['Humidity_ratio_in_air_at_air_temp'] = 9;
    decimalData['Installed_heater_effective_power'] = 0;
    decimalData['Water_loss_from_pool_by_evaporation'] = 0;
    decimalData['Required_heater_power_in_required_heating_first_time'] = 0;
    decimalData['Energy_used_in_pool_warming_electric_heater'] = 0;
    decimalData['Energy_used_in_pool_warming_heat_pump'] = 0;
    decimalData['Warm_up_time_minimum_power_heater'] = 0;
    decimalData['Time_required_to_heat_up_the_pool_for_first_time'] = 0;
    decimalData['Warm_up_time'] = 0;
    decimalData['Energy_required'] = 0;
  }
}

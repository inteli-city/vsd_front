// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum IncidentTypeEnum {
  SUSPICIOUS_VEHICLE, // peso 1
  SUSPICIOUS_PERSON, // peso 1
  ALARM_TRIGGERED; // peso 2

  Image get image {
    switch (this) {
      case IncidentTypeEnum.SUSPICIOUS_VEHICLE:
        return Image.asset('assets/car.png');
      case IncidentTypeEnum.SUSPICIOUS_PERSON:
        return Image.asset('assets/face.png');
      case IncidentTypeEnum.ALARM_TRIGGERED:
        return Image.asset('assets/housesiren.png');
    }
  }

  String alertMessage() {
    switch (this) {
      case IncidentTypeEnum.SUSPICIOUS_VEHICLE:
        return 'Veículo suspeito';
      case IncidentTypeEnum.SUSPICIOUS_PERSON:
        return 'Pessoa suspeita';
      case IncidentTypeEnum.ALARM_TRIGGERED:
        return 'Alarme disparado';
    }
  }
}

// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum IncidentTypeEnum {
  SUSPICIOUS_VEHICLE, // peso 1
  SUSPICIOUS_PERSON, // peso 1
  ALARM_TRIGGERED; // peso 2

  IconData get icon {
    switch (this) {
      case IncidentTypeEnum.SUSPICIOUS_VEHICLE:
        return Icons.directions_car;
      case IncidentTypeEnum.SUSPICIOUS_PERSON:
        return Icons.person;
      case IncidentTypeEnum.ALARM_TRIGGERED:
        return Icons.warning;
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

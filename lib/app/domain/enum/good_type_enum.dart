// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum GoodTypeEnum {
  POLICE;

  IconData get icon {
    switch (this) {
      case GoodTypeEnum.POLICE:
        return Icons.local_police;
    }
  }

  String alertMessage() {
    switch (this) {
      case GoodTypeEnum.POLICE:
        return 'Polícia nas redondezas';
    }
  }
}

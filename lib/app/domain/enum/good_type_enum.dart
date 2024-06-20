// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

enum GoodTypeEnum {
  POLICE;

  Image get image {
    switch (this) {
      case GoodTypeEnum.POLICE:
        return Image.asset('assets/policeman.png');
    }
  }

  String alertMessage() {
    switch (this) {
      case GoodTypeEnum.POLICE:
        return 'Polícia nas redondezas';
    }
  }
}

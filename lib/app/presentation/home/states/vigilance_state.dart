import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/failures/failures.dart';

abstract class VigilanceState {
  const VigilanceState();
}

class VigilanceInitialState extends VigilanceState {}

class VigilanceLoadingState extends VigilanceState {}

class VigilanceErrorState extends VigilanceState {
  final Failure error;

  const VigilanceErrorState({required this.error});
}

class VigilanceSuccessState extends VigilanceState {
  final VigilanceEntity vigilance;

  const VigilanceSuccessState({required this.vigilance});
}

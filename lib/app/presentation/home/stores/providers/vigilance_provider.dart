import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/incident_near_user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/usecases/create_incident_usecase.dart';
import 'package:flutter_clean_architecture_template/app/domain/usecases/fetch_vigilances_usecase.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/vigilance_state.dart';
import 'package:flutter_clean_architecture_template/app/shared/helpers/functions/global_snackbar.dart';
import 'package:logger/logger.dart';

class VigilanceProvider with ChangeNotifier {
  final IFetchVigilancesUsecase _fetchVigilance;
  final ICreateIncidentUsecase _createIncident;

  VigilanceProvider(
    this._fetchVigilance,
    this._createIncident,
  );

  VigilanceState state = VigilanceInitialState();

  void setState(VigilanceState value) {
    state = value;
    notifyListeners();
  }

  Future<void> fetchVigilance() async {
    setState(VigilanceLoadingState());
    final result = await _fetchVigilance();
    setState(
      result.fold(
        (error) {
          GlobalSnackBar.error(error.message);
          return VigilanceErrorState(error: error);
        },
        (vigilance) {
          injector.get<Logger>().d(
                '${DateTime.now()} - Vigilances fetched successfully!',
              );
          return VigilanceSuccessState(vigilance: vigilance);
        },
      ),
    );
  }

  bool loading = false;

  void setLoading(bool value) {
    loading = value;
    notifyListeners();
  }

  Future<void> createIncident(
      IncidentNearUserEntity incidentNearUserEntity) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    final result = await _createIncident(incidentNearUserEntity);
    setState(
      result.fold(
        (error) {
          GlobalSnackBar.error(error.message);
          return VigilanceErrorState(error: error);
        },
        (vigilance) {
          injector.get<Logger>().d(
                '${DateTime.now()} - Incident created successfully!',
              );
          return VigilanceSuccessState(vigilance: vigilance);
        },
      ),
    );
    setLoading(false);
  }
}

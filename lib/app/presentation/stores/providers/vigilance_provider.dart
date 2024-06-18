import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/usecases/fetch_vigilances_usecase.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/states/vigilance_state.dart';
import 'package:flutter_clean_architecture_template/app/shared/helpers/functions/global_snackbar.dart';
import 'package:logger/logger.dart';

class VigilanceProvider with ChangeNotifier {
  final IFetchVigilancesUsecase _fetchVigilance;

  VigilanceProvider(
    this._fetchVigilance,
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
        (vigilances) {
          injector.get<Logger>().d(
                '${DateTime.now()} - Vigilances fetched successfully!',
              );
          return VigilanceSuccessState(vigilances: vigilances);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/usecases/fetch_user_usecase.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/states/user_state.dart';
import 'package:flutter_clean_architecture_template/app/shared/helpers/functions/global_snackbar.dart';
import 'package:logger/logger.dart';

class UserProvider with ChangeNotifier {
  final IFetchUserUsecase _fetchUser;

  UserProvider(
    this._fetchUser,
  );

  UserState state = UserInitialState();

  void setState(UserState value) {
    state = value;
    notifyListeners();
  }

  Future<void> fetchUser() async {
    setState(UserLoadingState());
    final result = await _fetchUser();
    setState(
      result.fold(
        (error) {
          GlobalSnackBar.error(error.message);
          return UserErrorState(error: error);
        },
        (user) {
          injector.get<Logger>().d(
                '${DateTime.now()} - Users fetched successfully!',
              );
          return UserSuccessState(user: user);
        },
      ),
    );
  }
}

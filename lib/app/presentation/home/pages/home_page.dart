import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/user_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/vigilance_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/user_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/vigilance_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/widgets/vigilance_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      var userState = userProvider.state;
      return Consumer<VigilanceProvider>(
          builder: (context, vigilanceProvider, child) {
        var vigilanceState = vigilanceProvider.state;
        return vigilanceState is VigilanceSuccessState
            ? buildSuccess(userState as UserSuccessState, vigilanceState)
            : vigilanceState is VigilanceErrorState
                ? buildError(vigilanceState)
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurpleAccent,
                    ),
                  );
      });
    });
  }

  Widget buildSuccess(
      UserSuccessState userState, VigilanceSuccessState vigilanceState) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: VigilanceWidget(
          vigilance: vigilanceState.vigilance,
        ),
      );
    });
  }

  Widget buildError(VigilanceErrorState errorState) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          injector.get<UserProvider>().fetchUser();
        },
        child: const Text('Try again'),
      ),
    );
  }
}

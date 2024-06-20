import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/vigilance_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/user_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/vigilance_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/widgets/concentric_circles_widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<VigilanceProvider>(
        builder: (context, vigilanceProvider, child) {
      var vigilanceState = vigilanceProvider.state;
      return vigilanceState is VigilanceSuccessState
          ? buildSuccess(vigilanceState.vigilance)
          : vigilanceState is VigilanceErrorState
              ? buildError(vigilanceState)
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),
                );
    });
  }

  Widget buildSuccess(VigilanceEntity vigilance) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          children: [
            ConcentricCirclesWidget(
              vigilance: vigilance,
              points: injector.get<VigilanceProvider>().points,
            ),
            Text(
              injector.get<VigilanceProvider>().alertMessage,
              style: Theme.of(context).textTheme.headlineLarge,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            for (var incident in vigilance.incidents)
              Text(
                incident.type.alertMessage(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            for (var good in vigilance.goods)
              Text(
                good.type.alertMessage(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
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

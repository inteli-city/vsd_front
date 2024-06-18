import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/user_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/user_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/vigilance_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => injector.get<UserProvider>()..fetchUser(),
        ),
        ChangeNotifierProvider(
          create: (_) => injector.get<VigilanceProvider>()..fetchVigilance(),
        ),
      ],
      child: Scaffold(
        body: Consumer<UserProvider>(builder: (context, todoNotifier, child) {
          var state = todoNotifier.state;
          return state is UserSuccessState
              ? buildSuccess(state)
              : state is UserErrorState
                  ? buildError(state)
                  : const Center(
                      child: CircularProgressIndicator(
                        color: Colors.deepPurpleAccent,
                      ),
                    );
        }),
      ),
    );
  }

  Widget buildSuccess(UserSuccessState successState) {
    return const Center(
      child: SecurityLevelWidget(
        securityLevel: 7,
        incidentIcons: [Icons.directions_car, Icons.person, Icons.alarm],
        color: Colors.orange,
      ),
    );
  }

  Widget buildError(UserErrorState errorState) {
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

class SecurityLevelWidget extends StatelessWidget {
  final int securityLevel;
  final List<IconData> incidentIcons;
  final Color color;

  const SecurityLevelWidget({
    super.key,
    required this.securityLevel,
    required this.incidentIcons,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Círculos concêntricos
        for (int i = 1; i <= 3; i++)
          Container(
            width: 150.0 * i / 2,
            height: 150.0 * i / 2,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey),
            ),
          ),

        Positioned(
          child: Icon(incidentIcons[0], size: 24),
        ),
        Positioned(
          left: 10,
          child: Icon(incidentIcons[1], size: 24),
        ),
        Positioned(
          bottom: 10,
          child: Icon(incidentIcons[2], size: 24),
        ),
      ],
    );
  }
}

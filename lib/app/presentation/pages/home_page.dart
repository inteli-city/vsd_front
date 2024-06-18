import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/states/user_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/stores/providers/user_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/stores/providers/vigilance_provider.dart';
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
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text(
            'Users',
            style: TextStyle(
              color: Colors.deepPurpleAccent,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          backgroundColor: Colors.black,
        ),
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
    return const SizedBox();
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

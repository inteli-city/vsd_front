import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/user_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/vigilance_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/user_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/vigilance_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/widgets/user_widget.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/widgets/vigilance_widget.dart';
import 'package:flutter_clean_architecture_template/app/shared/themes/app_colors.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  List<IconData> navIcons = [
    Icons.home,
    Icons.videocam_rounded,
    Icons.chat,
    Icons.warning_amber,
  ];

  List<String> navTitle = [
    'Vigilância',
    'Câmeras',
    'Comunicação',
    'Ocorrência',
  ];

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
        bottomNavigationBar: Container(
          height: 65,
          margin: const EdgeInsets.all(
            16,
          ),
          decoration: BoxDecoration(
            color: AppColors.primaryBlue,
            borderRadius: BorderRadius.circular(25),
            boxShadow: [
              BoxShadow(
                blurRadius: 20,
                color: Colors.black.withOpacity(.1),
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: navIcons.map((icon) {
                  int index = navIcons.indexOf(icon);
                  bool isSelected = selectedIndex == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedIndex = index),
                    child: Column(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Icon(
                            icon,
                            size: 30,
                            color: isSelected ? AppColors.white : Colors.grey,
                          ),
                        ),
                        Text(
                          navTitle[index],
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                color:
                                    isSelected ? AppColors.white : Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
        body: Consumer<UserProvider>(builder: (context, userProvider, child) {
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
        }),
      ),
    );
  }

  Widget buildSuccess(
      UserSuccessState userState, VigilanceSuccessState vigilanceState) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
          child: Column(
        children: [
          UserWidget(
            user: userState.user,
          ),
          VigilanceWidget(
            vigilance: vigilanceState.vigilance,
          ),
        ],
      ));
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

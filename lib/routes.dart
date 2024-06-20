import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/injector.dart';
import 'package:flutter_clean_architecture_template/app/presentation/camera/pages/camera_page.dart';
import 'package:flutter_clean_architecture_template/app/presentation/chat/pages/chat_page.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/states/user_state.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/user_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/vigilance_provider.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/widgets/user_widget.dart';
import 'package:flutter_clean_architecture_template/app/presentation/splash/pages/splash_page.dart';
import 'package:flutter_clean_architecture_template/app/shared/themes/app_colors.dart';
import 'package:flutter_clean_architecture_template/app/shared/widgets/navigation_bar_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/pages/home_page.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    ShellRoute(
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(
              create: (_) => injector.get<UserProvider>()..fetchUser(),
            ),
            ChangeNotifierProvider(
              create: (_) =>
                  injector.get<VigilanceProvider>()..fetchVigilance(),
            ),
          ],
          child: Scaffold(
            body: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    var userState = userProvider.state;
                    return userState is UserSuccessState
                        ? UserWidget(
                            user: userState.user,
                          )
                        : Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryBlue,
                            ),
                          );
                  },
                ),
                Expanded(
                  child: child,
                ),
              ],
            ),
            bottomNavigationBar: const NavigationBarWidget(),
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: routePaths.home,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const HomePage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: routePaths.camera,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const CameraPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
        GoRoute(
          path: routePaths.chat,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              child: const ChatPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: CurveTween(curve: Curves.easeInOutCirc)
                      .animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    ),
  ],
);

const routePaths = (
  home: '/home',
  camera: '/camera',
  chat: '/chat',
  occurrence: '/occurrence',
);

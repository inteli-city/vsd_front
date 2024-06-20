import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/shared/themes/app_colors.dart';
import 'package:go_router/go_router.dart';

class NavigationBarWidget extends StatefulWidget {
  const NavigationBarWidget({super.key});

  @override
  State<NavigationBarWidget> createState() => _NavigationBarWidgetState();
}

class _NavigationBarWidgetState extends State<NavigationBarWidget> {
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

  List<String> navRoutes = [
    '/home',
    '/camera',
    '/chat',
    '/occurrence',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
                onTap: () => setState(() {
                  selectedIndex = index;
                  context.go(navRoutes[index]);
                }),
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: isSelected ? AppColors.white : Colors.grey,
                          ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

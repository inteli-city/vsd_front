import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/shared/themes/app_colors.dart';

class VigilanceWidget extends StatelessWidget {
  final VigilanceEntity vigilance;
  const VigilanceWidget({super.key, required this.vigilance});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConcentricCircles(
          vigilance: vigilance,
        ),
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
      ],
    );
  }
}

class ConcentricCircles extends StatelessWidget {
  final VigilanceEntity vigilance;
  const ConcentricCircles({super.key, required this.vigilance});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width / 2,
        minHeight: MediaQuery.of(context).size.height / 3,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          width: constraints.minHeight,
          height: constraints.minHeight,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.white, width: 3),
                ),
                child: Container(
                  margin: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gray, width: 3),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gray, width: 3),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gray, width: 3),
                      ),
                    ),
                  ),
                ),
              ),
              for (var incident in vigilance.incidents)
                Positioned(
                  top: 0,
                  child: Icon(incident.type.icon),
                ),
              for (var good in vigilance.goods)
                Positioned(
                  bottom: 0,
                  child: Icon(good.type.icon),
                ),
            ],
          ),
        );
      }),
    );
  }
}

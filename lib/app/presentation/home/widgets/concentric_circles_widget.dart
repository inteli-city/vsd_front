import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/vigilance_entity.dart';
import 'package:flutter_clean_architecture_template/app/shared/themes/app_colors.dart';

class ConcentricCirclesWidget extends StatelessWidget {
  final VigilanceEntity vigilance;
  final int points;
  const ConcentricCirclesWidget(
      {super.key, required this.vigilance, required this.points});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height / 2,
      ),
      child: LayoutBuilder(builder: (context, constraints) {
        double outerRadius = constraints.minHeight / 2;
        double margin = 30;
        double innerRadius = outerRadius - margin;
        double middleRadius = innerRadius - margin;
        double outermostRadius = middleRadius - margin;

        Positioned positionAlongCircle(
            Widget image, double angle, double radius) {
          double top = outerRadius - radius * sin(angle);
          double left = outerRadius + radius * cos(angle);
          return Positioned(
            top: top,
            left: left,
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.gray, width: 3),
              ),
              child: image,
            ),
          );
        }

        int totalIcons = vigilance.incidents.length + vigilance.goods.length;
        double angleIncrement = (2 * pi) / totalIcons;
        double angle = 0;

        List<Widget> positionedIcons = [];

        // Distribuindo os ícones entre os três círculos internos
        for (var incident in vigilance.incidents) {
          double currentRadius;
          if (incident.distance <= 500) {
            currentRadius = outermostRadius;
          } else if (incident.distance <= 1000) {
            currentRadius = middleRadius;
          } else {
            currentRadius = innerRadius;
          }
          positionedIcons.add(
              positionAlongCircle(incident.type.image, angle, currentRadius));
          angle += angleIncrement;
        }

        for (var good in vigilance.goods) {
          double currentRadius;
          if (good.distance <= 500) {
            currentRadius = outermostRadius;
          } else if (good.distance <= 1000) {
            currentRadius = middleRadius;
          } else {
            currentRadius = innerRadius;
          }
          positionedIcons
              .add(positionAlongCircle(good.type.image, angle, currentRadius));
          angle += angleIncrement;
        }
        return SizedBox(
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
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.gray, width: 3),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(30),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.gray, width: 3),
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.gray, width: 3),
                      ),
                      child: Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CustomPaint(
                              size: Size(constraints.minHeight / 4,
                                  constraints.minHeight / 4),
                              painter: HexagonPainter(
                                color: points > 7
                                    ? Colors.green
                                    : points > 5
                                        ? Colors.yellow
                                        : Colors.red,
                              ),
                            ),
                            Text('$points',
                                style: Theme.of(context)
                                    .textTheme
                                    .displayLarge!
                                    .copyWith(
                                        color: AppColors.white,
                                        fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ...positionedIcons,
            ],
          ),
        );
      }),
    );
  }
}

class HexagonPainter extends CustomPainter {
  final Color color;

  HexagonPainter({super.repaint, required this.color});
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final Path path = Path();
    final double width = size.width;
    final double height = size.height;
    final double side = width / 2;
    final double centerX = width / 2;
    final double centerY = height / 2;
    final double radius = side / cos(pi / 6);

    path.moveTo(centerX + radius * cos(0), centerY + radius * sin(0));
    for (int i = 1; i <= 6; i++) {
      path.lineTo(
        centerX + radius * cos(i * pi / 3),
        centerY + radius * sin(i * pi / 3),
      );
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}

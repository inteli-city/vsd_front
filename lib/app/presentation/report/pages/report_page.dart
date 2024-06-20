import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_template/app/domain/entities/incident_near_user_entity.dart';
import 'package:flutter_clean_architecture_template/app/domain/enum/incident_type_enum.dart';
import 'package:flutter_clean_architecture_template/app/presentation/home/stores/providers/vigilance_provider.dart';
import 'package:flutter_clean_architecture_template/app/shared/themes/app_colors.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  XFile? file;
  IncidentTypeEnum? incidentTypeEnum;
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<VigilanceProvider>(
        builder: (context, vigilanceProvider, child) {
      return vigilanceProvider.loading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIncidentTypeButton(
                        context,
                        IncidentTypeEnum.SUSPICIOUS_VEHICLE,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: _buildIncidentTypeButton(
                          context,
                          IncidentTypeEnum.SUSPICIOUS_PERSON,
                        ),
                      ),
                      _buildIncidentTypeButton(
                        context,
                        IncidentTypeEnum.ALARM_TRIGGERED,
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 5 * 24,
                    child: TextField(
                      controller: descriptionController,
                      maxLines: 5,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.white,
                        hintText: 'Breve descrição do incidente...',
                        isDense: true,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.white,
                      hintText: 'Local aproximado da ocorrência...',
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    ' Imagem do incidente: ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      child: ElevatedButton(
                        onPressed: () async {
                          final ImagePicker picker = ImagePicker();
                          file = await picker.pickImage(
                              source: ImageSource.camera);
                          setState(() {});
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.white,
                          padding: const EdgeInsets.all(16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(
                                color: AppColors.primaryBlue, width: 2),
                          ),
                        ),
                        child: const Text(
                          'Selecionar imagem',
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.center,
                    child: file != null
                        ? kIsWeb
                            ? Image.network(
                                file!.path,
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 4,
                                fit: BoxFit.cover,
                              )
                            : Image.file(
                                File(
                                  file!.path,
                                ),
                                width: MediaQuery.of(context).size.width / 2,
                                height: MediaQuery.of(context).size.height / 4,
                                fit: BoxFit.cover,
                              )
                        : const SizedBox.shrink(),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (incidentTypeEnum == null ||
                            descriptionController.text.isEmpty ||
                            file == null) {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Por favor, preencha todos os campos!',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.primaryBlue),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          await vigilanceProvider.createIncident(
                            IncidentNearUserEntity(
                              incidentId: '',
                              description: descriptionController.text,
                              type: incidentTypeEnum!,
                              imageUrl: file?.path,
                              distance: 500,
                            ),
                          );
                          descriptionController.clear();
                          file = null;
                          incidentTypeEnum = null;
                          setState(() {});
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  'Ocorrência criada com sucesso',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium!
                                      .copyWith(color: AppColors.primaryBlue),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryBlue,
                        padding: const EdgeInsets.all(24),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Enviar',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
    });
  }

  Widget _buildIncidentTypeButton(
    BuildContext context,
    IncidentTypeEnum incidentType,
  ) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          incidentTypeEnum = incidentType;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: incidentTypeEnum == incidentType
            ? AppColors.primaryBlue
            : AppColors.white,
        padding: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            incidentType.icon,
            color: incidentTypeEnum == incidentType
                ? AppColors.white
                : AppColors.primaryBlue,
          ),
          Text(
            incidentType.alertMessage(),
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: incidentTypeEnum == incidentType
                      ? AppColors.white
                      : AppColors.primaryBlue,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

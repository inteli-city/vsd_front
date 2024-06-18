import 'package:flutter_clean_architecture_template/app/domain/enum/incident_type_enum.dart';

class IncidentNearUserEntity {
  final String incidentId;
  final String description;
  final IncidentTypeEnum type;
  final int distance; // meters
  final String? imageUrl;

  IncidentNearUserEntity({
    required this.incidentId,
    required this.description,
    required this.type,
    required this.distance,
    this.imageUrl,
  });
}

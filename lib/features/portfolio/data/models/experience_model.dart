import '../../domain/entities/experience_entity.dart';

class ExperienceModel extends ExperienceEntity {
  const ExperienceModel({
    required super.company,
    required super.role,
    required super.period,
    required super.description,
    required super.achievements,
  });

  factory ExperienceModel.fromFirestore(Map<String, dynamic> json) {
    return ExperienceModel(
      company: json['company'] ?? '',
      role: json['role'] ?? '',
      period: json['period'] ?? '',
      description: json['description'] ?? '',
      achievements: List<String>.from(json['achievements'] ?? []),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'company': company,
      'role': role,
      'period': period,
      'description': description,
      'achievements': achievements,
    };
  }
}

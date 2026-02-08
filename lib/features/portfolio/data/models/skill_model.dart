import '../../domain/entities/skill_entity.dart';

class SkillModel extends SkillEntity {
  const SkillModel({
    required super.name,
    required super.level,
    required super.iconName,
    required super.colorHex,
  });

  factory SkillModel.fromFirestore(Map<String, dynamic> json) {
    return SkillModel(
      name: json['name'] ?? '',
      level: (json['level'] ?? 0.0).toDouble(),
      iconName: json['iconName'] ?? '',
      colorHex: json['colorHex'] ?? '0xFF3B82F6',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'level': level,
      'iconName': iconName,
      'colorHex': colorHex,
    };
  }
}

class SkillCategoryModel extends SkillCategoryEntity {
  const SkillCategoryModel({required super.title, required super.skills});

  factory SkillCategoryModel.fromFirestore(Map<String, dynamic> json) {
    return SkillCategoryModel(
      title: json['title'] ?? '',
      skills: (json['skills'] as List? ?? [])
          .map((s) => SkillModel.fromFirestore(s as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'skills': skills.map((s) => (s as SkillModel).toFirestore()).toList(),
    };
  }
}

import 'package:equatable/equatable.dart';

class SkillEntity extends Equatable {
  final String name;
  final double level;
  final String iconName;
  final String colorHex;

  const SkillEntity({
    required this.name,
    required this.level,
    required this.iconName,
    required this.colorHex,
  });

  @override
  List<Object?> get props => [name, level, iconName, colorHex];
}

class SkillCategoryEntity extends Equatable {
  final String title;
  final List<SkillEntity> skills;

  const SkillCategoryEntity({required this.title, required this.skills});

  @override
  List<Object?> get props => [title, skills];
}

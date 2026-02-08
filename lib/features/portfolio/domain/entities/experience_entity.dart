import 'package:equatable/equatable.dart';

class ExperienceEntity extends Equatable {
  final String company;
  final String role;
  final String period;
  final String description;
  final List<String> achievements;

  const ExperienceEntity({
    required this.company,
    required this.role,
    required this.period,
    required this.description,
    required this.achievements,
  });

  @override
  List<Object?> get props => [company, role, period, description, achievements];
}

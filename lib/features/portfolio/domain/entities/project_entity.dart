import 'package:equatable/equatable.dart';

class ProjectEntity extends Equatable {
  final String title;
  final String description;
  final String techStack;
  final String githubLink;

  const ProjectEntity({
    required this.title,
    required this.description,
    required this.techStack,
    required this.githubLink,
  });

  @override
  List<Object?> get props => [title, description, techStack, githubLink];
}

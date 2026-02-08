import '../../domain/entities/project_entity.dart';

class ProjectModel extends ProjectEntity {
  const ProjectModel({
    required super.title,
    required super.description,
    required super.techStack,
    required super.githubLink,
  });

  factory ProjectModel.fromFirestore(Map<String, dynamic> json) {
    return ProjectModel(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      techStack: json['techStack'] ?? '',
      githubLink: json['githubLink'] ?? '',
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'title': title,
      'description': description,
      'techStack': techStack,
      'githubLink': githubLink,
    };
  }
}

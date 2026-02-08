import 'package:flutter/material.dart';
import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/usecases/get_experiences.dart';
import '../../domain/usecases/get_projects.dart';
import '../../domain/usecases/get_skills.dart';

class PortfolioProvider with ChangeNotifier {
  final GetProjectsUseCase getProjectsUseCase;
  final GetSkillsUseCase getSkillsUseCase;
  final GetExperiencesUseCase getExperiencesUseCase;

  PortfolioProvider({
    required this.getProjectsUseCase,
    required this.getSkillsUseCase,
    required this.getExperiencesUseCase,
  });

  List<ProjectEntity> _projects = [];
  List<SkillCategoryEntity> _skillCategories = [];
  List<ExperienceEntity> _experiences = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<ProjectEntity> get projects => _projects;
  List<SkillCategoryEntity> get skillCategories => _skillCategories;
  List<ExperienceEntity> get experiences => _experiences;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPortfolioData() async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final results = await Future.wait([
        getProjectsUseCase.call(),
        getSkillsUseCase.call(),
        getExperiencesUseCase.call(),
      ]);

      _projects = results[0] as List<ProjectEntity>;
      _skillCategories = results[1] as List<SkillCategoryEntity>;
      _experiences = results[2] as List<ExperienceEntity>;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

import '../entities/project_entity.dart';
import '../entities/skill_entity.dart';
import '../entities/experience_entity.dart';

abstract class PortfolioRepository {
  Future<List<ProjectEntity>> getProjects();
  Future<List<SkillCategoryEntity>> getSkillCategories();
  Future<List<ExperienceEntity>> getExperiences();
}

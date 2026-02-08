import '../../domain/entities/experience_entity.dart';
import '../../domain/entities/project_entity.dart';
import '../../domain/entities/skill_entity.dart';
import '../../domain/repositories/portfolio_repository.dart';
import '../datasources/portfolio_remote_data_source.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource remoteDataSource;

  PortfolioRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<ExperienceEntity>> getExperiences() async {
    return await remoteDataSource.getExperiences();
  }

  @override
  Future<List<ProjectEntity>> getProjects() async {
    return await remoteDataSource.getProjects();
  }

  @override
  Future<List<SkillCategoryEntity>> getSkillCategories() async {
    return await remoteDataSource.getSkillCategories();
  }
}

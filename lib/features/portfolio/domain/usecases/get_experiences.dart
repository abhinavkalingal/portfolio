import '../entities/experience_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetExperiencesUseCase {
  final PortfolioRepository repository;

  GetExperiencesUseCase(this.repository);

  Future<List<ExperienceEntity>> call() async {
    return await repository.getExperiences();
  }
}

import '../entities/skill_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetSkillsUseCase {
  final PortfolioRepository repository;

  GetSkillsUseCase(this.repository);

  Future<List<SkillCategoryEntity>> call() async {
    return await repository.getSkillCategories();
  }
}

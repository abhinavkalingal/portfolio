import '../entities/project_entity.dart';
import '../repositories/portfolio_repository.dart';

class GetProjectsUseCase {
  final PortfolioRepository repository;

  GetProjectsUseCase(this.repository);

  Future<List<ProjectEntity>> call() async {
    return await repository.getProjects();
  }
}

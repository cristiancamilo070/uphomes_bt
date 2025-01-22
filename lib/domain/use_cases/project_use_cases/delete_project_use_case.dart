import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class DeleteProjectUseCase extends BaseUseCases<void, DeleteProjectParams> {
  final ProjectRepository projectRepository;

  DeleteProjectUseCase(this.projectRepository);

  @override
  Future<Either<BaseException, void>> execute(
      DeleteProjectParams params) async {
    return projectRepository.deleteProject(params.projectId);
  }
}

class DeleteProjectParams {
  final int projectId;

  DeleteProjectParams(this.projectId);
}

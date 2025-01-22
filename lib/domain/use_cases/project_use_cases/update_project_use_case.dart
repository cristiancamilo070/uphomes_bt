import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class UpdateProjectUseCase extends BaseUseCases<void, UpdateProjectParams> {
  final ProjectRepository projectRepository;

  UpdateProjectUseCase(this.projectRepository);

  @override
  Future<Either<BaseException, void>> execute(
      UpdateProjectParams params) async {
    return projectRepository.updateProject(params.project);
  }
}

class UpdateProjectParams {
  final ProjectModel project;

  UpdateProjectParams(this.project);
}

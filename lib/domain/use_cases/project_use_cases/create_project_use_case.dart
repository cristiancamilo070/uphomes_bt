import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class CreateProjectUseCase extends BaseUseCases<void, CreateProjectParams> {
  final ProjectRepository projectRepository;

  CreateProjectUseCase(this.projectRepository);

  @override
  Future<Either<BaseException, void>> execute(
      CreateProjectParams params) async {
    return projectRepository.createProject(params.project);
  }
}

class CreateProjectParams {
  final ProjectModel project;

  CreateProjectParams(this.project);
}

import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class GetAllProjectsUseCase extends BaseUseCasesNoParams<List<ProjectModel>> {
  final ProjectRepository projectRepository;

  GetAllProjectsUseCase(this.projectRepository);

  @override
  Future<Either<BaseException, List<ProjectModel>>> execute() async {
    return projectRepository.getAllProjects();
  }
}

import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class GetProjectsByAgencyIdUseCase
    extends BaseUseCases<List<ProjectModel>, GetProjectsByAgencyIdParams> {
  final ProjectRepository projectRepository;

  GetProjectsByAgencyIdUseCase(this.projectRepository);

  @override
  Future<Either<BaseException, List<ProjectModel>>> execute(
      GetProjectsByAgencyIdParams params) async {
    return projectRepository.getProjectsByAgencyId(params.agencyId);
  }
}

class GetProjectsByAgencyIdParams {
  final int agencyId;

  GetProjectsByAgencyIdParams(this.agencyId);
}

import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/project_model.dart';

abstract class ProjectRepository {
  Future<Either<BaseException, List<ProjectModel>>> getAllProjects();

  Future<Either<BaseException, List<ProjectModel>>> getProjectsByAgencyId(
      int agencyId);

  Future<Either<BaseException, void>> createProject(ProjectModel project);

  Future<Either<BaseException, void>> updateProject(ProjectModel project);

  Future<Either<BaseException, void>> deleteProject(int projectId);
}

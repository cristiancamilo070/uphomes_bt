import 'package:dartz/dartz.dart';
import 'package:samay_test/data/providers/database_provider.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/project_model.dart';
import 'package:samay_test/domain/repositories/project_repository.dart';

class ProjectRepositoryImpl extends ProjectRepository {
  final DatabaseProvider databaseProvider;

  ProjectRepositoryImpl(this.databaseProvider);

  @override
  Future<Either<BaseException, List<ProjectModel>>> getAllProjects() async {
    try {
      final data = await databaseProvider.query('projects');
      final projects = data.map((row) => ProjectModel.fromMap(row)).toList();
      return right(projects);
    } catch (e) {
      return left(BaseException(
        'Error fetching projects XDDDD',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<BaseException, List<ProjectModel>>> getProjectsByAgencyId(
      int agencyId) async {
    try {
      final data = await databaseProvider.query(
        'projects',
        where: 'agency_id = ?',
        whereArgs: [agencyId],
      );
      final projects = data.map((row) => ProjectModel.fromMap(row)).toList();
      return right(projects);
    } catch (e) {
      return left(BaseException(
        'Error fetching projects by agency',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<BaseException, void>> createProject(
      ProjectModel project) async {
    try {
      await databaseProvider.insert('projects', project.toMap());
      return right(null);
    } catch (e) {
      return left(BaseException(
        'Error creating project',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<BaseException, void>> updateProject(
      ProjectModel project) async {
    try {
      await databaseProvider.update(
        'projects',
        project.toMap(),
        'id = ?',
        [project.id],
      );
      return right(null);
    } catch (e) {
      return left(BaseException(
        'Error updating project',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<BaseException, void>> deleteProject(int projectId) async {
    try {
      await databaseProvider.delete('projects', 'id = ?', [projectId]);
      return right(null);
    } catch (e) {
      return left(BaseException(
        'Error deleting project',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }
}

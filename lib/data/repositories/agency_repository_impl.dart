import 'package:dartz/dartz.dart';
import 'package:samay_test/data/providers/database_provider.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/agency_model.dart';
import 'package:samay_test/domain/repositories/agency_repository.dart';

class AgencyRepositoryImpl extends AgencyRepository {
  final DatabaseProvider databaseProvider;

  AgencyRepositoryImpl(this.databaseProvider);

  @override
  Future<Either<BaseException, List<AgencyModel>>> getAllAgencies() async {
    try {
      final data = await databaseProvider.query('agencies');
      final agencies = data.map((row) => AgencyModel.fromMap(row)).toList();
      return right(agencies);
    } catch (e) {
      return left(BaseException(
        'Error fetching agencies',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<BaseException, void>> createAgency(AgencyModel agency) async {
    try {
      await databaseProvider.insert('agencies', agency.toMap());
      return right(null);
    } catch (e) {
      return left(BaseException(
        'Error creating agency',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<BaseException, void>> updateAgency(AgencyModel agency) async {
    try {
      await databaseProvider.update(
        'agencies',
        agency.toMap(),
        'id = ?',
        [agency.id],
      );
      return right(null);
    } catch (e) {
      return left(BaseException(
        'Error updating agency',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }

  @override
  Future<Either<BaseException, void>> deleteAgency(int agencyId) async {
    try {
      await databaseProvider.delete('agencies', 'id = ?', [agencyId]);
      return right(null);
    } catch (e) {
      return left(BaseException(
        'Error deleting agency',
        success: false,
        code: null,
        message: e.toString(),
      ));
    }
  }
}

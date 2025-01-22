import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/exceptions/base_exception.dart';
import 'package:samay_test/domain/models/agency_model.dart';

abstract class AgencyRepository {
  Future<Either<BaseException, List<AgencyModel>>> getAllAgencies();

  Future<Either<BaseException, void>> createAgency(AgencyModel agency);

  Future<Either<BaseException, void>> updateAgency(AgencyModel agency);

  Future<Either<BaseException, void>> deleteAgency(int agencyId);
}

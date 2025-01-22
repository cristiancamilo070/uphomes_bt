import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/models/agency_model.dart';
import 'package:samay_test/domain/repositories/agency_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class GetAllAgenciesUseCase extends BaseUseCasesNoParams<List<AgencyModel>> {
  final AgencyRepository _agencyRepository;

  GetAllAgenciesUseCase(this._agencyRepository);

  @override
  Future<Either<Exception, List<AgencyModel>>> execute() async {
    return _agencyRepository.getAllAgencies();
  }
}

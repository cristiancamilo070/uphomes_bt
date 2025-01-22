import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/models/agency_model.dart';
import 'package:samay_test/domain/repositories/agency_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class CreateAgencyUseCase extends BaseUseCases<void, CreateAgencyParams> {
  final AgencyRepository _agencyRepository;

  CreateAgencyUseCase(this._agencyRepository);

  @override
  Future<Either<Exception, void>> execute(CreateAgencyParams params) async {
    return _agencyRepository.createAgency(params.agency);
  }
}

class CreateAgencyParams {
  final AgencyModel agency;

  CreateAgencyParams(this.agency);
}

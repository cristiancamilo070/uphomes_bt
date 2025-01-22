import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/models/agency_model.dart';
import 'package:samay_test/domain/repositories/agency_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class UpdateAgencyUseCase extends BaseUseCases<void, UpdateAgencyParams> {
  final AgencyRepository _agencyRepository;

  UpdateAgencyUseCase(this._agencyRepository);

  @override
  Future<Either<Exception, void>> execute(UpdateAgencyParams params) async {
    return _agencyRepository.updateAgency(params.agency);
  }
}

class UpdateAgencyParams {
  final AgencyModel agency;

  UpdateAgencyParams(this.agency);
}

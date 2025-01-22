import 'package:dartz/dartz.dart';
import 'package:samay_test/domain/repositories/agency_repository.dart';
import 'package:samay_test/domain/use_cases/base_use_cases.dart';

class DeleteAgencyUseCase extends BaseUseCases<void, DeleteAgencyParams> {
  final AgencyRepository _agencyRepository;

  DeleteAgencyUseCase(this._agencyRepository);

  @override
  Future<Either<Exception, void>> execute(DeleteAgencyParams params) async {
    return _agencyRepository.deleteAgency(params.id);
  }
}

class DeleteAgencyParams {
  final int id;

  DeleteAgencyParams(this.id);
}

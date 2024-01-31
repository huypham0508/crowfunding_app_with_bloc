import 'package:crowfunding_app_with_bloc/app/data/adapters/repository_adapter.dart';
import 'package:crowfunding_app_with_bloc/app/data/provider/rest.dart';

class ApiServiceRepository implements IApiDeviceRepository {
  final RestAPIClient _restAPIClient;

  ApiServiceRepository(this._restAPIClient);

  log() {
    // ignore: avoid_print
    print(_restAPIClient);
  }
}

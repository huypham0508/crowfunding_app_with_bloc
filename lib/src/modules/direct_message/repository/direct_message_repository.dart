part of '../index.dart';

class DirectMessageRepository extends IDirectMessageAdapter {
  final RestAPIClient _restAPIClient;

  DirectMessageRepository(this._restAPIClient);

  @override
  Future<List<String>> increment() {
    _restAPIClient.toString();
    throw UnimplementedError();
  }
}

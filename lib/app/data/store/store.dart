import 'dart:async';

import 'package:crowfunding_app_with_bloc/app/data/repository/rest/api_service_repository.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/events_response.dart';

class ServerEventsManager {
  static ServerEventsManager? _instance;
  final ApiServiceRepository apiServiceRepository;

  factory ServerEventsManager({
    required ApiServiceRepository apiServiceRepository,
  }) {
    if (_instance != null) return _instance!;
    _instance = ServerEventsManager._internal(
      apiServiceRepository: apiServiceRepository,
    );

    return _instance!;
  }

  ServerEventsManager._internal({required this.apiServiceRepository});

  final StreamController<Map<String, dynamic>> _eventController =
      StreamController<Map<String, dynamic>>.broadcast();

  Stream<Map<String, dynamic>> get events => _eventController.stream;

  bool _isPolling = false;
  String? _queueId = null;
  int? _lastEventId = null;

  void startListening() async {
    if (_isPolling) return;
    if (_queueId == null && _lastEventId == null) {
      await _registerQueue();
    }
    _isPolling = true;
    await _pollServer();
  }

  void stopListening() {
    _isPolling = false;
    _eventController.close();
  }

  Future<void> _registerQueue() async {
    final queueString = await apiServiceRepository.registerQueue();
    if (queueString != null) {
      _queueId = queueString;
      _lastEventId = -1;
    }
  }

  Future<void> _pollServer() async {
    try {
      while (_isPolling) {
        final events = await apiServiceRepository.getEvents(
          queueId: _queueId ?? '',
          lastEventId: _lastEventId ?? 0,
        );
        if (events != null) {
          for (var event in events.data) {
            print(event.toJson());
            _dispatchEvent(event);
          }
        }
        await Future.delayed(Duration(seconds: 1));
      }
    } catch (e) {
      print('Error during polling: $e');
      _isPolling = false;
      await Future.delayed(Duration(seconds: 5));
      if (!_isPolling) {
        print('Restarting polling...');
        startListening();
      }
    }
  }

  void _dispatchEvent(EventModel event) {
    try {
      _lastEventId = (_lastEventId! > event.id) ? _lastEventId : event.id;
      switch (event.type) {
        case 'message':
          print("New message event: $event");
          break;
        case 'user_group':
          print("User group update event: $event");
          break;
        case 'realm':
          print("Realm update event: $event");
          break;
        default:
          print("Unhandled event type: ${event.type}, $event");
      }
    } catch (error) {
      print("Failed to process event: ${event.toJson()}, Error: $error");
    }
  }
}

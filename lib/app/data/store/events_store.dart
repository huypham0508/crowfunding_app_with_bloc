import 'dart:async';

import 'package:crowfunding_app_with_bloc/app/data/repository/rest/api_service_repository.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/events/events_response.dart';
import 'package:crowfunding_app_with_bloc/app/models/response/events/typing_response.dart';

class ServerEventsManager {
  static ServerEventsManager? _instance;
  final ApiServiceRepository apiServiceRepository;

  static ServerEventsManager getInstance({
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
  final StreamController<UserTyping> _eventTypingController =
      StreamController<UserTyping>.broadcast();

  Stream<Map<String, dynamic>> get events => _eventController.stream;
  Stream<UserTyping> get typingEvents => _eventTypingController.stream;

  bool _isPolling = false;
  String? _queueId = null;
  int? _lastEventId = null;

  void startListening() async {
    try {
      if (_isPolling) return;
      if (_queueId == null && _lastEventId == null) {
        await _registerQueue();
      }
      _isPolling = true;
      await _pollServer();
    } catch (e) {
      await reStart();
    }
  }

  void stopListening() {
    if (!_eventController.isClosed) {
      _eventController.close();
    }
    _isPolling = false;
  }

  Future<void> _registerQueue() async {
    try {
      final queueString = await apiServiceRepository.registerQueue();
      if (queueString != null) {
        _queueId = queueString;
        _lastEventId = -1;
      } else {
        throw new Exception();
      }
    } catch (e) {
      throw new Exception();
    }
  }

  Future<void> _pollServer() async {
    try {
      if (_queueId == null && _lastEventId == null) {
        throw Exception("");
      }
      while (_isPolling) {
        final events = await apiServiceRepository.getEvents(
          queueId: _queueId ?? '',
          lastEventId: _lastEventId ?? 0,
        );
        if (events != null) {
          for (var event in events.data) {
            _dispatchEvent(event);
          }
        }
        await Future.delayed(Duration(microseconds: 200));
      }
    } catch (e) {
      throw new Exception();
    }
  }

  Future<void> reStart() async {
    _isPolling = false;
    await Future.delayed(Duration(seconds: 5));
    if (!_isPolling) {
      print('Restarting polling...');
      _queueId = null;
      _lastEventId = null;
      startListening();
    }
  }

  void _dispatchEvent(EventModel event) {
    try {
      _lastEventId = (_lastEventId! > event.id) ? _lastEventId : event.id;
      switch (event.type) {
        case 'typing':
          UserTyping userTyping = UserTyping.fromJson(event.event);
          _eventTypingController.add(userTyping);
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

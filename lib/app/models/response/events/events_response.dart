class EventModel {
  final int id;
  final String type;
  final Map<String, dynamic> event;

  EventModel({
    required this.id,
    required this.type,
    required this.event,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      type: json['type'],
      event: json['event'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'event': event,
    };
  }
}

class Events {
  final List<EventModel> data;
  Events({required this.data});

  factory Events.fromJson(Map<String, dynamic> json) {
    return Events(
      data: (json['data'] as List)
          .map((item) => EventModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((event) => event.toJson()).toList(),
    };
  }
}

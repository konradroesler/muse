import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Track extends Equatable {
  Track({
    String? id,
    required this.name,
  }) : assert(
      id == null || id.isNotEmpty,
      'id must be null or not emptry',
    ),
    id = id ?? const Uuid().v4();

  final String id;
  final String name;

  Track copyWith({
    String? id,
    String? name,
  }) {
    return Track(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
    };
  }

  static Track fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id'],
      name: map['name'],
    );
  }

  @override 
  List<Object> get props => [id, name];
}

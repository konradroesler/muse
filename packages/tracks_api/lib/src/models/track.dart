import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Track extends Equatable {
  Track({
    String? id,
    required this.name,
    required this.file,
  }) : assert(
      id == null || id.isNotEmpty,
      'id must be null or not emptry',
    ),
    id = id ?? const Uuid().v4();

  final String id;
  final String name;
  final Uint8List file;

  Track copyWith({
    String? id,
    String? name,
    Uint8List? file,
  }) {
    return Track(
      id: id ?? this.id,
      name: name ?? this.name,
      file: file ?? this.file,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'file': file,
    };
  }

  static Track fromMap(Map<String, dynamic> map) {
    return Track(
      id: map['id'],
      name: map['name'],
      file: map['file'],
    );
  }

  @override 
  List<Object> get props => [id, name, file];

}

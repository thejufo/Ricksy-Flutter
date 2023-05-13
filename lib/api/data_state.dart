import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class DataState<T> with ChangeNotifier  {
  final T? data;
  final bool loading;
  final String? error;

  DataState({this.data, required this.loading, this.error});

  DataState copyWith({T? data, bool? loading, String? error}) {
    return DataState(
      data: data ?? this.data,
      loading: loading ?? this.loading,
      error: error ?? this.error
    );
  }
}
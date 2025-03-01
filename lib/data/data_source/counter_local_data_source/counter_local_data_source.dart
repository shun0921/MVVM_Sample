import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_local_data_source.g.dart';

@riverpod
CounterLocalDataSource counterLocalDataSource(Ref ref) =>
    CounterLocalDataSourceImpl(ref);

abstract interface class CounterLocalDataSource {
  Future<String> counter();
}

class CounterLocalDataSourceImpl implements CounterLocalDataSource {
  CounterLocalDataSourceImpl(this._ref);

  final Ref _ref;

  @override
  Future<String> counter() async {
    return 'Success';
  }
}

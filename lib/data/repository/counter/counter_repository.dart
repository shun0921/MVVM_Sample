import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_sample/data/data_source/counter_local_data_source/counter_local_data_source.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_repository.g.dart';

@riverpod
CounterRepository counterRepository(Ref ref) => CounterRepositoryImpl(ref);

abstract interface class CounterRepository {
  Future<String> counter();
}

class CounterRepositoryImpl implements CounterRepository {
  CounterRepositoryImpl(this._ref);

  final Ref _ref;

  CounterLocalDataSource get _dataSource =>
      _ref.read(counterLocalDataSourceProvider);

  @override
  Future<String> counter() async {
    try {
      return await _dataSource.counter();
    } on Exception catch (_) {
      rethrow;
    }
  }
}

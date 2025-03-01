import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mvvm_sample/data/repository/counter/counter_repository.dart';
import 'package:mvvm_sample/domain/usecase_result.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter_use_case.g.dart';

@riverpod
CounterUseCase counterUseCase(Ref ref) => CounterUseCaseImpl(ref);

abstract class CounterUseCase {
  Future<UseCaseResult<String, Exception>> invoke();
}

class CounterUseCaseImpl implements CounterUseCase {
  CounterUseCaseImpl(this._ref);

  final Ref _ref;

  CounterRepository get _repository => _ref.read(counterRepositoryProvider);

  @override
  Future<UseCaseResult<String, Exception>> invoke() async {
    try {
      final response = await _repository.counter();
      return UseCaseResult(success: response);
    } on Exception catch (e) {
      return UseCaseResult(failure: e);
    }
  }
}

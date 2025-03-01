import 'dart:async';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mvvm_sample/domain/counter/counter_use_case.dart';
import 'package:mvvm_sample/domain/usecase_result.dart';
import 'package:mvvm_sample/util/logger.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default('') String errorMessage, // バックエンド側から受信したエラーメッセージ
    @Default('') String count,
  }) = _HomeState;
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  @override
  HomeState build() {
    return const HomeState();
  }

  CounterUseCase get _counterUseCase => ref.read(counterUseCaseProvider);

  Future<void> incrementCount(String mailAddress) async {
    state = state.copyWith(isLoading: true);
    try {
      final result = await _counterUseCase.invoke();

      if (result.isSuccess) {
        // 成功時処理
        state = state.copyWith(
          count: result.getResult,
        );
      } else {
        state = state.copyWith(errorMessage: result.errorMessage);
      }
    } on Exception catch (error) {
      logger.info('error: $error');
      state = state.copyWith(
          errorMessage: CustomError(500, 'Unknown error occurred').message);
    } finally {
      state = state.copyWith(isLoading: false);
    }
  }

  void resetFlg() {
    state = state.copyWith(
      errorMessage: '',
      count: '',
      isLoading: false,
    );
  }
}

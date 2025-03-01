class UseCaseResult<T, E> {
  UseCaseResult({this.success, this.failure});

  final T? success;
  final E? failure;

  /// 成功かどうかを返す
  bool get isSuccess => success != null;

  /// 失敗かどうかを返す
  bool get isFailure => failure != null;

  /// 結果を取得。成功時のみ呼ばれる。
  T get getResult {
    if (success != null) {
      return success!;
    } else {
      throw UseCaseException('Result is not set.');
    }
  }

  /// 失敗時のエラーメッセージを返す
  String get errorMessage => _getErrorMessage();

  /// 失敗時のステータスコードを返す
  int get statusCode => _getStatusCode();

  /// 失敗時のエラーメッセージをカスタマイズ
  String _getErrorMessage() {
    if (failure == null) {
      return 'No error';
    } else if (failure is CustomError) {
      return (failure as CustomError).message;
    }
    return 'Unknown error occurred';
  }

  /// 失敗時のステータスコードをカスタマイズ
  int _getStatusCode() {
    if (failure == null) {
      return 200; // 成功時のデフォルトコード
    } else if (failure is CustomError) {
      return (failure as CustomError).code;
    }
    return 500; // 未定義のエラーの場合
  }
}

/// カスタム例外クラス
class UseCaseException implements Exception {
  UseCaseException([this.message]);

  final dynamic message;

  @override
  String toString() => message?.toString() ?? 'UseCaseException';
}

/// 汎用的なエラークラスの例（必要に応じてカスタマイズ可能）
class CustomError {
  CustomError(this.code, this.message);

  final int code;
  final String message;
}
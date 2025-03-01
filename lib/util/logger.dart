import 'package:flutter/foundation.dart';
import 'package:simple_logger/simple_logger.dart';

// https://pub.dev/packages/simple_logger
// デバックビルドのみログ出力と出力情報を表示する
final logger = SimpleLogger()
  ..setLevel(
    kDebugMode ? Level.FINEST : Level.OFF,
    includeCallerInfo: kDebugMode,
  );

# キャッシュの削除
clean:
	rm -rf ios/Pods/
	rm -rf ios/Podfile.lock
	fvm flutter clean
	fvm flutter pub get
	(cd ios && pod install --repo-update && cd ..)

# Packageのセットアップ
pub_get:
	fvm flutter pub get

# ファイル自動生成
gen:
	fvm dart run build_runner build --delete-conflicting-outputs

# ファイル自動生成の監視
gen_watch:
	fvm dart run build_runner watch --delete-conflicting-outputs


# importの並び替え
import_sorter:
	fvm flutter pub run import_sorter:main --no-comments

# 静的解析
analyze:
	fvm flutter analyze --no-fatal-infos

# テスト
.PHONY: test
test:
	fvm flutter test

# 静的解析
basic_packege_import:
	flutter pub add flutter_riverpod freezed_annotation gap go_router json_annotation pedantic_mono riverpod_annotation url_launcher build_runner freezed go_router_builder import_sorter json_serializable riverpod_generator

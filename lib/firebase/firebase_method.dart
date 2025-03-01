import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvvm_sample/util/logger.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // コンストラクタ（必要に応じて）
  FirebaseAuthService();

  // 新規アカウント作成
  Future<User?> createUserWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      // Firebaseのエラーハンドリング（メッセージなどカスタマイズ可能）
      logger.warning('Error: $e');
      return null;
    }
  }

  // ログイン
  Future<User?> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      logger.warning('Error: $e');
      return null;
    }
  }

  // 匿名ログイン
  Future<User?> signInAnonymously() async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInAnonymously();
      return userCredential.user;
    } catch (e) {
      logger.warning('Error: $e');
      return null;
    }
  }

  // ログアウト
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      logger.warning('Error: $e');
    }
  }

  // 現在のユーザーを取得
  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  // メールアドレスの確認（Email verification）
  Future<void> sendEmailVerification() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null && !user.emailVerified) {
      try {
        await user.sendEmailVerification();
      } catch (e) {
        logger.warning('Error: $e');
      }
    }
  }

  // パスワードリセットメールを送信
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      logger.warning('Error: $e');
    }
  }

  // パスワード変更
  Future<void> changePassword(String newPassword) async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.updatePassword(newPassword);
      } catch (e) {
        logger.warning('Error: $e');
      }
    }
  }

  // ユーザー削除
  Future<void> deleteUser() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      try {
        await user.delete();
      } catch (e) {
        logger.warning('Error: $e');
      }
    }
  }
}

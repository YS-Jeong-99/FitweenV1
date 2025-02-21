/* 사용자 모델 프리젠터 */

import 'package:fitweenV1/model/user.dart';
import 'package:fitweenV1/presenter/firebase/firebase.dart';
import 'package:get/get.dart';

/// class
class UserPresenter extends GetxController {
  /// attributes
  /* 로그인 관련 */
  // User Credential 정보
  Map<String, dynamic> data = {};

  // 현재 로그인된 사용
  FWUser loggedUser = FWUser();

  // 로그인 여부
  bool get isLogged => loggedUser.uid != null;

  /// methods
  /* 로그인 관련 */
  // 로그인
  // 매개변수로 받은 사용자 정보와 User Credential 정보를 병합하여 현재 로그인된 사용자자 최신화
  void login(FWUser user) {
    Map<String, dynamic> json = user.toJson();
    data.forEach((key, value) => json[key] = value);
    loggedUser = FWUser.fromJson(json);
  }

  // 로그아웃
  // 현재 로그인된 사용자 정보 초기화
  void logout() { loggedUser = FWUser(); }

  /* 파이어베이스 관련 */
  // 파이어베이스에 최신화
  void save() => f.collection('users').doc(loggedUser.uid).set(loggedUser.toJson());

  // 파이어베이스에서 삭제
  void delete() => f.collection('users').doc(loggedUser.uid).delete();
}

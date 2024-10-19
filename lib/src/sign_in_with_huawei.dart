import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sign_in_with_huawei/sign_in_with_huawei.dart';

const _kMessageChannel = 'com.fluttercandies/sign_in_with_huawei';

class SignInWithHuawei {
  SignInWithHuawei._();

  static final SignInWithHuawei _instance = SignInWithHuawei._();

  static SignInWithHuawei get instance => _instance;

  final _channel = const MethodChannel(_kMessageChannel);

  /// 华为账号登录(获取 UnionID/OpenID)
  ///
  /// [forceLogin] 当用户未登录华为账号时，是否强制拉起华为账号登录界面
  ///
  /// [state] 该参数与响应体中返回的state比较，校验是否是当前请求，可防止跨站攻击
  ///
  /// [nonce] 该参数会包含在返回的ID Token中，通过校验一致性，可用于防止重放攻击
  ///
  /// [idTokenAlg] 用于指定ID Token的签名算法，默认值：PS256
  Future<HuaweiAuthByIdResponse> authById({
    bool forceLogin = true,
    String? state,
    String? nonce,
    IdTokenSignAlgorithm idTokenAlg = IdTokenSignAlgorithm.PS256,
  }) async {
    final result = await _channel.invokeMethod(
      'authById',
      <String, dynamic>{
        'forceLogin': forceLogin,
        if (state != null) 'state': state,
        if (nonce != null) 'nonce': nonce,
        'idTokenAlg': idTokenAlg.value,
      },
    );
    final response = HuaweiAuthByIdResponse.fromMap(result);
    return response;
  }
}

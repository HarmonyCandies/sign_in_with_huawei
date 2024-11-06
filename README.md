# sign_in_with_huawei

用于 HarmonyOS 上华为账号登录的 Flutter 插件

## 安装

```shell
flutter pub add sign_in_with_huawei
```

或者将其添加到你的 `pubspec.yaml` 文件中

```yaml
dependencies:
    sign_in_with_huawei: ^0.0.3
```

## 前提条件

在开始之前，请先阅读 [开发准备][1] 和 [华为账号登录（获取UnionID/OpenID）][2]

## 使用方法

```dart
final response = await SignInWithHuawei.instance.authById(
  forceLogin: true,
  state: "any state",
  nonce: "any nonce",
  idTokenAlg: IdTokenSignAlgorithm.PS256,
);

print(response);
// response.state
// response.authCode
// response.idToken
// response.openID
// response.unionID
```

## 限制

当前插件仅实现了 **[华为账号登录（获取UnionID/OpenID）][2]**。

**[华为账号一键登录（获取手机号和UnionID/OpenID）][3]** 尚未实现，欢迎 PR

[1]: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/account-preparations-V5
[2]: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/account-unionid-login-V5
[3]: https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/account-phone-unionid-login-V5

const keyErrorCode = "errorCode";
const keyErrorMsg = "errorMsg";

abstract class HuaweiAuthResponse {
  HuaweiAuthResponse._(this.errorCode, this.errorMsg);

  final int errorCode;
  final String errorMsg;

  bool get isSuccess => errorCode == 0;
}

class HuaweiAuthByIdResponse extends HuaweiAuthResponse {
  final String? state;
  final String? authCode;
  final String? idToken;
  final String? openID;
  final String? unionID;

  HuaweiAuthByIdResponse.fromMap(Map response)
      : state = response["state"],
        authCode = response["authCode"],
        idToken = response["idToken"],
        openID = response["openID"],
        unionID = response["unionID"],
        super._(response[keyErrorCode], response[keyErrorMsg]);

  @override
  String toString() {
    return 'HuaweiAuthByIdResponse{state: $state, authCode: $authCode, idToken: $idToken, openID: $openID, unionID: $unionID, errorCode: $errorCode, errorMsg: $errorMsg}';
  }
}

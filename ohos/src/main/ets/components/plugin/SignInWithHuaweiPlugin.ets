import {
  AbilityAware,
  AbilityPluginBinding,
  FlutterPlugin,
  FlutterPluginBinding,
  MethodCall,
  MethodCallHandler,
  MethodChannel,
  MethodResult,
} from '@ohos/flutter_ohos';
import { authentication } from '@kit.AccountKit';
import { util } from '@kit.ArkTS';
import { common } from '@kit.AbilityKit';

const MESSAGES_CHANNEL = "com.fluttercandies/sign_in_with_huawei";

interface IResponse {
  errorCode?: number;
  errorMsg?: string;
  data?: Record<string, ESObject>;
}

/** SignInWithHuaweiPlugin **/
export default class SignInWithHuaweiPlugin implements FlutterPlugin, MethodCallHandler, AbilityAware {
  private channel: MethodChannel | null = null;
  private context: common.UIAbilityContext | null = null;

  constructor() {
  }

  getUniqueClassName(): string {
    return "SignInWithHuaweiPlugin"
  }

  onAttachedToEngine(binding: FlutterPluginBinding): void {
    this.channel = new MethodChannel(binding.getBinaryMessenger(), MESSAGES_CHANNEL);
    this.channel.setMethodCallHandler(this)
  }

  onDetachedFromEngine(binding: FlutterPluginBinding): void {
    if (this.channel != null) {
      this.channel.setMethodCallHandler(null)
    }
  }

  onAttachedToAbility(binding: AbilityPluginBinding): void {
    this.context = binding.getAbility().context
  }

  onDetachedFromAbility(): void {
    this.context = null
  }

  onMethodCall(call: MethodCall, result: MethodResult): void {
    if (call.method == "authById") {
      this.authById(call, result)
    } else {
      result.notImplemented()
    }
  }

  async authById(call: MethodCall, result: MethodResult): Promise<void> {
    try {
      const request = this.composeIdRequest(call)
      const controller = new authentication.AuthenticationController(this.context!);
      const response: authentication.LoginWithHuaweiIDResponse = await controller.executeRequest(request);
      result.success(this.responseToMap({
        data: {
          "state": response.state,
          "authCode": response.data?.authorizationCode,
          "idToken": response.data?.idToken,
          "openID": response.data?.openID,
          "unionID": response.data?.unionID
        }
      }))
    } catch (e) {
      result.success(this.responseToMap({
        errorCode: e.code,
        errorMsg: e.message
      }))
    }
  }

  composeIdRequest(call: MethodCall): authentication.LoginWithHuaweiIDRequest {
    const forceLogin: boolean = call.argument("forceLogin");
    const state: string | null = call.argument("state");
    const nonce: string | null = call.argument("nonce");
    const idTokenAlg: string = call.argument("idTokenSignAlgorithm");

    const provider = new authentication.HuaweiIDProvider();
    const loginRequest = provider.createLoginWithHuaweiIDRequest();
    loginRequest.forceLogin = forceLogin;
    loginRequest.state = state ? state : util.generateRandomUUID();
    loginRequest.nonce = nonce ? nonce : util.generateRandomUUID();
    loginRequest.idTokenSignAlgorithm = this.mapIdTokenAlgorithm(idTokenAlg);

    return loginRequest
  }

  mapIdTokenAlgorithm(idTokenAlg: string): authentication.IdTokenSignAlgorithm {
    if (idTokenAlg == "PS256") {
      return authentication.IdTokenSignAlgorithm.PS256
    } else {
      return authentication.IdTokenSignAlgorithm.RS256
    }
  }

  responseToMap(response: IResponse): Map<string, ESObject> {
    const map: Map<string, ESObject> = response?.data
      ? new Map(Object.entries(response.data))
      : new Map()
    map.set("errorCode", response.errorCode ? response.errorCode : 0)
    map.set("errorMsg", response.errorMsg ? response.errorMsg : "")
    return map
  }
}
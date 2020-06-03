import '../responses/response_default.dart';
import '../responses/response_status.dart';

class ResponseBuilder {
  static ResponseDefault falha<T>({T objeto, String mensagem}) {
    return ResponseDefault<T>(
        objeto: objeto, mensagem: mensagem, status: ResponseStatus.ERRO);
  }

  static ResponseDefault sucesso<T>({T objeto, String mensagem}) {
    return ResponseDefault<T>(
        objeto: objeto, mensagem: mensagem, status: ResponseStatus.SUCESSO);
  }
}

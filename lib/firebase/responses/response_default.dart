
import 'response_status.dart';

class ResponseDefault<T> {
  final T objeto;
  final String mensagem;
  final ResponseStatus status;

  bool get success => status == ResponseStatus.SUCESSO;

  bool get failed => status == ResponseStatus.ERRO;

  ResponseDefault({this.objeto, this.mensagem, this.status});
}

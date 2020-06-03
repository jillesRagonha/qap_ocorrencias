import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:qap_ocorrencias/firebase/interface/auth_repository_interface.dart';
import 'package:qap_ocorrencias/firebase/responses/response_builder.dart';
import 'package:qap_ocorrencias/firebase/responses/response_default.dart';

class AuthRepository implements IAuthRepository {
  final FirebaseAuth firebaseAuth;

  AuthRepository(this.firebaseAuth);

  @override
  Future<ResponseDefault> doLoginEmailPassword(String email,
      String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      return ResponseBuilder.sucesso<FirebaseUser>(
          objeto: await firebaseAuth.currentUser());
    } on Exception catch (e) {
      return ResponseBuilder.falha(objeto: e, mensagem: e.toString());
    }
  }

  @override
  Future<ResponseDefault> doLoginGoogle() async {
    try {
      var googleSignIn = GoogleSignIn();
      var googleSignInAccount = await googleSignIn.signIn();
      var googleSignInAuthentication = await googleSignInAccount.authentication;
      FirebaseUser firebaseUser;

      if (googleSignInAuthentication.accessToken != null) {
        var credential = GoogleAuthProvider.getCredential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);
        await firebaseAuth
            .signInWithCredential(credential)
            .then((auth) => firebaseUser = auth.user);
      }
      return ResponseBuilder.sucesso<FirebaseUser>(
          objeto: firebaseUser, mensagem: "Logado com sucesso");
    } on Exception catch (e) {
      return ResponseBuilder.falha(
          objeto: e, mensagem: 'Falha ao logar com o google ${e.toString()}');
    }
  }

  @override
  Future<ResponseDefault> getUser() async {
    try {
      return ResponseBuilder.sucesso<FirebaseUser>(
          objeto: await firebaseAuth.currentUser());
    } on Exception catch (e) {
      return ResponseBuilder.falha(objeto: e, mensagem: e.toString());
    }
  }

  @override
  Future<ResponseDefault> logout() async {
    try {
      await firebaseAuth.signOut();
      return ResponseBuilder.sucesso();
    } on Exception catch (e) {
      return ResponseBuilder.falha(objeto: e, mensagem: e.toString());
    }
  }

  @override
  Future<ResponseDefault> registerEmailPassword(
      {String email, String senha}) async {
    try {
      return await firebaseAuth
          .createUserWithEmailAndPassword(
          email: email.trim(), password: senha.trim())
          .then(
            (auth) {
          return ResponseBuilder.sucesso<FirebaseUser>(objeto: auth.user);
        },
      );
    } on Exception catch (e) {
      return ResponseBuilder.falha(objeto: e, mensagem: e.toString());
    }
  }
}

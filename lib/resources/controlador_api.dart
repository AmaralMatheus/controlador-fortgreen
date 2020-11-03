class ControladorApi {
  doLogin(email, password) {
    if(email == '123' && password == '123') {
      return {
        'token': 'teste',
        'id' : 1
      };
    } else {
      return null;
    }
  }
}
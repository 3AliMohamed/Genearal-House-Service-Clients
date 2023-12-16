abstract class LogInStates {}

class LogInInitialState extends LogInStates{}


class ChangePassVisibiltyState extends LogInStates{}

class LoginSuccessState extends LogInStates{
}
class LoginErrorState extends LogInStates{
  String error;
  LoginErrorState(this.error);
}




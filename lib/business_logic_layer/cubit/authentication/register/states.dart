abstract class RegisterStates{}

class RegisterInitialState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates{}

class ChangePasswordVisibiltyStateSingUp extends RegisterStates{}

class ChangeConfirmPasswordVisibiltyStateSingUp extends RegisterStates{}

class ChangeGenderState extends RegisterStates{}

class RegisterErrorState extends RegisterStates{
  String error;
  RegisterErrorState(this.error);
}
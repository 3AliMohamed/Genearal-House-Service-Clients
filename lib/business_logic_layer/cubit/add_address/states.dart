abstract class AddAddressStates {}

class InitialState extends AddAddressStates{}

class AddedSuccessfullyState extends AddAddressStates{}

class Loading extends AddAddressStates {}

class AddErrorState extends AddAddressStates{
  dynamic error;
  AddErrorState(this.error);
}


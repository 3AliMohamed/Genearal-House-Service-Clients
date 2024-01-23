abstract class ProductStates{}

class InitialState extends ProductStates{}

class LoadingState extends ProductStates{}

class UpdatePercentageSuccess extends ProductStates{}


class LoadedSuccessfullyState extends ProductStates {
  // dynamic products;
  LoadedSuccessfullyState();
}

class LoadedErrorState extends ProductStates{
  dynamic error;
  LoadedErrorState(this.error);
}



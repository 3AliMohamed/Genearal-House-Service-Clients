abstract class ProductStates{}

class InitialState extends ProductStates{}

class LoadingState extends ProductStates{}

class LoadedSuccessfullyState extends ProductStates {
  dynamic products;
  LoadedSuccessfullyState(this.products);
}

class LoadedErrorState extends ProductStates{
  dynamic error;
  LoadedErrorState(this.error);
}



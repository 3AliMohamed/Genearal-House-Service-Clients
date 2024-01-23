abstract class AddProductStates{}

class AddProductInitialState extends AddProductStates{}

class IncrementQuantity extends AddProductStates{}

class DecrementQuantity extends AddProductStates{}

class PlacingOrderState extends AddProductStates{}

class PlacedSuccessfullyState extends AddProductStates{}

class ErrorState extends AddProductStates{}




import '../../../models/GetTransportationPeriod.dart';

abstract class TransportationsPeriodStates{}

class InitialState extends TransportationsPeriodStates{}
class SuccessState extends TransportationsPeriodStates{

  dynamic response;
  SuccessState(this.response);
}


class FailedState extends TransportationsPeriodStates{
  dynamic error ;
  FailedState(this.error);

}

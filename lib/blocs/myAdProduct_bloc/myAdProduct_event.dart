part of './myAdProduct_bloc.dart';

abstract class MyAdProductEvent extends Equatable {
  const MyAdProductEvent();
}

//events
/* 
ao iniciar a pagina =>
 */
class MyAdProducPageStarted extends MyAdProductEvent {
  const MyAdProducPageStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'MyAdProducPageStarted => ok';
}

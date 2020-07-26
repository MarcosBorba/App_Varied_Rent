part of './myAdProduct_bloc.dart';

abstract class MyAdProductEvent extends Equatable {
  const MyAdProductEvent();
}

//events
/* 
ao iniciar a pagina => tem que buscar avaliacoes, questoesRespostas e dados do locador

avaliacoes tem que retornar um list de objetos 

questoes e respostas retorna um list de objetos tbm

os dados do locador retorna um objeto 

########################################################


estado de responder a questão do usuario 

estado de editar a resposta


 */
class MyAdProducPageStarted extends MyAdProductEvent {
  const MyAdProducPageStarted();

  @override
  List<Object> get props => [];

  @override
  String toString() => 'MyAdProducPageStarted => ok';
}

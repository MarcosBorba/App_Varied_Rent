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
part of 'myAdProduct_bloc.dart';

abstract class MyAdProductPageEvent extends Equatable {
  const MyAdProductPageEvent();
}

class MyAdProductPageGetQuestionsAndEvaluations extends MyAdProductPageEvent {
  final String idAd;
  const MyAdProductPageGetQuestionsAndEvaluations(this.idAd);

  @override
  List<Object> get props => [idAd];

  @override
  String toString() => 'MyAdProductPageGetQuestionsAndEvaluations => $idAd';
}

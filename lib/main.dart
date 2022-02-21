import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:varied_rent/utils/app_sizes.dart';
import 'package:varied_rent/views/homePages/myHomePage.dart';
import 'package:varied_rent/views/loginPages/loginPage.dart';

import 'repositories/repositories.dart';
import 'blocs/authentication_bloc/authentication.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'loading_indicator.dart';
import 'splash_page.dart';

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    print(event);
    super.onEvent(bloc, event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print(transition);
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stackTrace) {
    print(error);
    super.onError(bloc, error, stackTrace);
  }
}

main() async {
  await DotEnv().load('.env');
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository(
    userApiClient: UserApiClient(),
  );
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..add(AppStarted());
      },
      child: App(userRepository: userRepository),
    ),
  );
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          //TODO: nivel 3 - sobre AppSizes, criar uma forma de acesso ao arquivo de tamanhos somente uma vez
          //pode ser um objeto que armazena todos tamanhos ou variaveis globais
          AppSizes.setScreenAwareConstant(context);
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          } else if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          } else if (state is AuthenticationLoading) {
            return LoadingIndicator();
          }
          return SplashPage();
        },
      ),
    );
  }
}

import 'package:app/bootstrap.dart';
import 'package:app/users/view/users_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:users_api/api.dart';
import 'package:users_api_grpc/users_api.dart' as users_api_grpc;
import 'package:users_repository/repository.dart';

void main() {
  bootstrap(() async {
    // const baseUrl = String.fromEnvironment('API_URL',
    //     defaultValue: 'http://192.168.1.109:8080');
    // final apiClient = ApiClient(baseUrl: baseUrl);

    const baseUrl =
        String.fromEnvironment('API_URL', defaultValue: 'http://localhost');
    final port = int.tryParse(const String.fromEnvironment('API_PORT')) ?? 8080;

    final apiClient = users_api_grpc.ApiClient(
      baseUrl: baseUrl,
      port: port,
    );

    final usersRepository = UsersRepository(apiClient: apiClient);

    return App(
      usersRepository: usersRepository,
    );
  });
}

class App extends StatelessWidget {
  const App({
    super.key,
    required usersRepository,
  }) : _usersRepository = usersRepository;

  final UsersRepository _usersRepository;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _usersRepository),
      ],
      child: const AppView(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Users Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const UsersRoute(),
    );
  }
}

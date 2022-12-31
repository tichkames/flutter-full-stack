import 'package:dart_frog/dart_frog.dart';
import 'package:users_api/src/in_memory_users_data_source.dart';
import 'package:users_api/src/users_data_source.dart';

final _usersDataSource = InMemoryUsersDataSource();

Handler middleware(Handler handler) {
  return handler
      .use(requestLogger())
      .use(provider<UsersDataSource>((_) => _usersDataSource));
}

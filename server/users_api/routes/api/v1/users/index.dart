import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:users_api/src/users_data_source.dart';

Future<Response> onRequest(RequestContext context) async {
  final method = context.request.method;

  if (method == HttpMethod.get) {
    return _onGetRequest(context);
  }
  if (method == HttpMethod.post) {
    return _onPostRequest(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _onGetRequest(RequestContext context) async {
  final userDataSource = context.read<UsersDataSource>();

  final users = await userDataSource.getAllUsers();

  return Response.json(
    body: {'users': users},
  );
}

Future<Response> _onPostRequest(RequestContext context) async {
  return Response.json(
    body: [
      {'message:': 'POST'}
    ],
  );
}

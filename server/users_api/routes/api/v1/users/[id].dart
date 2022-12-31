import 'dart:io';

import 'package:dart_frog/dart_frog.dart';
import 'package:users_api/src/users_data_source.dart';

Future<Response> onRequest(RequestContext context, String id) async {
  final method = context.request.method;

  if (method == HttpMethod.get) {
    return _onGetRequest(context, id);
  }
  if (method == HttpMethod.put) {
    return _onPutRequest(context);
  }
  if (method == HttpMethod.delete) {
    return _onDeleteRequest(context);
  }

  return Response(statusCode: HttpStatus.methodNotAllowed);
}

Future<Response> _onGetRequest(RequestContext context, String id) async {
  final userDataSource = context.read<UsersDataSource>();

  final user = await userDataSource.getUserById(id: id);

  return Response.json(
    body: user,
  );
}

Future<Response> _onPutRequest(RequestContext context) async {
  return Response.json(
    body: [
      {'message:': 'PUT'}
    ],
  );
}

Future<Response> _onDeleteRequest(RequestContext context) async {
  return Response.json(
    body: [
      {'message:': 'DELETE'}
    ],
  );
}

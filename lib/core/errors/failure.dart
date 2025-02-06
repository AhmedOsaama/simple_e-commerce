import 'dart:developer';

import 'package:dio/dio.dart';

abstract class Failure{
  final String message;

  Failure({required this.message});
}

class ServerFailure extends Failure{
  ServerFailure({required super.message});

  factory ServerFailure.fromDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure(message: "Connection Timed out with server");
      case DioExceptionType.sendTimeout:
      // TODO: Handle this case.
        break;
      case DioExceptionType.receiveTimeout:
      // TODO: Handle this case.
        break;
      case DioExceptionType.badCertificate:
      // TODO: Handle this case.
        break;
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(dioException.response!.statusCode!, dioException.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure(message: "Request was cancelled, Please try again");
      case DioExceptionType.connectionError:
        return ServerFailure(message: "Connection Error, Please try again");
      case DioExceptionType.unknown:
        return ServerFailure(message: "Unexpected Error, Please try again");
    }
    return ServerFailure(message: "There was a problem, try again later");
  }

  factory ServerFailure.fromResponse(int statusCode, dynamic response) {
    log("FROM RESPONSE ERROR: $response");
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(message: response['message']);
    } else if (statusCode == 404) {
      return ServerFailure(message: response['message']);
    } else if (statusCode == 500) {
      return ServerFailure(message: "Internal Server Error, try later!");
    } else {
      return ServerFailure(message: "Oops There was an Error, Please try again!");
    }
  }
}
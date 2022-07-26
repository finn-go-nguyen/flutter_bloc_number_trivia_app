// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_bloc_number_trivia_app/core/error/exception.dart';
import 'package:http/http.dart' as http;

import '../models/number_trivia_model.dart';

abstract class NumberTriviaRemoteDataSource {
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number);
  Future<NumberTriviaModel> getRandomNumberTrivia();
}

class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
  final http.Client client;

  NumberTriviaRemoteDataSourceImpl({
    required this.client,
  });

  @override
  Future<NumberTriviaModel> getConcreteNumberTrivia(int number) async {
    return await _getTriviaFromUrl('numbersapi.com', '/$number');
  }

  @override
  Future<NumberTriviaModel> getRandomNumberTrivia() async {
    return await _getTriviaFromUrl('numbersapi.com', '/random');
  }

  Future<NumberTriviaModel> _getTriviaFromUrl(String url, String path) async {
    final respone = await client.get(
      Uri.http(url, path),
      headers: {'Content-Type': 'application/json'},
    );
    if (respone.statusCode != 200) throw ServerException();
    return NumberTriviaModel.fromJson(json.decode(respone.body));
  }
}

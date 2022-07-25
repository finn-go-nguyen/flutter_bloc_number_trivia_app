import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_number_trivia_app/core/error/failures.dart';
import 'package:flutter_bloc_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:flutter_bloc_number_trivia_app/features/number_trivia/domain/repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia {
  final NumberTriviaRepository repository;

  GetConcreteNumberTrivia(this.repository);

  Future<Either<Failures, NumberTrivia>> execute({required int number}) async {
    return await repository.getConcreteNumberTrivia(number);
  }
}
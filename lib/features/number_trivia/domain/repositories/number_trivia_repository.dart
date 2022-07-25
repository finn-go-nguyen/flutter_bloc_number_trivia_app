import 'package:dartz/dartz.dart';
import 'package:flutter_bloc_number_trivia_app/core/error/failures.dart';
import 'package:flutter_bloc_number_trivia_app/features/number_trivia/domain/entities/number_trivia.dart';

abstract class NumberTriviaRepository {
  Future<Either<Failures, NumberTrivia>> getConcreteNumberTrivia(int number);
  Future<Either<Failures, NumberTrivia>> getRandomNumberTrivia();
}

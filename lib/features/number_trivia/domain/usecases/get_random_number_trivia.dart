import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetRandomNumberTrivia extends UseCase<NumberTrivia, NoParams> {
  final NumberTriviaRepository _repository;

  GetRandomNumberTrivia(NumberTriviaRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failures, NumberTrivia>> call(
      {required NoParams params}) async {
    return await _repository.getRandomNumberTrivia();
  }
}

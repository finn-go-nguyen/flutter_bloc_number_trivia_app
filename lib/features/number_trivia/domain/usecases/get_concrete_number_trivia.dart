import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/number_trivia.dart';
import '../repositories/number_trivia_repository.dart';

class GetConcreteNumberTrivia extends UseCase<NumberTrivia, int> {
  final NumberTriviaRepository _repository;

  GetConcreteNumberTrivia(NumberTriviaRepository repository)
      : _repository = repository;

  @override
  Future<Either<Failure, NumberTrivia>> call({required int params}) async {
    return await _repository.getConcreteNumberTrivia(params);
  }
}

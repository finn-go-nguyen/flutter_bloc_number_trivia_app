import 'package:dartz/dartz.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failures, Type>> call({required Params params});
}

class NoParams {}

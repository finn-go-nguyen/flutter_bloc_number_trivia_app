// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_number_trivia_app/core/error/failures.dart';

import 'package:flutter_bloc_number_trivia_app/core/presentation/util/input_converter.dart';
import 'package:flutter_bloc_number_trivia_app/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:flutter_bloc_number_trivia_app/features/number_trivia/domain/usecases/get_random_number_trivia.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/number_trivia.dart';

part 'number_trivia_event.dart';
part 'number_trivia_state.dart';

const String serverFailureMessage = 'Server Failure';
const String cacheFailureMessage = 'Cache Failure';
const String invalidInputFailure =
    'Invalid Input - The number must be a positive integer or zero.';

class NumberTriviaBloc extends Bloc<NumberTriviaEvent, NumberTriviaState> {
  final GetConcreteNumberTrivia getConcreteNumberTrivia;
  final GetRandomNumberTrivia getRandomNumberTrivia;
  final InputConverter inputConverter;

  NumberTriviaBloc({
    required this.getConcreteNumberTrivia,
    required this.getRandomNumberTrivia,
    required this.inputConverter,
  }) : super(Empty()) {
    on<GetTriviaForConcreteNumberEvent>(_onGetTriviaForConcreteNumberEvent);
    on<GetTriviaForRandomNumberEvent>(_onGetTriviaForRandomNumberEvent);
  }

  FutureOr<void> _onGetTriviaForConcreteNumberEvent(
      GetTriviaForConcreteNumberEvent event,
      Emitter<NumberTriviaState> emit) async {
    final inputEither =
        inputConverter.stringToUnsignedInteger(event.numberString);

    await inputEither.fold(
      (failure) async => emit(Error(message: _mapFailureToMessage(failure))),
      (value) async {
        emit(Loading());
        final failureOrTrivia = await getConcreteNumberTrivia(params: value);
        failureOrTrivia.fold(
          (failure) => emit(Error(message: _mapFailureToMessage(failure))),
          (trivia) {
            emit(Loaded(trivia: trivia));
          },
        );
      },
    );
  }

  FutureOr<void> _onGetTriviaForRandomNumberEvent(
      GetTriviaForRandomNumberEvent event,
      Emitter<NumberTriviaState> emit) async {
    emit(Loading());
    final failureOrTrivia = await getRandomNumberTrivia(
      params: NoParams(),
    );
    failureOrTrivia.fold(
      (failure) => emit(Error(message: _mapFailureToMessage(failure))),
      (trivia) => emit(Loaded(trivia: trivia)),
    );
  }
}

String _mapFailureToMessage(Failure failure) {
  // Instead of a regular 'if (failure is ServerFailure)...'
  switch (failure.runtimeType) {
    case ServerFailure:
      return serverFailureMessage;
    case CacheFailure:
      return cacheFailureMessage;
    case InvalidInputFailure:
      return invalidInputFailure;
    default:
      return 'Unexpected Error';
  }
}

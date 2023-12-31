import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

import 'get_concrete_number_trivia_test.mocks.dart';

// class MockNumberTriviaRepository extends Mock
//     implements NumberTriviaRepository {}

@GenerateMocks([NumberTriviaRepository])

void main() {
  late MockNumberTriviaRepository mockNumberTriviaRepository;
  late GetRandomNumberTrivia usecase;


  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetRandomNumberTrivia(mockNumberTriviaRepository);
  });

  final currentNumber = 1;
  final sampleNumberTrivia = NumberTrivia(text: "text", number: currentNumber);


  test(
    'should get trivia for the number from the repository ',
    () async {
      //arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(any))
          .thenAnswer((_) async => Right(sampleNumberTrivia));
      //act
      final result = await usecase(Params(number: currentNumber));
      //assert
      expect(result, Right(sampleNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(currentNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}

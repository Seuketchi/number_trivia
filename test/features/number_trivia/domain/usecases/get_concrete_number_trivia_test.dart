import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:number_trivia/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';

class MockNumberTriviaRepository extends Mock
    implements NumberTriviaRepository {}

void main() {
  late NumberTriviaRepository mockNumberTriviaRepository;
  late GetConcreteNumberTrivia usecase;
  late int currentNumber;
  late NumberTrivia sampleNumberTrivia;

  setUp(() {
    mockNumberTriviaRepository = MockNumberTriviaRepository();
    usecase = GetConcreteNumberTrivia(mockNumberTriviaRepository);
    currentNumber = 1;
    sampleNumberTrivia = NumberTrivia(text: "text", number: currentNumber);
  });


  test(
    'should get trivia for the number from the repository ',
    () async {
      //arrange
      when(mockNumberTriviaRepository.getConcreteNumberTrivia(currentNumber))
          .thenAnswer((_) async => Right(sampleNumberTrivia));
      //act
      final result = await usecase.execute(number: currentNumber);
      //assert
      expect(result, Right(sampleNumberTrivia));
      verify(mockNumberTriviaRepository.getConcreteNumberTrivia(currentNumber));
      verifyNoMoreInteractions(mockNumberTriviaRepository);
    },
  );
}

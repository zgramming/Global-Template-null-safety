import 'package:flutter_test/flutter_test.dart';
import 'package:global_template/functions/global_function.dart';

void main() {
  setUp(() {});

  group(
    'Global Function Test',
    () {
      //? START Iterable
      test('Total range should be max + 1', () {
        /// arrange
        const max = 5;

        /// action
        final result = GlobalFunction.range(min: 0, max: max);

        /// assert
        expect(result.first, 0);
        expect(result.last, 5);
        expect(result.length, max + 1);
      });
      //? END Iterable

      //? START List<T>
      test('Should be get [zeffry, ubur-ubur] from word', () {
        /// arrange
        const word = 'Seorang pria bernama (zeffry) sedang memancing (ubur-ubur)';

        /// action
        final result = GlobalFunction.getStringBetweenCharacter(word);

        /// assert
        expect(result, ['zeffry', 'ubur-ubur']);
      });

      //? END List<T>

      //? START boolean
      test('should return true when today is weekend', () {
        /// arrange
        final today = DateTime(2021, 11, 6);

        /// action
        final isWeekend = GlobalFunction.isWeekend(today);

        /// assert
        expect(isWeekend, true);
      });
      //? END boolean

      //? START String
      test('should be get 1 Hari 10 Jam 59 Menit 10 Detik when function called', () {
        /// arrange
        const duration = Duration(days: 1, hours: 10, minutes: 59, seconds: 10);

        /// action
        final result = GlobalFunction.formatDuration(duration);

        /// assert
        expect(result, '1 Hari 10 Jam 59 Menit 10 Detik');
      });

      test('should be get 089-111-222-333 when function called', () {
        /// arrange
        const numberString = '089111222333';

        /// act
        final result = GlobalFunction.stringWithSeparator(numberString, separateEvery: 3);

        /// assert
        expect(result, '089-111-222-333');
      });
      //? END String
    },
  );
}

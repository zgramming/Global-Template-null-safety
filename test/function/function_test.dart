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
        const numberString = '089111222333';

        const separateEvery = 3;
        const separator = "-";
        final List<String> tempList = [];

        var count = 0;
        while (count < numberString.length) {
          int endSubstring = 0;

          /// Check if current count + separateEvery offset of total length
          /// if offset, take the rest of the available strings
          /// otherwise take string with [rumus] separateEvery + count
          if (separateEvery + count > numberString.length) {
            // 12 + (13-12)
            endSubstring = count + (numberString.length - count);
          } else {
            endSubstring = separateEvery + count;
          }

          final substring = numberString.substring(count, endSubstring);
          tempList.add(substring);
          count += separateEvery;
        }
        final join = tempList.join(separator);
        expect(join, '089-111-222-333');
      });
      //? END String
    },
  );
}

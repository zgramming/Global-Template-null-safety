import 'package:flutter_test/flutter_test.dart';
import 'package:global_template/functions/global_function.dart';
import 'package:global_template/global_template.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUp(() async {
    await initializeDateFormatting(appConfig.indonesiaLocale);
  });

  group(
    'Global Function Test',
    () {
      group('Iterable Function', () {
        //? START Iterable
        test('[GlobalFunction.range] Total range should be max + 1', () {
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
      });

      group('List Function', () {
//? START List<T>
        test(
            '[GlobalFunction.getStringBetweenCharacter] Should be get [zeffry, ubur-ubur] from word',
            () {
          /// arrange
          const word = 'Seorang pria bernama (zeffry) sedang memancing (ubur-ubur)';

          /// action
          final result = GlobalFunction.getStringBetweenCharacter(word);

          /// assert
          expect(result, ['zeffry', 'ubur-ubur']);
        });

        //? END List<T>
      });
      group('Boolean Function', () {
        //? START boolean
        test('[GlobalFunction.isWeekend] should return true when today is weekend', () {
          /// arrange
          final today = DateTime(2021, 11, 6);

          /// action
          final isWeekend = GlobalFunction.isWeekend(today);

          /// assert
          expect(isWeekend, true);
        });
        //? END boolean
      });
      group('String Function', () {
        //? START String
        test(
            '[GlobalFunction.formatDuration] should be get 1 Hari 10 Jam 59 Menit 10 Detik when function called',
            () {
          /// arrange
          const duration = Duration(days: 1, hours: 10, minutes: 59, seconds: 10);

          /// action
          final result = GlobalFunction.formatDuration(duration);

          /// assert
          expect(result, '1 Hari 10 Jam 59 Menit 10 Detik');
        });

        test(
            '[GlobalFunction.stringWithSeparator] should be get 089-111-222-333 when function called',
            () {
          /// arrange
          const numberString = '089111222333';

          /// act
          final result = GlobalFunction.stringWithSeparator(numberString, separateEvery: 3);

          /// assert
          expect(result, '089-111-222-333');
        });

        test('[GlobalFunction.getFirstCharacterEveryWord] Should be get [ZR] when call function',
            () {
          /// arrange
          const string = 'Zeffry Reynando';

          /// act
          final result = GlobalFunction.getFirstCharacterEveryWord(string);

          /// assert
          expect(result, 'ZR');
        });

        test('[GlobalFunction.formatNumber] Should be get 200,000 when call function', () {
          /// arrange
          const value = 200000;

          /// act
          final result = GlobalFunction.formatNumber(value);

          /// assert
          expect(result, '200,000');
        });

        test('[GlobalFunction.unFormatNumber] Should be get 200000 when call function', () {
          /// arrange
          const value = '200,000';

          /// act
          final result = GlobalFunction.unFormatNumber(value);

          /// assert
          expect(result, '200000');
        });

        test('[GlobalFunction.formatH] Should be get 10 when call function', () {
          /// arrange
          final date = DateTime(2021, 10, 10, 10);

          /// act
          final result = GlobalFunction.formatH(date);

          /// assert
          expect(result, '10');
        });

        test('[GlobalFunction.formatHM] Should be get 10:10 when call function', () {
          /// arrange
          final date = DateTime(2021, 10, 10, 10, 10);

          /// act
          final result = GlobalFunction.formatHM(date);

          /// assert
          expect(result, '10:10');
        });

        test('[GlobalFunction.formatHMS] Should be get 10:10:10 when call function', () {
          /// arrange
          final date = DateTime(2021, 10, 10, 10, 10, 10);

          /// act
          final result = GlobalFunction.formatHMS(date);

          /// assert
          expect(result, '10:10:10');
        });

        test('[GlobalFunction.formatD] Should be get Minggu when call function', () {
          /// Minggu, Min
          /// arrange
          final date = DateTime(2021, 10, 10, 10, 10, 10);

          /// act
          // ignore: avoid_redundant_argument_values
          final result = GlobalFunction.formatD(date, format: FormatD.completed);
          final result2 = GlobalFunction.formatD(date, format: FormatD.partially);

          /// assert
          expect(result, 'Minggu');
          expect(result2, 'Min');
        });

        test('[GlobalFunction.formatM] Should be get Oktober when call function', () {
          /// Minggu, Min
          /// arrange
          final date = DateTime(2021, 10, 20, 10, 10, 10);

          /// act
          // ignore: avoid_redundant_argument_values
          final result = GlobalFunction.formatM(date, format: FormatM.completed);
          final result2 = GlobalFunction.formatM(date, format: FormatM.partially);
          final result3 = GlobalFunction.formatM(date, format: FormatM.number);

          /// assert
          expect(result, 'Oktober');
          expect(result2, 'Okt');
          expect(result3, '10');
        });

        test('[GlobalFunction.formatMD] Should be get [Senin, 11 Oktober] when call function', () {
          /// Minggu, Min
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          // ignore: avoid_redundant_argument_values
          final result1 = GlobalFunction.formatMD(date, format: FormatMD.number);

          final result2 = GlobalFunction.formatMD(date, format: FormatMD.numberWithReadableDay);

          final result3 = GlobalFunction.formatMD(date, format: FormatMD.partially);

          final result4 = GlobalFunction.formatMD(date, format: FormatMD.partiallyWithReadableDay);

          final result5 =
              GlobalFunction.formatMD(date, format: FormatMD.partiallyWithReadableMonth);

          // ignore: avoid_redundant_argument_values
          final result6 = GlobalFunction.formatMD(date, format: FormatMD.completed);

          /// assert
          expect(result1, '11/10');
          expect(result2, 'Sen, 11/10');
          expect(result3, '11 Okt');
          expect(result4, 'Sen, 11 Okt');
          expect(result5, '11 Oktober');
          expect(result6, 'Senin, 11 Oktober');
        });

        test('[GlobalFunction.formatY] Should be get [2021] when call function', () {
          /// Minggu, Min
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          // ignore: avoid_redundant_argument_values
          final result = GlobalFunction.formatY(date);

          /// assert
          expect(result, '2021');
        });

        test('[GlobalFunction.formatYM] Should be get [Oktober 2021] when call function', () {
          /// Minggu, Min
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          // ignore: avoid_redundant_argument_values
          final result = GlobalFunction.formatYM(date, format: FormatYM.completed);
          final result2 = GlobalFunction.formatYM(date, format: FormatYM.partially);
          final result3 = GlobalFunction.formatYM(date, format: FormatYM.number);

          /// assert
          expect(result, 'Oktober 2021');
          expect(result2, 'Okt 2021');
          expect(result3, '10/2021');
        });

        test('[GlobalFunction.formatYMD] Should be get [11/10/2021] when call function', () {
          /// Minggu, Min
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          // ignore: avoid_redundant_argument_values
          final result = GlobalFunction.formatYMD(date, format: FormatYMD.number);
          final result2 = GlobalFunction.formatYMD(date, format: FormatYMD.partially);
          final result3 = GlobalFunction.formatYMD(date, format: FormatYMD.completed);

          /// assert
          expect(result, '11/10/2021');
          expect(result2, '11 Okt 2021');
          expect(result3, '11 Oktober 2021');
        });

        test('[GlobalFunction.formatYMDSpecific] Should be get [Oktober 2021] when call function',
            () {
          /// Minggu, Min
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          final result =
              // ignore: avoid_redundant_argument_values
              GlobalFunction.formatYMDSpecific(date, format: FormatYMDSpecific.completed);
          final result2 =
              GlobalFunction.formatYMDSpecific(date, format: FormatYMDSpecific.partially);
          final result3 = GlobalFunction.formatYMDSpecific(date, format: FormatYMDSpecific.number);

          /// assert
          expect(result, 'Senin, 11 Oktober 2021');
          expect(result2, 'Sen, 11 Okt 2021');
          expect(result3, 'Sen, 11/10/2021');
        });

        //? END String
        /// arrange

        /// act

        /// assert
      });
    },
  );
}

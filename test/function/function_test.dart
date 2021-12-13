import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
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
            '[GlobalFunction.formatTimeReadable] Should be get [1 Jam 2 Menit 3 Detik] when call function',
            () {
          /// arrange
          const time = '01:02:03';

          /// act
          final result = GlobalFunction.formatTimeReadable(time);

          /// assert
          expect(result, '1 Jam 2 Menit 3 Detik');
        });
        test(
            '[GlobalFunction.formatDurationReadable] should be get 1 Hari 10 Jam 59 Menit 10 Detik when function called',
            () {
          /// arrange
          const duration = Duration(days: 1, hours: 10, minutes: 59, seconds: 10);

          /// action
          final result = GlobalFunction.formatDurationReadable(duration);

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
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          // ignore: avoid_redundant_argument_values
          final result = GlobalFunction.formatY(date);

          /// assert
          expect(result, '2021');
        });

        test('[GlobalFunction.formatYM] Should be get [Oktober 2021] when call function', () {
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

        test(
            '[GlobalFunction.formatYMDSpecific] Should be get [Senin, 11 Oktober 2021] when call function',
            () {
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

        test('[GlobalFunction.formatYMDH] Should be get [11/10/2021 12] when call function', () {
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          final result = GlobalFunction.formatYMDH(date, formatYmd: FormatYMD.number);

          /// assert
          expect(result, '11/10/2021 12');
        });

        test('[GlobalFunction.formatYMDHM] Should be get [11/10/2021 12:13] when call function',
            () {
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          final result = GlobalFunction.formatYMDHM(date, formatYmd: FormatYMD.number);

          /// assert
          expect(result, '11/10/2021 12:13');
        });

        test('[GlobalFunction.formatYMDHMS] Should be get [11/10/2021 12:13:14] when call function',
            () {
          /// arrange
          final date = DateTime(2021, 10, 11, 12, 13, 14);

          /// act
          final result = GlobalFunction.formatYMDHMS(date, formatYmd: FormatYMD.number);

          /// assert
          expect(result, '11/10/2021 12:13:14');
        });

        test('[GlobalFunction.abbreviateNumber] Should be get [1.5K] when call function', () {
          /// arrange
          const number = 1500;

          /// act
          final result = GlobalFunction.abbreviateNumber(number);

          /// assert
          expect(result, '1.5K');
        });

        test('[GlobalFunction.generateRandomString] Should be get [1.5K] when call function', () {
          /// arrange
          const length = 5;

          /// act
          final generateOnlyNumber1 = GlobalFunction.generateRandomString(
            length,
            rules: GenerateRandomStringRules.onlyNumber,
          );
          final generateOnlyNumber2 = GlobalFunction.generateRandomString(
            length,
            rules: GenerateRandomStringRules.onlyNumber,
          );

          final isEqual = generateOnlyNumber1 == generateOnlyNumber2;

          /// assert
          expect(isEqual, false);
        });

        test('[GlobalFunction.fileSizeReadable] Should be get [60 KB] when call function', () {
          /// arrange
          final file = File('assets/logo.png');

          /// act
          final result = GlobalFunction.fileSizeReadable(file.path);

          /// assert
          expect(result, '60.09 KB');
        });

        //? END String

        group('Integer Function', () {
          //? START Integer
          test('[GlobalFunction.totalDaysOfMonth] Should be get [30] when call function', () {
            /// arrange
            const year = 2021;
            const month = 11;

            /// act
            final result = GlobalFunction.totalDaysOfMonth(year: year, month: month);

            /// assert
            expect(result, 30);
          });

          test('[GlobalFunction.totalDayInYear] Should be get [366] when call function', () {
            /// [https://www.epochconverter.com/days/2020]
            /// arrange
            const year = 2020;

            /// act
            final result = GlobalFunction.totalDayInYear(year);

            /// assert
            expect(result, 366);
          });

          test('[GlobalFunction.totalDayInRangeYear] Should be get [731] when call function', () {
            /// [https://www.epochconverter.com/days/2020]
            /// arrange
            const fromYear = 2020;
            const toYear = 2021;

            /// act
            final result = GlobalFunction.totalDayInRangeYear(fromYear: fromYear, toYear: toYear);

            /// assert
            expect(result, 731);
          });

          test(
              '[GlobalFunction.totalWeekDayOrWeekEnd] Should be get [8, 22, 104, 261] when call function',
              () {
            /// [https://www.epochconverter.com/days/2020]
            /// arrange
            const year = 2021;
            const month = 11;
            const day = 1;

            /// act
            // Get total [Weekend] from day 1 November 2021
            final totalWeekendFrom1November = GlobalFunction.totalWeekDayOrWeekEnd(
              year,
              // ignore: avoid_redundant_argument_values
              month: month,
              // ignore: avoid_redundant_argument_values
              day: day,
              // ignore: avoid_redundant_argument_values
              typeDateTotal: TypeDateTotal.month,
              // ignore: avoid_redundant_argument_values
              typeWeek: TypeWeek.isWeekend,
            );

            // Get total [Weekday] from day 1 November 2021
            final totalWeekdayFrom1November = GlobalFunction.totalWeekDayOrWeekEnd(
              year,
              month: month,
              // ignore: avoid_redundant_argument_values
              day: day,
              // ignore: avoid_redundant_argument_values
              typeDateTotal: TypeDateTotal.month,
              // ignore: avoid_redundant_argument_values
              typeWeek: TypeWeek.isWeekday,
            );

            // Get total [Weekend] from day 1 Januari 2021
            final totalWeekend2021 = GlobalFunction.totalWeekDayOrWeekEnd(
              year,
              // ignore: avoid_redundant_argument_values
              month: 1,
              // ignore: avoid_redundant_argument_values
              day: 1,
              // ignore: avoid_redundant_argument_values
              typeDateTotal: TypeDateTotal.year,
              // ignore: avoid_redundant_argument_values
              typeWeek: TypeWeek.isWeekend,
            );

            // Get total [Weekend] from day 1 Januari 2021
            final totalWeekday2021 = GlobalFunction.totalWeekDayOrWeekEnd(
              year,
              // ignore: avoid_redundant_argument_values
              month: 1,
              // ignore: avoid_redundant_argument_values
              day: 1,
              // ignore: avoid_redundant_argument_values
              typeDateTotal: TypeDateTotal.year,
              // ignore: avoid_redundant_argument_values
              typeWeek: TypeWeek.isWeekday,
            );

            /// assert
            expect(totalWeekendFrom1November, 8);
            expect(totalWeekdayFrom1November, 22);

            expect(totalWeekend2021, 104);
            expect(totalWeekday2021, 261);
          });

          test('[GlobalFunction.getTotalLenghtWord] Should be get 4 when call function', () {
            /// arrange
            const string = 'Zeffry Reynando Tampan Sekali';

            /// act
            final result = GlobalFunction.getTotalLenghtWord(string);

            /// assert
            expect(result, 4);
          });

          test(
              '[GlobalFunction.randomNumber] Should be get number between [0-10] when call function',
              () {
            /// arrange
            const min = 0;
            const max = 10;

            /// act
            // ignore: avoid_redundant_argument_values
            final result = GlobalFunction.randomNumber(min: min, max: max);
            final isBetween = result >= min && result <= max;

            /// assert
            expect(isBetween, true);
          });

          //? END Integer
        });

        group('Map Function', () {
          test('[GlobalFunction.listOfMonth] Should be get [April] when call function', () {
            /// arrange
            const month = 4;

            /// act
            final result = GlobalFunction.listOfMonth();
            final monthName = result[month];

            /// assert
            expect(monthName, 'April');
          });

          test('[GlobalFunction.listOfYear] Should be get [2021] when call function', () {
            /// arrange
            const year = 2021;

            /// act
            final result = GlobalFunction.listOfYear(from: 2000, to: 2021);
            final yearName = result[year];

            /// assert
            expect(yearName, 2021);
          });
        });

        group('Validation Function', () {
          test('[GlobalFunction.validateIsEmpty] Should be return null when call function', () {
            /// arrange
            const isSucess = true;

            /// act
            final result = GlobalFunction.validateIsEmpty('not empty');

            /// assert
            expect(result == null, isSucess);
          });

          test('[GlobalFunction.validateIsEqual] Should be return null when call function', () {
            /// arrange
            const isSucess = true;

            /// act
            final result = GlobalFunction.validateIsEqual('zeffry', 'zeffry');

            /// assert
            expect(result == null, isSucess);
          });

          test('[GlobalFunction.validateIsValidEmail] Should be return null when call function',
              () {
            /// arrange
            const isSucess = true;

            /// act
            final result = GlobalFunction.validateIsValidEmail('zeffry.reynando@gmail.com');

            /// assert
            expect(result == null, isSucess);
          });
        });

        /// arrange

        /// act

        /// assert
      });
    },
  );
}

import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

import '../variable/colors/color_pallete.dart';
import '../variable/config/app_config.dart';
import '../widgets/reusable/detail_single_image.dart';

enum FormatD {
  /// Sen, Sel, Rab, Kam, Jum, Sab, Minggu
  partially,

  /// Senin, Selasa, Rabu, Kamis, Jumat, Sabtu, Minggu
  completed,
}

enum FormatM {
  /// 1, 2, 3, 4, 5...
  number,

  /// Jan, Feb, Mar, Apr ...
  partially,

  /// January, February, Maret, April ...
  completed,
}

enum FormatMD {
  /// DateFormat.Md || 11/10 => day/month
  number,

  /// DateFormat.MEd || Sen, 11/10 => DAY, day/month
  numberWithReadableDay,

  /// DateFormat.MMMd || 11 Okt
  partially,

  /// DateFormat.MMMEd || Sen, 11 Okt
  partiallyWithReadableDay,

  /// DateFormat.MMMMd || 11 Oktober
  partiallyWithReadableMonth,

  /// DateFormat.MMMMEEEEd || Senin, 11 Oktober
  completed,
}

enum FormatYM {
  /// DateFormat.yM || 10/2021 => Month/Year
  number,

  /// DateFormat.yMMM || Okt 2021
  partially,

  /// DateFormat.yMMMM || Oktober 2021
  completed
}

enum FormatYMD {
  /// DateFormat.yMd || 11/10/2021 => Day/Month/Year
  number,

  /// DateFormat.yMMMd || 11 Okt 2021
  partially,

  /// DateFormat.yMMMMd || 11 Oktober 2021
  completed,
}

enum FormatYMDSpecific {
  /// DateFormat.yMEd || Sen, 11/10/2021 => Day, Day/Month/Year
  number,

  /// DateFormat.yMMMEd || Sen, 11 Okt 2021
  partially,

  /// DateFormat.yMMMMEEEEd || Senin, 11 Oktober 2021
  completed,
}

enum GenerateRandomStringRules {
  onlyNumber,
  onlyAlphabet,
  onlyAlphabetLowercase,
  onlyAlphabetUppercase,
  combineNumberAlphabet,
  combineNumberAlphabetLowercase,
  combineNumberAlphabetUppercase,
}

enum ImageViewType { network, file, asset }

enum SlidePosition { fromLeft, fromRight, fromBottom, fromTop }
enum SnackBarShape { rounded, normal }
enum SnackBarType { success, error, warning, info, normal }

enum TimeFormat { jam, jamMenit, jamMenitDetik, menit, menitDetik, detik }
enum ToastPositioned { bottom, center, top }
enum ToastType { success, error, normal }
enum TypeDateTotal { month, year }
enum TypeWeek { isWeekend, isWeekday }

// ignore: avoid_classes_with_only_static_members
class GlobalFunction {
  //? START Future<T>

  /// Detect if user double tap
  static Future<bool> doubleTapToExit(VoidCallback onDoubleTap) async {
    DateTime? _currentBackPressTime;
    final now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      onDoubleTap();
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  /// Get metadata from handphone
  static Future<PackageInfo> packageInfo() async {
    final result = await PackageInfo.fromPlatform();
    return result;
  }

  /// Show [Date] and [Time] picker
  ///
  /// it will return [DateTime?] of selection dateTime picker
  ///
  /// you can choose to only show [date] picker with parameter [withTimePicker]
  static Future<DateTime?> showDateTimePicker(
    BuildContext context, {
    bool withTimePicker = true,
  }) async {
    DateTime? _date;
    TimeOfDay? _time;

    final _datePicker = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_datePicker != null) {
      _date = _datePicker;

      if (withTimePicker) {
        final _timePicker = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );

        if (_timePicker != null) {
          _time = _timePicker;
        }
      }
    }

    if (withTimePicker) {
      if (_date != null && _time != null) {
        return _date.add(Duration(hours: _time.hour, minutes: _time.minute));
      }
    } else {
      if (_date != null) {
        return _date;
      }
    }

    return null;
  }

  /// Show [ModalBottomSheet] and display detail iamge you defined
  /// Page Detail Single Image will [FullScreen]
  static Future showDetailSingleImage(
    BuildContext context, {
    required String url,
    ImageViewType imageViewType = ImageViewType.network,
  }) async {
    Widget image = const SizedBox();
    switch (imageViewType) {
      case ImageViewType.network:
        image = CachedNetworkImage(imageUrl: url);
        break;
      case ImageViewType.asset:
        image = Image.asset(url);
        break;
      case ImageViewType.file:
        image = Image.file(io.File(url));
        break;
      default:
        break;
    }
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: false,
      builder: (context) {
        return DetailSingleImage(image: image);
      },
    );
  }

  /// Show [Dialog] loading
  static Future showDialogLoading(
    BuildContext context, {
    String title = 'Sedang Proses',
  }) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: const [
              CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }

  //? END Future<T>

  //? START Iterable<T>

  ///
  /// Get range of number based on the range you specify
  ///
  /// final numberRange = GlobalFunction.range(10,100);
  ///
  /// print(numberRange) // 10,11,12,13,14,15,...,100
  static Iterable<int> range({
    required int min,
    required int max,
  }) sync* {
    for (int i = min; i <= max; i++) {
      yield i;
    }
  }

  //? END Iterable<T>

  //? START List<T>

  /// String = Zeffry Reynando (Ganteng Sekali), it's 100% (valid)
  ///
  /// we want to get "Ganteng Sekali" & "valid"
  ///
  /// we should defined start & end separator we want to get
  ///
  /// above example we should define [startSeparator = "("] & [endSeparator = ")"]
  ///
  /// ready to go
  ///
  /// Another Variant
  ///
  /// String = "He very very very [start]Handsome[end]"
  ///
  /// [startSeparator = "[start]"] & [endSeparator = "[end]"]
  /// return Handsome
  static List<String>? getStringBetweenCharacter(
    String word, {
    String startSeparator = "(",
    String endSeparator = ")",
  }) {
    // ignore: prefer_interpolation_to_compose_strings
    final regex = RegExp(r'\' + startSeparator + '(.*?)\\' + endSeparator + '');
    final result = regex.allMatches(word);

    if (result.isEmpty) {
      return null;
    }

    final list = result.map((m) => m.group(0)!).toList().map((e) {
      final startIndex = startSeparator.length;
      final endIndex = e.indexOf(endSeparator);
      return e.substring(startIndex, endIndex);
    }).toList();

    return list;
  }

  //? END List<T>

  //? START boolean

  /// return true if today is weekend
  static bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  //? END boolean

  //? START String

  /// Get readable [Duration]
  ///
  /// For now is support only [Days, Hours, Minutes, Seconds]
  ///
  /// final duration = Duration(days: 1,hours: 10,minutes: 59,seconds: 10);
  ///
  /// final result = GlobalFunction.formatDuration(duration);
  ///
  /// print(result) // 1 Hari 10 Jam 59 Menit 10 Detik
  ///
  /// Reference [https://stackoverflow.com/a/60904049/7360353]

  static String formatDuration(
    Duration duration, {
    String separator = ' ',
    String textForDays = 'Hari',
    String textForHours = 'Jam',
    String textForMinutes = 'Menit',
    String textForSeconds = 'Detik',
  }) {
    var seconds = duration.inSeconds;

    final days = seconds ~/ Duration.secondsPerDay;
    seconds -= days * Duration.secondsPerDay;

    final hours = seconds ~/ Duration.secondsPerHour;
    seconds -= hours * Duration.secondsPerHour;

    final minutes = seconds ~/ Duration.secondsPerMinute;
    seconds -= minutes * Duration.secondsPerMinute;

    final List<String> tokens = [];
    if (days != 0) {
      tokens.add('$days $textForDays');
    }

    if (tokens.isNotEmpty || hours != 0) {
      tokens.add('$hours $textForHours');
    }

    if (tokens.isNotEmpty || minutes != 0) {
      tokens.add('$minutes $textForMinutes');
    }

    tokens.add('$seconds $textForSeconds');

    return tokens.join(separator);
  }

  /// Separate string with separator you specify
  ///
  /// const number = 089111222333;
  ///
  /// final result = GlobalFunction.stringWithSeparator('$number', separateEvery: 3);
  ///
  /// print(result); // 089-111-222-333

  static String stringWithSeparator(
    String string, {
    int separateEvery = 4,
    String separator = '-',
  }) {
    final List<String> tempList = [];

    var count = 0;
    while (count < string.length) {
      int endSubstring = 0;

      /// Check if current count + separateEvery offset of total length
      /// if offset, take the rest of the available strings
      /// otherwise take string with [rumus] separateEvery + count
      if (separateEvery + count > string.length) {
        // 12 + (13-12)
        endSubstring = count + (string.length - count);
      } else {
        endSubstring = separateEvery + count;
      }

      final substring = string.substring(count, endSubstring);
      tempList.add(substring);
      count += separateEvery;
    }
    final join = tempList.join(separator);

    return join;
  }

  /// Get First Character From Every Word
  ///
  /// You can specify limit character you want
  ///
  /// final word = "Zeffry Reynando Ganteng Sekali";
  ///
  /// final separate4 = GlobalFunction.getFirstCharacterEveryWord(word,limitTo : 4);
  ///
  /// final separate2 = GlobalFunction.getFirstCharacterEveryWord(word,limitTo : 2);
  ///
  /// print(separate4) // ZRGS
  ///
  /// print(separate2) // ZR
  static String getFirstCharacterEveryWord(
    String string, {
    int limitTo = 5,
  }) {
    if (string.isEmpty) {
      return '';
    }

    return string.trim().split(' ').map((e) => e[0]).take(limitTo).join();
  }

  /// Formatted Number from 200000 to 200,000
  static String formatNumber(int value) {
    final formatter = NumberFormat('#,###');
    final result = formatter.format(value);
    return result;
  }

  /// Unformatted number from 200,000 to 200000
  static String unFormatNumber(String number) {
    final result = number.replaceAll(',', '').trim();
    return result;
  }

  ///* Format Jam
  static String formatH(DateTime date) {
    return DateFormat.H(appConfig.indonesiaLocale).format(date);
  }

  ///* Format : Jam:Menit
  static String formatHM(
    DateTime date, {
    String separator = ":",
  }) {
    return DateFormat.Hm(appConfig.indonesiaLocale).format(date).replaceAll('.', separator);
  }

  ///* Format : Jam:Menit:Detik
  static String formatHMS(
    DateTime date, {
    String separator = ":",
  }) {
    final result = DateFormat.Hms(appConfig.indonesiaLocale).format(date);
    return result.replaceAll('.', separator);
  }

  ///* Format Hari
  static String formatD(
    DateTime date, {
    FormatD format = FormatD.completed,
  }) {
    switch (format) {
      case FormatD.partially:
        return DateFormat.E(appConfig.indonesiaLocale).format(date);

      case FormatD.completed:
        return DateFormat.EEEE(appConfig.indonesiaLocale).format(date);
      default:
        return 'Format Not Valid';
    }
  }

  ///* Format Bulan
  static String formatM(
    DateTime date, {
    FormatM format = FormatM.completed,
  }) {
    switch (format) {
      case FormatM.number:
        return DateFormat.M(appConfig.indonesiaLocale).format(date);
      case FormatM.partially:
        return DateFormat.MMM(appConfig.indonesiaLocale).format(date);
      case FormatM.completed:
        return DateFormat.MMMM(appConfig.indonesiaLocale).format(date);
      default:
        return 'Format Not Valid';
    }
  }

  ///* Format Bulan Hari
  static String formatMD(
    DateTime date, {
    FormatMD format = FormatMD.completed,
  }) {
    switch (format) {
      case FormatMD.number:
        return DateFormat.Md(appConfig.indonesiaLocale).format(date);

      case FormatMD.numberWithReadableDay:
        return DateFormat.MEd(appConfig.indonesiaLocale).format(date);

      case FormatMD.partially:
        return DateFormat.MMMd(appConfig.indonesiaLocale).format(date);

      case FormatMD.partiallyWithReadableDay:
        return DateFormat.MMMEd(appConfig.indonesiaLocale).format(date);

      case FormatMD.partiallyWithReadableMonth:
        return DateFormat.MMMMd(appConfig.indonesiaLocale).format(date);

      case FormatMD.completed:
        return DateFormat.MMMMEEEEd(appConfig.indonesiaLocale).format(date);

      default:
        return 'Format Not Valid';
    }
  }

  ///* Format : Tahun
  static String formatY(DateTime date) {
    return DateFormat.y(appConfig.indonesiaLocale).format(date);
  }

  ///* Format : Tahun:Bulan[type=?]
  static String formatYM(
    DateTime date, {
    FormatYM format = FormatYM.completed,
  }) {
    switch (format) {
      case FormatYM.number:
        return DateFormat.yM(appConfig.indonesiaLocale).format(date);
      case FormatYM.partially:
        return DateFormat.yMMM(appConfig.indonesiaLocale).format(date);
      case FormatYM.completed:
        return DateFormat.yMMMM(appConfig.indonesiaLocale).format(date);

      default:
        return 'Format Not Valid';
    }
  }

  ///* Format : Tahun:Bulan:Hari[type=1/2/3]
  static String formatYMD(
    DateTime date, {
    FormatYMD format = FormatYMD.number,
  }) {
    switch (format) {
      case FormatYMD.number:
        return DateFormat.yMd(appConfig.indonesiaLocale).format(date);

      case FormatYMD.partially:
        return DateFormat.yMMMd(appConfig.indonesiaLocale).format(date);

      case FormatYMD.completed:
        return DateFormat.yMMMMd(appConfig.indonesiaLocale).format(date);

      default:
        return 'Format Not Valid';
    }
  }

  ///* Format : Tahun:Bulan:Hari[type=?]
  ///* Specific disini maksudnya Hari = Senin,Selasa,Rabu,Kamis,Jumat,Sabtu,Minggu
  static String formatYMDSpecific(
    DateTime date, {
    FormatYMDSpecific format = FormatYMDSpecific.completed,
  }) {
    switch (format) {
      case FormatYMDSpecific.number:
        return DateFormat.yMEd(appConfig.indonesiaLocale).format(date);
      case FormatYMDSpecific.partially:
        return DateFormat.yMMMEd(appConfig.indonesiaLocale).format(date);
      case FormatYMDSpecific.completed:
        return DateFormat.yMMMMEEEEd(appConfig.indonesiaLocale).format(date);

      default:
        return 'Format Not Valid';
    }
  }

  ///* Format : Time => Jam Menit
  static String formatTimeTo(
    String time, {
    TimeFormat? timeFormat,
  }) {
    final hour = time.replaceAll(':', '').substring(0, 2);
    final minute = time.replaceAll(':', '').substring(2, 4);
    final second = time.replaceAll(':', '').substring(4, 6);

    String resultHour;
    String resultMinute;
    String resultSecond;

    if (hour.startsWith('0')) {
      resultHour = hour.substring(1);
    } else {
      resultHour = hour;
    }
    if (minute.startsWith('0')) {
      resultMinute = minute.substring(1);
    } else {
      resultMinute = minute;
    }
    if (second.startsWith('0')) {
      resultSecond = second.substring(1);
    } else {
      resultSecond = second;
    }

    switch (timeFormat) {
      case TimeFormat.jam:
        return '$resultHour Jam ';

      case TimeFormat.jamMenit:
        return '$resultHour Jam $resultMinute Menit';

      case TimeFormat.jamMenitDetik:
        return '$resultHour Jam $resultMinute Menit $resultSecond Detik';

      case TimeFormat.menit:
        return '$resultMinute Menit';

      case TimeFormat.menitDetik:
        return '$resultMinute Menit $resultSecond Detik';

      case TimeFormat.detik:
        return '$resultSecond Detik';

      default:
        return '$resultHour Jam $resultMinute Menit $resultSecond Detik';
    }
  }

  ///* Convert from 1000 to 1K || 1500 to 1.5K
  static String abbreviateNumber(int number) {
    final formattedNumber = NumberFormat.compact().format(number);
    return formattedNumber;
  }

  /// Generate random string take [length] parameter to determine number of letter
  /// Rules Available :
  /// [GenerateRandomStringRules.onlyNumber] => 0123456789
  /// [GenerateRandomStringRules.onlyAlphabet] => ABCDEFGHIJabcdefghij
  /// [GenerateRandomStringRules.onlyAlphabetLowercase] => abcdefghij
  /// [GenerateRandomStringRules.onlyAlphabetUppercase] => ABCDEFGHIJ
  /// [GenerateRandomStringRules.combineNumberAlphabet] => ABCDE12345abcde
  /// [GenerateRandomStringRules.combineNumberAlphabetLowercase] => 12345abcde
  /// [GenerateRandomStringRules.combineNumberAlphabetUppercase] => 12345ABCDE
  ///
  static String generateRandomString(
    int length, {
    GenerateRandomStringRules rules = GenerateRandomStringRules.combineNumberAlphabet,
    int minLength = 5,
  }) {
    if (length < minLength) {
      throw Exception('Panjang karakter kurang dari batas minimum karakter');
    }
    var concate = '';

    const lowerCaseCharacter = 'abcdefghijklmnopqrstuvwxyz';
    const upperCaseCharacter = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const number = '1234567890';
    switch (rules) {
      case GenerateRandomStringRules.onlyNumber:
        concate = number;
        break;
      case GenerateRandomStringRules.onlyAlphabet:
        concate = lowerCaseCharacter + upperCaseCharacter;
        break;
      case GenerateRandomStringRules.onlyAlphabetLowercase:
        concate = lowerCaseCharacter;
        break;
      case GenerateRandomStringRules.onlyAlphabetUppercase:
        concate = upperCaseCharacter;
        break;
      case GenerateRandomStringRules.combineNumberAlphabet:
        concate = number + lowerCaseCharacter + upperCaseCharacter;
        break;
      case GenerateRandomStringRules.combineNumberAlphabetLowercase:
        concate = number + lowerCaseCharacter;
        break;
      case GenerateRandomStringRules.combineNumberAlphabetUppercase:
        concate = number + upperCaseCharacter;
        break;
      default:
    }

    final Random _random = Random();

    return String.fromCharCodes(
      Iterable.generate(
        length,
        (_) => concate.codeUnitAt(
          _random.nextInt(concate.length),
        ),
      ),
    );
  }

  ///* Get readable file size [https://github.com/synw/filesize]
  static String readableFileSize(
    String pathFile, {
    int round = 2,
  }) {
    const divider = 1024;
    try {
      if (!io.File(pathFile).existsSync()) {
        throw 'File not Exists !!!';
      }
      final _file = io.File(pathFile);

      final _size = _file.lengthSync();

      if (_size < divider) {
        return '$_size B';
      }

      if (_size < (divider * divider) && _size % divider == 0) {
        return '${(_size / divider).toStringAsFixed(0)} KB';
      }

      if (_size < (divider * divider)) {
        return '${(_size / divider).toStringAsFixed(round)} KB';
      }

      if (_size < divider * divider * divider && _size % divider == 0) {
        return '${(_size / (divider * divider)).toStringAsFixed(0)} MB';
      }

      if (_size < divider * divider * divider) {
        return '${(_size / divider / divider).toStringAsFixed(round)} MB';
      }

      if (_size < divider * divider * divider * divider && _size % divider == 0) {
        return '${(_size / (divider * divider * divider)).toStringAsFixed(0)} GB';
      }

      if (_size < divider * divider * divider * divider) {
        return '${(_size / divider / divider / divider).toStringAsFixed(round)} GB';
      }

      if (_size < divider * divider * divider * divider * divider && _size % divider == 0) {
        final num r = _size / divider / divider / divider / divider;
        return '${r.toStringAsFixed(0)} TB';
      }

      if (_size < divider * divider * divider * divider * divider) {
        final num r = _size / divider / divider / divider / divider;
        return '${r.toStringAsFixed(round)} TB';
      }

      if (_size < divider * divider * divider * divider * divider * divider &&
          _size % divider == 0) {
        final num r = _size / divider / divider / divider / divider / divider;
        return '${r.toStringAsFixed(0)} PB';
      } else {
        final num r = _size / divider / divider / divider / divider / divider;
        return '${r.toStringAsFixed(round)} PB';
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  //? END String

  ///* Mendapatkan total hari pada tahun dan bulan yang ditentukan
  ///* @param       => year
  ///* @param       => month
  ///* @return      => integer
  ///* @penggunaan
  ///* final _totalDayOfMonth = totalDaysOfMonth(2020, 10)

  static int totalDaysOfMonth({
    required int year,
    required int month,
  }) {
    final result = (month < 12) ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
    return result.day;
  }

  ///* Mendatkan Total Hari Pada Tahun yang ditentukan
  ///* @param      => year
  ///* @return     => integer
  ///* @penggunaan
  ///* final total = totalDayInYear(2020) => menghasilkan total hari ditahun 2020 [366 Day]

  static int totalDayInYear(int year) {
    var tempTotalDayInYear = 0;
    const totalMonthInYear = 12;
    for (int i = 1; i <= totalMonthInYear; i++) {
      final totalDay = totalDaysOfMonth(year: year, month: i);
      tempTotalDayInYear += totalDay;
    }

    return tempTotalDayInYear;
  }

  ///* Mendapatkan total hari dari range year yang ditentukan
  ///* @param   => from
  ///* @param   => to
  ///* @return  => integer
  ///* @penggunaan
  ///* case 1
  ///* final total = totalDayInRangeYear(2020,2021) => menghasilkan total hari ditahun 2020 [366 Day]
  ///* case 2
  ///* final total = totalDayInRangeYear(2020,2022) => menghasilkan total hari dari tahun 2020-2022 [731 Day]

  static int totalDayInRangeYear({
    required int from,
    required int to,
  }) {
    if (from > to) {
      throw Exception("Year From can't be greather than Year To");
    }

    if (from == to) {
      return totalDayInYear(from);
    }

    final yFrom = DateTime(from);
    final yTo = DateTime(to);

    return yTo.difference(yFrom).inDays;
  }

  ///* Mendapatkan total WeekDay / WeekEnd berdasarkan kriteria :
  ///* Tipenya [WeekDay / WeekEnd]
  ///* Tipe perhitungan [Bulan / Tahun]
  ///* @Penggunaan
  ///* final totalWeekDayOrWeekEnd = GlobalTemplate.totalWeekDayOrWeekEnd(2021,month: 1,day: 1,typeWeek: TypeWeek.isWeekend,typeDateTotal: TypeDateTotal.Year);

  static int totalWeekDayOrWeekEnd(
    int year, {
    int month = 1,
    int day = 1,
    TypeWeek typeWeek = TypeWeek.isWeekday,
    TypeDateTotal typeDateTotal = TypeDateTotal.month,
  }) {
    final totalDay = (typeDateTotal == TypeDateTotal.month)
        ? totalDaysOfMonth(year: year, month: month)
        : totalDayInRangeYear(from: year - 1, to: year);

    var weekDay = 0;
    var weekEnd = 0;

    var tempDateTime = DateTime(year, month, day);
    for (var i = day; i <= totalDay; i++) {
      tempDateTime = DateTime(tempDateTime.year, tempDateTime.month, i);
      if (tempDateTime.weekday == DateTime.saturday || tempDateTime.weekday == DateTime.sunday) {
        weekEnd++;
//         print('weekEnd || $i');
      } else {
        weekDay++;
//         print('weekDay || $i');
      }
    }

    final result = (typeWeek == TypeWeek.isWeekend) ? weekEnd : weekDay;
    return result;
  }

  /// Get total length word
  /// With the separator i.e space
  static int getTotalLenghtWord(
    String string, {
    int? substract,
  }) {
    final length = string.split(' ').length;
    int result;
    if (substract != null) {
      if (length - substract <= 0) {
        result = 1;
      } else {
        result = length - substract;
      }
    } else {
      result = length;
    }

    return result;
  }

  /// randomNumber(10 ,100)
  /// will output : 10,55,95,99 ..etc..
  static int randomNumber({
    int min = 0,
    int max = 100,
  }) {
    if (min > max) {
      throw Exception("Min can't be greather than max");
    }

    if (max < min) {
      throw Exception("Max can't be less than min");
    }
    final rn = Random();
    return min + rn.nextInt(max - min);
  }

  ///* Mendapatkan warna acak dari kumpulan warna yang sudah ditentukan
  ///* @return    => Color
  static Color getRandomColor() {
    final _random = Random();
    final color = colorPallete.arrColor[_random.nextInt(colorPallete.arrColor.length)];
    return color;
  }

  ///* Memunculkan dialog untuk membutuhkan akses
  static void showDialogNeedAccess(
    BuildContext context, {
    VoidCallback? onPressed,
  }) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Membutuhkan akses'),
        content: const Text(
          "Sepertinya kamu sebelumnya menolak untuk memberikan akses, untuk menggunakan aplikasi silahkan berikan akses",
        ),
        actions: [
          TextButton(
            onPressed: onPressed,
            child: const Text('Buka Setting'),
          ),
        ],
      ),
    );
  }

  ///* Memunculkan snackbar

  static void showSnackBar(
    BuildContext context, {
    required Widget content,
    bool hideWithAnimation = true,
    SnackBarAction? action,
    Animation<double>? animation,
    Color? backgroundColor,
    SnackBarBehavior? behaviour,
    Duration duration = const Duration(seconds: 4),
    double? elevation,

    /// If margin not null , set default behaviour = SnackBarBehaviour.floating
    EdgeInsetsGeometry? margin,
    EdgeInsetsGeometry? padding,
    ShapeBorder? shape,
    double? width,
    SnackBarType snackBarType = SnackBarType.normal,
    SnackBarShape snackBarShape = SnackBarShape.normal,
  }) {
    final scaffoldMessager = ScaffoldMessenger.of(context);

    if (hideWithAnimation) {
      scaffoldMessager.hideCurrentSnackBar();
    } else {
      scaffoldMessager.removeCurrentSnackBar();
    }

    if (margin != null) {
      // ignore: parameter_assignments
      behaviour = SnackBarBehavior.floating;
    }

    switch (snackBarType) {
      case SnackBarType.success:
        backgroundColor = Colors.green;
        break;

      case SnackBarType.error:
        backgroundColor = Colors.red;
        break;

      case SnackBarType.warning:
        backgroundColor = Colors.orange;
        break;

      case SnackBarType.info:
        backgroundColor = Colors.lightBlue;
        break;

      default:
        // ignore: parameter_assignments
        backgroundColor = backgroundColor;
        break;
    }

    switch (snackBarShape) {
      case SnackBarShape.rounded:
        shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(15));
        break;
      default:
        // ignore: parameter_assignments
        shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(0));
        break;
    }

    scaffoldMessager.showSnackBar(
      SnackBar(
        content: content,
        action: action,
        animation: animation,
        backgroundColor: backgroundColor,
        behavior: behaviour,
        duration: duration,
        elevation: elevation,
        margin: margin,
        padding: padding,
        shape: shape,
        width: width,
      ),
    );
  }

  static Map<int, String> listOfMonth() {
    return {
      1: 'Januari',
      2: 'Februari',
      3: 'Maret',
      4: 'April',
      5: 'Mei',
      6: 'Juni',
      7: 'Juli',
      8: 'Agustus',
      9: 'September',
      10: 'Oktober',
      11: 'November',
      12: 'Desember',
    };
  }

  static Map<int, int> listOfYear({
    required int from,
    required int to,
  }) {
    return {
      for (var i = from; i <= to; i++) i: i,
    };
  }

  static String? validateIsEmpty(String? value, [String message = 'Input tidak boleh kosong']) {
    if (value?.isEmpty ?? true) {
      return message;
    }
    return null;
  }

  static String? validateIsEqual(
    String? value1,
    String? value2, [
    String message = 'input tidak matching',
  ]) {
    if (value1 != value2) {
      return message;
    }
    return null;
  }

  static String? validateIsValidEmail(String? value, [String message = 'Email tidak valid']) {
    final bool emailValid =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(value ?? 'zeffry.reynando@gmail.com');
    if (!emailValid) {
      return message;
    }
    return null;
  }

  ///* Check if value in list already exist/not
  static T? isValueExistObject<T>(
    List<T> checkedList,
    T newValue, {
    required bool Function(T element) check,
  }) {
    var isExist = false;

    for (final list in checkedList) {
      if (check(list)) {
        isExist = true;
        break;
      } else {
        isExist = false;
      }
    }

    final result = isExist ? null : newValue;
    return result;
  }

  ///* JSON Converter

  ///* Mengubah hasil dari json ke [String => Integer]
  ///* @param     => String
  ///* @return    => Integer?

  static int? fromJsonStringToInteger(dynamic value) => int.tryParse(value.toString());

  ///* Mengubah hasil ke json dari [Integer? => String]
  ///* @param     => Integer?
  ///* @return    => String?

  static String? toJsonStringFromInteger(int? value) => value?.toString();

  ///* Mengubah hasil dari json dari [Integer? => DateTime]
  ///* @param     => Integer?
  ///* @return    => DateTime?

  static DateTime? fromJsonMilisecondToDateTime(int? value) => value == null
      ? null
      : DateTime.fromMillisecondsSinceEpoch(
          value,
        );

  ///* Mengubah hasil ke json dari [DateTime? => Integer]
  ///* @param     => DateTime?
  ///* @return    => Integer?
  static int? toJsonMilisecondFromDateTime(DateTime? date) => date?.millisecondsSinceEpoch;

  static Map<String, dynamic> fromJsonMapObjectToMap(Map map) => Map<String, dynamic>.from(map);
  static String toJsonStringFromMap(Map<String, dynamic> map) => json.encode(map);
}

class InputNumberFormat extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    } else if (newValue.text.compareTo(oldValue.text) != 0) {
      final selectionIndexFromTheRight = newValue.text.length - newValue.selection.end;
      final f = NumberFormat('#,###');
      final num = int.parse(newValue.text.replaceAll(f.symbols.GROUP_SEP, ''));
      final newString = f.format(num);
      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndexFromTheRight,
        ),
      );
    } else {
      return newValue;
    }
  }
}

class RouteAnimation {
  PageRouteBuilder rotationTransition({
    required Widget Function(
      BuildContext ctx,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    )
        screen,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  }) {
    const begin = 0.0;
    const end = 1.0;
    final tween = Tween(begin: begin, end: end);
    return PageRouteBuilder(
      pageBuilder: screen,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final rotationAnimation = animation.drive(tween);
        return RotationTransition(turns: rotationAnimation, child: child);
      },
    );
  }

  PageRouteBuilder scaleTransition({
    required Widget Function(
      BuildContext ctx,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    )
        screen,
    Alignment alignment = Alignment.bottomLeft,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  }) {
    const begin = 0.0;
    const end = 1.0;
    final tween = Tween(begin: begin, end: end);

    return PageRouteBuilder(
      pageBuilder: screen,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final scaleAnimation = animation.drive(tween);
        return ScaleTransition(
          scale: scaleAnimation,
          alignment: alignment,
          child: child,
        );
      },
    );
  }

  PageRouteBuilder fadeTransition({
    required Widget Function(
      BuildContext ctx,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    )
        screen,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  }) {
    const begin = 0.0;
    const end = 1.0;
    final tween = Tween(begin: begin, end: end);
    return PageRouteBuilder(
      pageBuilder: screen,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeAnimation = animation.drive(tween);
        return FadeTransition(opacity: fadeAnimation, child: child);
      },
    );
  }

  PageRouteBuilder slideTransition({
    required Widget Function(
      BuildContext ctx,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
    )
        screen,
    SlidePosition slidePosition = SlidePosition.fromBottom,
    Duration transitionDuration = const Duration(milliseconds: 300),
    Duration reverseTransitionDuration = const Duration(milliseconds: 300),
  }) {
    var begin = Offset.zero;
    const end = Offset.zero;

    switch (slidePosition) {
      case SlidePosition.fromBottom:
        begin = const Offset(0, 1);
        break;
      case SlidePosition.fromTop:
        begin = const Offset(0, -1);
        break;
      case SlidePosition.fromLeft:
        begin = const Offset(1, 0);
        break;
      case SlidePosition.fromRight:
        begin = const Offset(-1, 0);
        break;
      default:
        begin = Offset.zero;
        break;
    }
    final tween = Tween(begin: begin, end: end);
    return PageRouteBuilder(
      pageBuilder: screen,
      transitionDuration: transitionDuration,
      reverseTransitionDuration: reverseTransitionDuration,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;

  Debouncer({
    this.milliseconds = 1000,
  });

  void run(VoidCallback action) {
    if (_timer != null) {
      _timer?.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  void dispose() {
    _timer?.cancel();
  }
}

class CustomException {
  final String message;

  CustomException(this.message);

  @override
  String toString() => message;
}

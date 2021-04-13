import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:global_template/global_template.dart';
import 'package:intl/intl.dart';
import 'package:package_info/package_info.dart';

enum TimeFormat { jam, jamMenit, jamMenitDetik, menit, menitDetik, detik }
enum ToastPositioned { bottom, center, top }
enum ToastType { success, error, normal }
enum TypeWeek { isWeekend, isWeekday }
enum TypeDateTotal { month, year }
enum SnackBarType { success, error, warning, info, normal }
enum SnackBarShape { rounded, normal }
enum SlidePosition { fromLeft, fromRight, fromBottom, fromTop }

// ignore: avoid_classes_with_only_static_members
class GlobalFunction {
  static final DefaultCacheManager _cacheManager = DefaultCacheManager();

  /// Fungsi untuk Meng-compare 2 Build versi dari server dan aplikasi.
  /// Akan return [TRUE] jika aplikasi sudah terbaru sebaliknya [FALSE]
  static bool isLatestVersion({
    /// Versi Aplikasi di Mobile
    required int currentBuildNumber,

    /// Versi Aplikasi Dari Server
    required int newestBuildNumber,
  }) {
    if (currentBuildNumber >= newestBuildNumber) {
      return true;
    }
    return false;
  }

  static void clearCacheApp() {
    GlobalFunction._cacheManager.emptyCache();
  }

  ///*------------------------------------------------------------------------------------------------------------
  ///* Add Separator in String
  static String stringWithSeparator(
    String string, {
    int separateEvery = 4,
    String separator = '-',
  }) {
    var result = 'Invalid String';

    if (string.isNotEmpty) {
      final value = string.replaceAllMapped(
          // ignore: unnecessary_raw_strings
          RegExp(r'.{' '${separateEvery.toString()}' '}'),
          (match) => '${match.group(0)}$separator');

      if (string.length % separateEvery == 0) {
        result = value.substring(0, value.length - 1);
      } else {
        result = value;
      }
    }

    return result;
  }

  ///* Get First Character From Every Word
  static String getFirstCharacter({required String string, int? limitTo}) {
    if (string.isNotEmpty) {
      return string.trim().split(' ').map((e) => e[0]).take(limitTo!).join();
    } else {
      return '';
    }
  }

  ///* Fungsi Untuk Mem-format Angka . Dari 200000 => 200,000
  static String formatNumber(int value, [String string = '']) {
    final formatter = NumberFormat('#,###');
    final result = formatter.format(value);
    return result;
  }

  /// Fungsi Untuk meng-unformat angka . Dari 200,000 => 200000
  static String unFormatNumber(String number) {
    // print('Sebelum di Format $number');
    final result = number.replaceAll(',', '').trim();
    return result;
  }

  /// Format Jam
  static String formatH(DateTime date) {
    return DateFormat.H(appConfig.indonesiaLocale).format(date);
  }

  /// Format : Jam:Menit
  static String formatHM(DateTime date) {
    return DateFormat.Hm(appConfig.indonesiaLocale).format(date);
  }

  /// Format : Jam:Menit:Detik
  static String formatHMS(DateTime date) {
    final result = DateFormat.Hms(appConfig.indonesiaLocale).format(date);
    return result.replaceAll('.', ':');
  }

  /// Format Hari
  static String formatD(DateTime date, {int type = 2}) {
    if (type == 1) {
      return DateFormat.E(appConfig.indonesiaLocale).format(date);
    } else {
      return DateFormat.EEEE(appConfig.indonesiaLocale).format(date);
    }
  }

  /// Format Bulan
  static String formatM(DateTime date, {int type = 1}) {
    switch (type) {
      case 1:
        return DateFormat.M(appConfig.indonesiaLocale).format(date);
      case 2:
        return DateFormat.MMM(appConfig.indonesiaLocale).format(date);
      case 3:
        return DateFormat.MMMM(appConfig.indonesiaLocale).format(date);
      default:
        return DateFormat.MMMM(appConfig.indonesiaLocale).format(date);
    }
  }

  /// Format Bulan Hari
  static String formatMD(DateTime date, {int type = 1}) {
    switch (type) {
      case 1:
        return DateFormat.MMMd(appConfig.indonesiaLocale).format(date);
      case 2:
        return DateFormat.MMMEd(appConfig.indonesiaLocale).format(date);
      case 3:
        return DateFormat.MMMMd(appConfig.indonesiaLocale).format(date);
      case 4:
        return DateFormat.MMMMEEEEd(appConfig.indonesiaLocale).format(date);
      default:
        return DateFormat.MMMMEEEEd(appConfig.indonesiaLocale).format(date);
    }
  }

  /// Format : Tahun
  static String formatY(DateTime date) {
    return DateFormat.y(appConfig.indonesiaLocale).format(date);
  }

  /// Format : Tahun:Bulan[type=?]
  static String formatYM(DateTime date, {int type = 3}) {
    if (type == 1) {
      return DateFormat.yM(appConfig.indonesiaLocale).format(date);
    } else if (type == 2) {
      return DateFormat.yMMM(appConfig.indonesiaLocale).format(date);
    } else if (type == 3) {
      return DateFormat.yMMMM(appConfig.indonesiaLocale).format(date);
    } else {
      return DateFormat.yMMMM(appConfig.indonesiaLocale).format(date);
    }
  }

  /// Format : Tahun:Bulan:Hari[type=1/2/3]
  static String formatYMD(DateTime date, {int type = 1}) {
    if (type == 1) {
      return DateFormat.yMd(appConfig.indonesiaLocale).format(date);
    } else if (type == 2) {
      return DateFormat.yMMMd(appConfig.indonesiaLocale).format(date);
    } else if (type == 3) {
      return DateFormat.yMMMMd(appConfig.indonesiaLocale).format(date);
    } else {
      return DateFormat.yMMMMd(appConfig.indonesiaLocale).format(date);
    }
  }

  /// Format : Tahun:Bulan:Hari[type=?] , Specific disini maksudnya Hari = Senin,Selasa,Rabu,Kamis,Jumat,Sabtu,Minggu
  static String formatYMDS(DateTime date, {int type = 3}) {
    if (type == 1) {
      return DateFormat.yMEd(appConfig.indonesiaLocale).format(date);
    } else if (type == 2) {
      return DateFormat.yMMMEd(appConfig.indonesiaLocale).format(date);
    } else if (type == 3) {
      return DateFormat.yMMMMEEEEd(appConfig.indonesiaLocale).format(date);
    } else {
      return DateFormat.yMMMMEEEEd(appConfig.indonesiaLocale).format(date);
    }
  }

  /// Format : Time => Jam Menit
  static String formatTimeTo(
    String time, {
    TimeFormat? timeFormat,
  }) {
    final hour = time.replaceAll(':', '').substring(0, 2);
    final minute = time.replaceAll(':', '').substring(2, 4);
    final second = time.replaceAll(':', '').substring(4, 6);
    String resultHour, resultMinute, resultSecond;
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

  static String abbreviateNumber(int number) {
    final formattedNumber = NumberFormat.compact().format(number);
    return formattedNumber;
  }

  ///* Get readable file size [https://github.com/synw/filesize]
  static dynamic getFileSize(
    String pathFile, {
    int round = 2,
    bool isReadable = true,
  }) {
    const divider = 1024;
    try {
      if (!File(pathFile).existsSync()) {
        throw 'File not Exists !!!';
      }
      final _file = File(pathFile);
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

  ///* Mendapatkan Total Hari Pada bulan X
  static int totalDaysOfMonth(int year, int month) {
    final result = (month < 12) ? DateTime(year, month + 1, 0) : DateTime(year + 1, 1, 0);
    return result.day;
  }

  ///* Mendatkan Total Hari Pada Tahun X
  static int totalDayOfYear(int year1, int year2) {
    final date1 = DateTime(year1);
    final date2 = DateTime(year2);
    return date2.difference(date1).inDays;
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
        ? totalDaysOfMonth(year, month)
        : totalDayOfYear(year - 1, year);

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

  static int getTotalLenghtWord(String string, {int? substract}) {
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

  static Future<PackageInfo> packageInfo() async {
    final result = await PackageInfo.fromPlatform();
    return result;
  }

  static Color getRandomColor() {
    final _random = Random();
    final color = colorPallete.arrColor[_random.nextInt(colorPallete.arrColor.length)];
    return color;
  }

  /// * Mendapatkan apakah hari ini weekend / tidak
  static bool isWeekend(int year, int month, int day) {
    final date = DateTime(year, month, day);
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
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
            "Sepertinya kamu sebelumnya menolak untuk memberikan akses, untuk menggunakan aplikasi silahkan berikan akses"),
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
    BuildContext ctx, {
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
    final scaffoldMessager = ScaffoldMessenger.of(ctx);

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

  ///* Ketuk 2 Kali Untuk Keluar
  static Future<bool> doubleTapToExit(BuildContext ctx) async {
    DateTime? _currentBackPressTime;
    final now = DateTime.now();
    if (_currentBackPressTime == null ||
        now.difference(_currentBackPressTime) > const Duration(seconds: 2)) {
      _currentBackPressTime = now;
      GlobalFunction.showSnackBar(ctx, content: const Text('Tekan kembali untuk keluar aplikasi'));
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  ///* Memunculkan loading modal dialog
  static Future showDialogLoading(BuildContext context, {String title = 'Sedang Proses'}) async {
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
            BuildContext ctx, Animation<double> animation, Animation<double> secondaryAnimation)
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
        // return FadeTransition();
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
        // return FadeTransition();
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
        // return FadeTransition();
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
    var begin = const Offset(0, 0);
    const end = Offset(0, 0);

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
        begin = const Offset(0, 0);
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
        // return FadeTransition();
      },
    );
  }
}

import 'dart:async';
import 'dart:io';

class ReusableRequestServer {
  static Future<T> requestServer<T>(
    FutureOr<T> Function() requestServer, {
    Duration durationTimeout = const Duration(seconds: 30),
  }) async {
    try {
      return await requestServer();
    } on FormatException catch (error) {
      throw error.message;
    } on TimeoutException catch (_) {
      rethrow;
    } on SocketException catch (_) {
      rethrow;
    } catch (e) {
      throw e.toString();
    }
  }
}

// final ReusableRequestServer reusableRequestServer = ReusableRequestServer();

import 'dart:developer' as developer;

class PerformanceLogger {
  static final PerformanceLogger _instance = PerformanceLogger._internal();
  static PerformanceLogger get instance => _instance;

  PerformanceLogger._internal();

  final Map<String, DateTime> _startTimes = {};

  void startOperation(String operationName) {
    _startTimes[operationName] = DateTime.now();
    developer.log('🚀 BAŞLADI: $operationName', name: 'PERFORMANCE');
  }

  void endOperation(String operationName) {
    if (_startTimes.containsKey(operationName)) {
      final startTime = _startTimes[operationName]!;
      final duration = DateTime.now().difference(startTime);
      developer.log('✅ TAMAMLANDI: $operationName - Süre: ${duration.inMilliseconds}ms', name: 'PERFORMANCE');
      _startTimes.remove(operationName);
    } else {
      developer.log('❌ HATA: $operationName işlemi başlatılmadan bitirilmeye çalışıldı', name: 'PERFORMANCE');
    }
  }

  void logMessage(String message) {
    developer.log('ℹ️ BİLGİ: $message', name: 'PERFORMANCE');
  }

  void logWarning(String message) {
    developer.log('⚠️ UYARI: $message', name: 'PERFORMANCE');
  }

  void logError(String message) {
    developer.log('🔴 HATA: $message', name: 'PERFORMANCE');
  }

  void logDataFetch(String source, dynamic data, {bool isDetailed = false}) {
    if (isDetailed) {
      developer.log('📊 VERİ ÇEKİLDİ: $source - Veri: $data', name: 'PERFORMANCE');
    } else {
      developer.log('📊 VERİ ÇEKİLDİ: $source - Boyut: ${data?.toString().length ?? 0} karakter', name: 'PERFORMANCE');
    }
  }
}

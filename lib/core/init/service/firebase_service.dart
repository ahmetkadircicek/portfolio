import 'dart:async';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:portfolio/core/utils/performance_logger.dart';
import 'package:universal_html/html.dart' as html;

abstract class IFirebaseService {
  Future<void> downloadFromUrl();
}

class FirebaseService extends IFirebaseService {
  static FirebaseService? _instance;
  final _logger = PerformanceLogger.instance;

  FirebaseService._internal();
  factory FirebaseService() {
    _instance ??= FirebaseService._internal();
    return _instance!;
  }

  @override
  Future<void> downloadFromUrl() async {
    _logger.startOperation('DownloadCVFromFirebase');
    try {
      _logger.logMessage('Accessing Firebase Storage');
      final storageRef = FirebaseStorage.instance.ref();

      _logger.startOperation('GetPDFReference');
      final pdfRef = storageRef.child('gs://portfolio-9e0f3.appspot.com/CV25.pdf');
      _logger.endOperation('GetPDFReference');

      void downloadFile(String url) {
        _logger.logMessage('Creating download link for CV');
        html.AnchorElement anchorElement = html.AnchorElement(href: url);
        anchorElement.download = url;
        anchorElement.click();
      }

      _logger.startOperation('GetDownloadURL');
      String downloadURL = await pdfRef.getDownloadURL();
      _logger.endOperation('GetDownloadURL');

      _logger.logMessage('Download URL obtained: ${downloadURL.substring(0, 50)}...');
      downloadFile(downloadURL);
      _logger.logMessage('CV download initiated');
    } catch (e) {
      _logger.logError('Error downloading CV: $e');
    } finally {
      _logger.endOperation('DownloadCVFromFirebase');
    }
  }
}

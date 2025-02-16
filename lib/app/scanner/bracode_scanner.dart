import 'package:flutter/services.dart';
import 'package:google_mlkit_barcode_scanning/google_mlkit_barcode_scanning.dart';

class BarcodeScanner {
  static const MethodChannel _channel =
      MethodChannel('google_mlkit_barcode_scanning');

  /// List that restrict the scan to specific barcode formats.
  final List<BarcodeFormat> formats;

  /// Instance id.
  final id = DateTime.now().microsecondsSinceEpoch.toString();

  /// Constructor to create an instance of [BarcodeScanner].
  /// Returns a barcode scanner with the given [formats] options.
  BarcodeScanner({this.formats = const [BarcodeFormat.all]});

  /// Processes the given [InputImage] for barcode scanning. Returns a list of [Barcode].
  Future<List<Barcode>> processImage(InputImage inputImage) async {
    final result = await _channel.invokeMethod('vision#startBarcodeScanner', {
      'formats': formats.map((f) => f.rawValue).toList(),
      'id': id,
      'imageData': inputImage.toJson()
    });

    final barcodesList = <Barcode>[];
    for (final dynamic json in result) {
      barcodesList.add(Barcode.fromJson(json));
    }

    return barcodesList;
  }

  /// Closes the scanner and releases its resources.
  Future<void> close() =>
      _channel.invokeMethod('vision#closeBarcodeScanner', {'id': id});
}

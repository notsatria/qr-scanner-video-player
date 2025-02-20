import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler_platform_interface/permission_handler_platform_interface.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';
import 'package:ruang_ngaji_kita/app/video_player/video_player_page.dart';
import 'package:ruang_ngaji_kita/utils/app_settings_helper.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  final PermissionHandlerPlatform _permissionHandler =
      PermissionHandlerPlatform.instance;
  PermissionStatus _permissionStatus = PermissionStatus.denied;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void initState() {
    _listenForPermissionStatus();
    super.initState();
  }

  void _listenForPermissionStatus() async {
    final status =
        await _permissionHandler.checkPermissionStatus(Permission.camera);

    if (mounted) {
      setState(() => _permissionStatus = status);

      if (status == PermissionStatus.denied ||
          status == PermissionStatus.permanentlyDenied) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          showNoPermissionDialog();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: Text('Scan QR',
            style: TextStyle(color: theme.colorScheme.onPrimary)),
        actions: [
          IconButton(
              onPressed: () async {
                await controller?.flipCamera();
                setState(() {});
              },
              icon: const Icon(Icons.flip_camera_android))
        ],
      ),
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: buildQrView(context)),
        ],
      ),
    );
  }

  Widget buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.red,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
        if (scanData.code != null &&
            scanData.code!.isNotEmpty &&
            scanData.format == BarcodeFormat.qrcode) {
          log('scanner_page scanData: $scanData');
          if (result?.code != null &&
              result!.code!.isNotEmpty &&
              result!.format == BarcodeFormat.qrcode) {
            Navigator.pop(context); // Tutup dialog
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => VideoPlayerPage(url: result!.code!)),
            );
          }
        }
      });
    });
  }

  void onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      showNoPermissionDialog();
    }
  }

  void showNoPermissionDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Peringatan'),
        content: const Text(
            'Anda diwajibkan untuk mengaktifkan izin akses kamera untuk menggunakan fitur ini'),
        actions: [
          TextButton(
              onPressed: () {
                _openSettings();
                Navigator.pop(context);
              },
              child: const Text('Buka pengaturan'))
        ],
      ),
    );
  }

  void _openSettings() async {
    bool isSuccess = await AppSettingsHelper.openAppSettings();
    if (isSuccess) {
      log("Berhasil membuka pengaturan aplikasi");
    } else {
      log("Gagal membuka pengaturan aplikasi");
    }
  }
}

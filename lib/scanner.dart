import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_code_scanner/src/qr_scanner_overlay_shape.dart';

class Scanner extends StatefulWidget {
  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  bool _flashOn = false;
  bool _cameraFront = false;
  GlobalKey _qrKey = GlobalKey();
  QRViewController? _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          QRView(
              key: _qrKey,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.white,
                borderRadius: 10,
                borderWidth: 15,
              ),
              onQRViewCreated: (QRViewController controller) {
                _controller = controller;
                controller.scannedDataStream.listen((event) {
                  if (mounted) {
                    _controller?.dispose();
                    Navigator.of(context).pop(event.code);
                  }
                });
              }),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(top: 50),
              child: Text(
                "QR Scanner",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(_flashOn ? Icons.flash_on : Icons.flash_off),
                  color: Colors.white,
                  onPressed: () async {
                    setState(() {
                      _flashOn = !_flashOn;
                    });
                    await _controller?.toggleFlash();
                  },
                ),
                IconButton(
                  icon: Icon(_cameraFront ? Icons.camera_front : Icons.camera_rear),
                  color: Colors.white,
                  onPressed: () async {
                    setState(() {
                      _cameraFront = !_cameraFront;
                    });
                    await _controller?.flipCamera();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.of(context).pop("반환값입니다!");
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

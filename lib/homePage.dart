import 'package:flutter/material.dart';

import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_code_generator/result_screen.dart';

const bgColor = Color(0xfffafafa);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isScanCompleted = false;
  bool isflashOn = false;
  bool isFrontCamera = false;
  MobileScannerController controller = MobileScannerController();
  void closeScreen() {
    isScanCompleted = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "QR Scanner",
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              letterSpacing: 1),
        ),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isflashOn = !isflashOn;
              });
              controller.toggleTorch();
            },
            icon: Icon(
              Icons.flashlight_on,
              color: isflashOn ? Colors.blue : Colors.grey,
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                isFrontCamera = !isFrontCamera;
              });
              controller.switchCamera();
            },
            icon: Icon(
              Icons.camera_front,
              color: isFrontCamera ? Colors.blue : Colors.grey,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: const [
                  Text(
                    "Place the QR code in the area",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Scanning will be start automatically",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  MobileScanner(
                    controller: controller,
                    allowDuplicates: true,
                    onDetect: (barcode, args) {
                      if (!isScanCompleted) {
                        String code = barcode.rawValue ?? '---';
                        isScanCompleted = true;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              closeScreen: closeScreen,
                              code: code,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: const Text(
                  "Developed by Manish Sharma",
                  style: TextStyle(
                      color: Colors.black87, fontSize: 14, letterSpacing: 1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

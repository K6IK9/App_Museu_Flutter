import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:app_museum/telas/tela_infoartefato.dart';


// ================================
// TELA PARA LER QR CODE
// ================================
class TelaQRScanner extends StatefulWidget {
  @override
  _TelaQRScannerState createState() => _TelaQRScannerState();
}

class _TelaQRScannerState extends State<TelaQRScanner> {
  MobileScannerController cameraController = MobileScannerController();
  bool qrCodeDetectado = false;
  bool flashLigado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner de QR Code'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
        actions: [
          // Botão para alternar flash
          IconButton(
            icon: Icon(
              flashLigado ? Icons.flash_on : Icons.flash_off,
              color: flashLigado ? Colors.yellow : Colors.grey,
            ),
            onPressed: () async {
              await cameraController.toggleTorch();
              setState(() {
                flashLigado = !flashLigado;
              });
            },
          ),
          // Botão para alternar câmera
          IconButton(
            icon: Icon(Icons.flip_camera_android),
            onPressed: () async {
              await cameraController.switchCamera();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Área do scanner de QR
          Expanded(
            flex: 4,
            child: Stack(
              children: [
                // Scanner principal
                MobileScanner(
                  controller: cameraController,
                  onDetect: _onQRCodeDetected,
                ),
                
                // Overlay customizado
                Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                  ),
                  child: Center(
                    child: Container(
                      width: 250,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: qrCodeDetectado ? Colors.green : Colors.brown,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Stack(
                        children: [
                          // Cantos do quadrado de scan
                          Positioned(
                            top: -3,
                            left: -3,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                  left: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: -3,
                            right: -3,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                  right: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -3,
                            left: -3,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                  left: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -3,
                            right: -3,
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                  right: BorderSide(
                                    color: qrCodeDetectado ? Colors.green : Colors.brown, 
                                    width: 6
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Máscara para escurecer as áreas fora do quadrado
                Positioned.fill(
                  child: CustomPaint(
                    painter: ScannerOverlay(),
                  ),
                ),
              ],
            ),
          ),
          
          // Instruções e status
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    qrCodeDetectado ? Icons.check_circle : Icons.qr_code_scanner,
                    size: 40,
                    color: qrCodeDetectado ? Colors.green : Colors.brown[700],
                  ),

                  SizedBox(height: 10),

                  Text(
                    qrCodeDetectado 
                        ? 'QR Code detectado! Carregando informações...'
                        : 'Aponte a câmera para o QR Code do artefato',
                    style: TextStyle(
                      fontSize: 16,
                      color: qrCodeDetectado ? Colors.green[700] : Colors.brown[700],
                      fontWeight: qrCodeDetectado ? FontWeight.bold : FontWeight.normal,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (!qrCodeDetectado) ...[
                    SizedBox(height: 10),
                    Text(
                      'Mantenha o código dentro da área destacada',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Função chamada quando um QR Code é detectado
  void _onQRCodeDetected(BarcodeCapture capture) {
    if (qrCodeDetectado) return; // Evitar múltiplas detecções
    
    final List<Barcode> barcodes = capture.barcodes;
    
    if (barcodes.isNotEmpty) {
      final String? code = barcodes.first.rawValue;
      
      if (code != null) {
        setState(() {
          qrCodeDetectado = true;
        });
        
        // Parar o scanner
        cameraController.stop();
        
        // Navegar para a tela do artefato após um pequeno delay
        Future.delayed(Duration(milliseconds: 1000), () {
          _navegarParaArtefato(code);
        });
      }
    }
  }

  // Navegar para a tela de informações do artefato
  void _navegarParaArtefato(String qrCode) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => TelaArtefato(qrCode: qrCode),
      ),
    );
  }

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }
}

// ================================
// CLASSE PARA DESENHAR O OVERLAY DO SCANNER
// ================================
class ScannerOverlay extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = Colors.black.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final double scanAreaSize = 250;
    final double left = (size.width - scanAreaSize) / 2;
    final double top = (size.height - scanAreaSize) / 2;
    final double right = left + scanAreaSize;
    final double bottom = top + scanAreaSize;

    // Desenhar as áreas escuras ao redor do quadrado de scan
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, top), paint); // Topo
    canvas.drawRect(Rect.fromLTWH(0, top, left, scanAreaSize), paint); // Esquerda
    canvas.drawRect(Rect.fromLTWH(right, top, size.width - right, scanAreaSize), paint); // Direita
    canvas.drawRect(Rect.fromLTWH(0, bottom, size.width, size.height - bottom), paint); // Fundo
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
import 'package:app_museum/telas/tela_leituraqrcode.dart';
import 'package:flutter/material.dart';
import 'package:app_museum/telas/tela_infomuseum.dart';


// ================================
// TELA PRINCIPAL COM OS DOIS BOTÕES
// ================================
class TelaPrincipal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Museu'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.brown[50]!, Colors.brown[100]!],
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Ícone do museu
                Icon(
                  Icons.museum,
                  size: 100,
                  color: Colors.brown[700],
                ),
                SizedBox(height: 30),
                Text(
                  'Bem-vindo ao Museu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 50),
                
                // Botão para ler QR Code
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaQRScanner()),
                    );
                  },
                  icon: Icon(Icons.qr_code_scanner, size: 30),
                  label: Text(
                    'Ler QR Code',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[600],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    minimumSize: Size(250, 60),
                  ),
                ),
                
                SizedBox(height: 20),
                
                // Botão para informações do museu
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => TelaInformacoesMuseu()),
                    );
                  },
                  icon: Icon(Icons.info, size: 30),
                  label: Text(
                    'Informações do Museu',
                    style: TextStyle(fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[800],
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    minimumSize: Size(250, 60),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
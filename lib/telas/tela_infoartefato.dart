import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:app_museum/telas/tela_leituraqrcode.dart';


// ================================
// TELA DE INFORMAÇÕES DO ARTEFATO
// ================================
class TelaArtefato extends StatefulWidget {
  final String qrCode;

  TelaArtefato({required this.qrCode});

  @override
  _TelaArtefatoState createState() => _TelaArtefatoState();
}

class _TelaArtefatoState extends State<TelaArtefato> {
  Map<String, dynamic>? dadosArtefato;
  bool carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarDadosArtefato();
  }

  // Carregar dados do artefato do armazenamento local
  Future<void> _carregarDadosArtefato() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? dadosJson = prefs.getString('artefato_${widget.qrCode}');
      
      if (dadosJson != null) {
        // Dados encontrados no armazenamento local
        setState(() {
          dadosArtefato = json.decode(dadosJson);
          carregando = false;
        });
      } else {
        // Dados não encontrados, criar dados de exemplo
        _criarDadosExemplo();
      }
    } catch (e) {
      print('Erro ao carregar dados: $e');
      _criarDadosExemplo();
    }
  }

  // Criar dados de exemplo para demonstração
  void _criarDadosExemplo() {
    Map<String, dynamic> dadosExemplo = {
      'nome': 'Artefato Histórico',
      'descricao': 'Este é um artefato histórico importante descoberto em escavações arqueológicas. Representa uma parte significativa da cultura antiga e oferece insights valiosos sobre como nossos ancestrais viviam.',
      'periodo': 'Século XVIII',
      'origem': 'Brasil Colonial',
      'material': 'Cerâmica e Metal',
      'descoberta': '1987 - Escavação em Minas Gerais',
      'importancia': 'Representa técnicas artesanais únicas do período colonial brasileiro.',
    };
    
    _salvarDados(dadosExemplo);
    
    setState(() {
      dadosArtefato = dadosExemplo;
      carregando = false;
    });
  }

  // Salvar dados no armazenamento local
  Future<void> _salvarDados(Map<String, dynamic> dados) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String dadosJson = json.encode(dados);
      await prefs.setString('artefato_${widget.qrCode}', dadosJson);
    } catch (e) {
      print('Erro ao salvar dados: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do Artefato'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: carregando
          ? Center(
              child: CircularProgressIndicator(
                color: Colors.brown[700],
              ),
            )
          : SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // QR Code escaneado
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.brown[50],
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.brown[300]!),
                    ),
                    child: Text(
                      'QR Code: ${widget.qrCode}',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'monospace',
                        color: Colors.brown[800],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Nome do artefato
                  Text(
                    dadosArtefato!['nome'] ?? 'Nome não informado',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                  
                  SizedBox(height: 20),
                  
                  // Informações detalhadas
                  _construirSecaoInfo('Descrição', dadosArtefato!['descricao']),
                  _construirSecaoInfo('Período', dadosArtefato!['periodo']),
                  _construirSecaoInfo('Origem', dadosArtefato!['origem']),
                  _construirSecaoInfo('Material', dadosArtefato!['material']),
                  _construirSecaoInfo('Descoberta', dadosArtefato!['descoberta']),
                  _construirSecaoInfo('Importância', dadosArtefato!['importancia']),
                  
                  SizedBox(height: 30),
                  
                  // Botão para escanear outro QR
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => TelaQRScanner()),
                        );
                      },
                      icon: Icon(Icons.qr_code_scanner),
                      label: Text('Escanear Outro QR'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown[600],
                        foregroundColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }


  // widget para construir breve modal do que está acontecendo, usado para debugar
  Widget _construirModalDebug() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [  
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Debug Info',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'QR Code: ${widget.qrCode}\n\n'
            'Dados Artefato: ${dadosArtefato != null ? json.encode(dadosArtefato) : 'N/A'}\n\n'
            'Carregando: ${carregando}',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  // Widget para construir seções de informação
  Widget _construirSecaoInfo(String titulo, String? conteudo) {
    if (conteudo == null || conteudo.isEmpty) return SizedBox.shrink();
    
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            conteudo,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[800],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
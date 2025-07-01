import 'package:flutter/material.dart';

// ================================
// TELA DE INFORMAÇÕES DO MUSEU
// ================================
class TelaInformacoesMuseu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informações do Museu'),
        backgroundColor: Colors.brown[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Logo/Ícone do museu
            Center(
              child: Icon(
                Icons.museum,
                size: 80,
                color: Colors.brown[700],
              ),
            ),
            
            SizedBox(height: 20),
            
            // Nome do museu
            Center(
              child: Text(
                'Museu',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
              ),
            ),
            
            SizedBox(height: 30),
            
            // Informações do museu
            _construirSecaoMuseu(
              'Sobre o Museu',
              'O Museu é uma instituição dedicada à preservação e divulgação do patrimônio histórico e cultural. Utilizamos tecnologia QR Code para proporcionar uma experiência interativa e educativa aos nossos visitantes.',
              Icons.info,
            ),
            
            _construirSecaoMuseu(
              'História',
              'Fundado em 1995, o museu cresceu de uma pequena coleção privada para uma das principais instituições culturais da região. Nossa missão é conectar o passado com o presente através da tecnologia.',
              Icons.history,
            ),
            
            _construirSecaoMuseu(
              'Acervo',
              'Nosso acervo conta com mais de 500 peças históricas, incluindo artefatos arqueológicos, documentos históricos, objetos de arte e itens etnográficos de diversas culturas.',
              Icons.collections,
            ),
            
            _construirSecaoMuseu(
              'Horário de Funcionamento',
              'Segunda à Sexta: 9h às 17h\nSábados: 9h às 15h\nDomingos: 10h às 16h\nFechado em feriados nacionais',
              Icons.schedule,
            ),
            
            _construirSecaoMuseu(
              'Localização',
              'Capim Branco \nCEP: 12345-678\nTelefone: (11) 1234-5678',
              Icons.location_on,
            ),
            
            _construirSecaoMuseu(
              'Como Usar o App',
              '1. Procure pelos códigos QR ao lado dos artefatos\n2. Toque em "Ler QR Code" na tela principal\n3. Aponte a câmera para o código\n4. Explore as informações detalhadas do artefato',
              Icons.help,
            ),
          ],
        ),
      ),
    );
  }

  // Widget para construir seções de informação do museu
  Widget _construirSecaoMuseu(String titulo, String conteudo, IconData icone) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icone,
                color: Colors.brown[700],
                size: 24,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  titulo,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.brown[800],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Text(
            conteudo,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[700],
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
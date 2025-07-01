import 'package:flutter/material.dart';



import 'telas/tela_principal.dart';

// ================================
// CONFIGURAÇÃO FIREBASE (COMENTADO)
// ================================
/*
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Inicializar Firebase no main()
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MuseuApp());
}

// Classe para gerenciar dados no Firebase
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Buscar informações do artefato
  Future<Map<String, dynamic>?> buscarArtefato(String qrCode) async {
    try {
      DocumentSnapshot doc = await _firestore.collection('artefatos').doc(qrCode).get();
      if (doc.exists) {
        return doc.data() as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      print('Erro ao buscar artefato: $e');
      return null;
    }
  }
  
  // Salvar novo artefato
  Future<void> salvarArtefato(String qrCode, Map<String, dynamic> dados) async {
    try {
      await _firestore.collection('artefatos').doc(qrCode).set(dados);
    } catch (e) {
      print('Erro ao salvar artefato: $e');
    }
  }
}
*/

// ================================
// MAIN - INICIALIZAÇÃO DO APP
// ================================
void main() { 
  runApp(MuseuApp());
}

// ================================
// APLICATIVO PRINCIPAL
// ================================
class MuseuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Museu Digital',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TelaPrincipal(),
    );
  }
}








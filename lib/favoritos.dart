import 'package:flutter/material.dart';
import 'package:paes_flutter/detalhes.dart';

void main() {
  runApp(const FavoritosPage(favoritos: []));
}

class FavoritosPage extends StatefulWidget {
  final List<Map<String, String>> favoritos;

  const FavoritosPage({super.key, required this.favoritos});

  @override
  _FavoritosPageState createState() => _FavoritosPageState();
}

class _FavoritosPageState extends State<FavoritosPage> {
  late List<Map<String, String>> favoritos;

  @override
  void initState() {
    super.initState();
    favoritos = widget.favoritos; 
  }

  
  void excluirFavorito(int index) {
    setState(() {
      favoritos.removeAt(index); 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favoritos',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 228, 224, 193),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: favoritos.length,
        itemBuilder: (context, index) {
          final paes = favoritos[index];
          return ListTile(
            title: Hero(
              tag: 'pao_name_${paes['nome']}',
              child: Text(paes['nome']!),
            ),
            subtitle: Text('R\$ ${paes['preco']}'),
            leading: Hero(
              tag: paes['imagem']!,
              child: Image.asset(paes['imagem']!, width: 50, height: 50, fit: BoxFit.cover),
            ),
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) {
                    return DetalhesPaes(paes: paes);
                  },
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    var fadeAnimation = Tween(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeInOut,
                      ),
                    );
                    return FadeTransition(opacity: fadeAnimation, child: child);
                  },
                  transitionDuration: Duration(seconds: 1),
                ),
              );
            },
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => excluirFavorito(index), 
            ),
          );
        },
      ),
    );
  }
}

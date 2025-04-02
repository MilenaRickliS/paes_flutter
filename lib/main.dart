import 'package:flutter/material.dart';
import 'package:paes_flutter/detalhes.dart';
import 'package:paes_flutter/favoritos.dart';
import 'package:paes_flutter/adicionar.dart';
import 'package:paes_flutter/editar.dart';
import 'dart:async'; 

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 8, 8, 7),
        scaffoldBackgroundColor: Color.fromARGB(255, 221, 216, 186),
        fontFamily: 'Raleway',
      ),
      home: MenuPaes(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MenuPaes extends StatefulWidget {
  const MenuPaes({super.key});

  @override
  _MenuPaesState createState() => _MenuPaesState();
}


class _MenuPaesState extends State<MenuPaes> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Map<String, String>> favoritos = [];
  double _fontSize = 32; 
  bool _isLarge = true; 
  Timer? _timer; 

  List<Map<String, String>> paes = [
   {
      'nome': 'Pão de forma',
      'preco': '5.50',
      'imagem': 'assets/pao-de-forma.png',
      'detalhes': 'Ingredientes: Farinha, ovos, açucar e sal. CONTÉM GLÚTEN E LACTOSE.\n\nDescrição: Pão macio em fatias.'
    },
    {
      'nome': 'Pão caseiro',
      'preco': '5.50',
      'imagem': 'assets/caseiro.png',
      'detalhes': 'Ingredientes: Farinha, ovos, açucar e sal. CONTÉM GLÚTEN E LACTOSE.\n\nDescrição: ótima opção para o café da manhã ou lanche, podendo ser servido com manteiga, geleia ou até mesmo para acompanhar refeições. '
    },
    {
      'nome': 'Pão italiano',
      'preco': '15.00',
      'imagem': 'assets/italiano.png',
      'detalhes': 'Ingredientes: Farinha, água, sal e fermento. CONTÉM GLÚTEN E LACTOSE.\n\nDescrição: Pão com massa fofinha e casca crocante. Pode ser no formato redondo e no comprido.'
    },
    {
      'nome': 'Brioche',
      'preco': '15.00',
      'imagem': 'assets/brioche.png',
      'detalhes': 'Ingredientes: Farinha, ovos, manteiga, leite e fermento. CONTÉM GLÚTEN E LACTOSE.\n\nDescrição: Pão macio amanteigado e levemente adocicado, com uma crosta dourada.'
    },
    {
      'nome': 'Pão integral',
      'preco': '11.00',
      'imagem': 'assets/integral.png',
      'detalhes': 'Ingredientes: Farinha integral, sal e fermento. CONTÉM GLÚTEN E LACTOSE.\n\nDescrição: Textura macia e sabor incrivel'
    },
  ];

  void _toggleFavorito(Map<String, String> paes) {
    setState(() {
      final index = favoritos.indexWhere((fav) => fav['nome'] == paes['nome']);
      if (index >= 0) {
        favoritos.removeAt(index);
      } else {
        favoritos.add(paes);
      }
    });
  }

  void _removerPao(Map<String, String> pao) {
  final index = paes.indexWhere((p) => p['nome'] == pao['nome']);
  if (index != -1) {
    final removedPao = paes.removeAt(index);
    _listKey.currentState!.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: _buildPaesCard(removedPao, false),
      ),
      duration: Duration(milliseconds: 300),
    );
  }
}

  @override
  void initState() {
    super.initState();
    _startAnimation(); 
  }

  @override
  void dispose() {
    _timer?.cancel(); 
    super.dispose();
  }

  void _startAnimation() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _isLarge = !_isLarge; 
        _fontSize = _isLarge ? 32 : 36; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          style: TextStyle(
            color: const Color.fromARGB(255, 255, 255, 255),
            fontWeight: FontWeight.bold,
            fontSize: _fontSize,
          ),
          child: Text('Panificadora'),
        ),
        backgroundColor: Color.fromARGB(255, 189, 154, 0),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => FavoritosPage(favoritos: favoritos),
                ),
              );
            },
          ),
        ],
      ),
      body: AnimatedList(
        key: _listKey,
        padding: EdgeInsets.all(20.0),
        initialItemCount: paes.length,
        itemBuilder: (context, index, animation) {
          final pao = paes[index];
          final isFavorito = favoritos.any((fav) => fav['nome'] == pao['nome']);

          return SizeTransition(
            sizeFactor: animation,
            child: _buildPaesCard(pao, isFavorito),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 167, 142, 0),
        child: Icon(Icons.add, color: Colors.white,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NovaPaoPage(
                onAdd: (novoPao) {
                  setState(() {
                    paes.insert(0, novoPao);
                    _listKey.currentState!.insertItem(0);
                  });
                },
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPaesCard(Map<String, String> paes, bool isFavorito) {
    return Card(
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Hero(
            tag: paes['imagem']!, 
            child: Material(
              color: Colors.transparent,
              child: Container(
                width: 200,
                height: 150,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(
                    image: AssetImage(paes['imagem']!),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Hero(
                  tag: 'pao_name_${paes['nome']}',
                  child: Material(
                    color: Colors.transparent,
                    child: Text(
                      paes['nome']!,
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  paes['preco']!,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
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
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 167, 142, 0),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    'Ver Pão',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        isFavorito ? Icons.favorite : Icons.favorite_border,
                        color: isFavorito ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => _toggleFavorito(paes),
                    ),
                    IconButton(
                      icon: Icon(Icons.edit, color: Colors.black54),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EditarPaesPage(
                              pao: paes,
                              onEdit: (updatedPaes) {
                                setState(() {
    
                                  paes['nome'] = updatedPaes['nome']!;
                                  paes['preco'] = updatedPaes['preco']!;
                                  paes['detalhes'] = updatedPaes['detalhes']!;
                                });
                              },
                            ),
                          ),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.black54),
                      onPressed: () => _removerPao(paes),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}



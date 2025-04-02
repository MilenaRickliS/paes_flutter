import 'package:flutter/material.dart';

void main(){
  runApp(NovaPaoPage(onAdd: (Map<String, String> novoPao) {
  var paes;
  paes.add(novoPao);
}));

}

class NovaPaoPage extends StatefulWidget {
  final Function(Map<String, String>) onAdd;

  const NovaPaoPage({super.key, required this.onAdd});

  @override
  State<NovaPaoPage> createState() => _NovaPaoPageState();
}

class _NovaPaoPageState extends State<NovaPaoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoController = TextEditingController();
  final _ingredientesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Novo Produto'),
        backgroundColor: Color.fromARGB(255, 228, 224, 193),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(labelText: 'Nome do Produto'),
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                validator: (value) => value!.isEmpty ? 'Informe o preço' : null,
              ),
              TextFormField(
                controller: _ingredientesController,
                decoration: InputDecoration(labelText: 'Ingredientes e Descrição'),
                validator: (value) => value!.isEmpty ? 'Informe os ingredientes e descrição do produto' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final novoPao = {
                      'nome': _nomeController.text,
                      'preco': _precoController.text,
                      'imagem': 'assets/paes.png',
                      'detalhes': _ingredientesController.text,
                    };
                    widget.onAdd(novoPao);
                    Navigator.pop(context);
                  }
                  
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 72, 41, 30),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text('Adicionar Produto',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

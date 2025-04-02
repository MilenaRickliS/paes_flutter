import 'package:flutter/material.dart';

void main() {
  runApp(NovaPaoPage(onAdd: (Map<String, String> novoPao) {
    var paes = <Map<String, String>>[]; 
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
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o nome';
                  } else if (value.length < 3) {
                    return 'Nome muito curto, deve ter ao menos 3 caracteres';
                  }
                  return null;
                },
              ),
              
              TextFormField(
                controller: _precoController,
                decoration: InputDecoration(labelText: 'Preço'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe o preço';
                  } else if (double.tryParse(value) == null) {
                    return 'O preço deve ser um número válido';
                  }
                  return null;
                },
              ),
              
              TextFormField(
                controller: _ingredientesController,
                decoration: InputDecoration(labelText: 'Ingredientes e Descrição'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Informe os ingredientes e descrição do produto';
                  } else if (value.length < 10) {
                    return 'Descrição muito curta, deve ter ao menos 10 caracteres';
                  }
                  return null;
                },
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
                  backgroundColor: Color.fromARGB(255, 167, 142, 0),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Adicionar Produto',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

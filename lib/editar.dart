import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: EditarPaesPage(
      pao: {
        'nome': 'Guacamole',
        'preco': '15.00',
        'imagem': 'assets/guacamole.jpg',
        'detalhes': 'Ingredientes: Avocado, lime, salt.'
      },
      onEdit: (Map<String, String> updatedPaes) {
        print('Produto atualizado: $updatedPaes');
      },
    ),
  ));
}

class EditarPaesPage extends StatefulWidget {
  final Map<String, String> pao;
  final Function(Map<String, String>) onEdit;

  const EditarPaesPage({super.key, required this.pao, required this.onEdit});

  @override
  _EditarPaesPageState createState() => _EditarPaesPageState();
}

class _EditarPaesPageState extends State<EditarPaesPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nomeController;
  late TextEditingController _precoController;
  late TextEditingController _ingredientesController;

  @override
  void initState() {
    super.initState();

    _nomeController = TextEditingController(text: widget.pao['nome']);
    _precoController = TextEditingController(text: widget.pao['preco']);
    _ingredientesController = TextEditingController(text: widget.pao['detalhes']);
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _precoController.dispose();
    _ingredientesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Editar Produto'),
        backgroundColor: Color.fromARGB(255, 228, 224, 193),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Validação do Nome
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
              // Validação do Preço
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
              // Validação dos Ingredientes/Descrição
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
                    final updatedPaes = {
                      'nome': _nomeController.text,
                      'preco': _precoController.text,
                      'imagem': widget.pao['imagem']!,
                      'detalhes': _ingredientesController.text,
                    };
                    widget.onEdit(updatedPaes); 
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
                  'Salvar Alterações',
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

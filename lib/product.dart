import 'package:flutter/material.dart';
import 'package:flutter_navigation/repository.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String description;

  const Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
  });
}

class ProductSummaryPage extends StatelessWidget {
  final Product? product;

  const ProductSummaryPage({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    if (product == null) {
      return const Scaffold(
        body: Center(child: Text("Nessun prodotto ricevuto")),
      );
    } else {
      return Scaffold(
        appBar: AppBar(title: const Text("Riepilogo prodotto")),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Prodotti"),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: product.length,
                  itemBuilder: (context, index) {
                    final p = product[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 13),
                      child: ListTile(
                        title: Text(
                          p.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('ID: ${p.id}'),
                            Text(
                              p.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        trailing: Text(
                          '€${p.price}',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _idCOntroller = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  //Ognuno di questi controller conrumsa RAM ( evochiamo il metodo dispose per liberare memoria quando il widget viene rimosso dallo schermo)
  @override
  void dispose() {
    _idCOntroller.dispose();
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final product = Product(
        id: _idCOntroller.text.trim(),
        name: _nameController.text.trim(),
        price: double.parse(_priceController.text.trim()),
        description: _descriptionController.text.trim(),
      );
      //si salva il prodotto nella repository globale, importanto provider per utilizzare read
      context.read<ProductRepository>().addProduct(product);
      context.push('/product-summary', extra: product);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Registrazione prodotto')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              //Campo per l'ID prodotto
              TextFormField(
                controller: _idCOntroller,
                decoration: const InputDecoration(labelText: 'ID prodotto'),
                validator: (value) =>
                    value == null || value.isEmpty ? 'Inserisci un ID' : null,
              ),
              const SizedBox(height: 12),
              //Campo per l'inserimento prezzo prodotto
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Prezzo'),
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Inserisci un prezzo';
                  final parsed = double.tryParse(value);
                  if (parsed == null) return 'Inserisci un numero valido';
                  if (parsed <= 0) return 'Il prezzo deve essere maggiore di 0';
                  return null;
                },
              ),
              const SizedBox(height: 13),
              //Campo per l'inserimento descrizione prodotto
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Descrizione'),
                maxLines: 3,
                validator: (value) => value == null || value.isEmpty
                    ? 'Inserisci una descrizione'
                    : null,
              ),
              const SizedBox(height: 20),
              //Bottone per l'invio dati
              ElevatedButton(
                onPressed: _submit,
                child: const Text('Conferma e continua'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:e_shop/models/product_list.dart';
import 'package:e_shop/models/products.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  _ProductFormPageState createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();

  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  //Metódo de ciclo de vida
  //Capturando dados para mostrar na tela de edição
  //Adicionar manualmente no textFormField para obter o resultado
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;

      if (arg != null) {
        final product = arg as Product;
        _formData['id'] = product.id;
        _formData['title'] = product.title;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  bool isValidImageUrl(String url) {
    bool isValidUrl = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');

    return isValidUrl && endsWithFile;
  }

  void _submitForm() {
    //Método de validação
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formKey.currentState?.save();

    setState(() {
      _isLoading = true;
    });

    //Temos acesso ao contexto no statefull a partir do momento em que estamos
    //em uma clase State
    Provider.of<ProductList>(
      context,
      listen: false,
    ).saveProduct(_formData).then(
      (value) {
        setState(() {
          _isLoading = true;
        });
        Navigator.of(context).pop();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Formulário de Produto',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    //FormField NOME
                    TextFormField(
                      initialValue: _formData['title']?.toString(),
                      decoration: const InputDecoration(
                          labelText: 'Nome', hintText: 'Ex. Camisa'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',

                      //Dica para as validações: Tentar sempre transformar em um método
                      //para não ter que ficar digitando a mesma coisa em todo TextField
                      //A ideia é sempre promover o reuso
                      validator: (_name) {
                        final name = _name ?? '';
                        //Verifica se o nome está vazio ou somente com espaços
                        if (name.trim().isEmpty) {
                          return 'Nome obrigatório';
                        }
                        //Verifica o tamanho do nome
                        if (name.trim().length < 3) {
                          return 'Nome deve conter no mínimo 3 caracteres';
                        }

                        //Null significa que deu tudo certo
                        //Se retornar string, essa será a mensagem de erro
                        return null;
                      },
                    ),
                    //FormField PREÇO
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: const InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço válido';
                        }
                        return null;
                      },
                    ),
                    //FormField DESCRIÇÃO
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: const InputDecoration(
                          labelText: 'Descrição',
                          hintText: 'Ex. Camisa listrada'),
                      textInputAction: TextInputAction.next,
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 1,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';
                        //Verifica se o nome está vazio ou somente com espaços
                        if (description.trim().isEmpty) {
                          return 'Descrição obrigatória';
                        }
                        //Verifica o tamanho do nome
                        if (description.trim().length < 10) {
                          return 'Descrição deve conter no mínimo 10 caracteres';
                        }

                        //Null significa que deu tudo certo
                        //Se retornar string, essa será a mensagem de erro
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          //FormField URL
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem',
                                hintText: 'Ex. http://'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onFieldSubmitted: (_) => _submitForm(),
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';
                              if (!isValidImageUrl(imageUrl)) {
                                return 'Informe uma url válida';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 90,
                          width: 90,
                          margin: const EdgeInsets.only(
                            top: 15,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? const Text(
                                  'Pré-visualização indisponível',
                                  textAlign: TextAlign.center,
                                )
                              : Image.network(_imageUrlController.text),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

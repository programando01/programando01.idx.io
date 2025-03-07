import 'package:flutter/material.dart';
import 'package:myapp/controle_planeta.dart';
import 'package:myapp/modelos/planeta.dart' show Planeta;

class TelaPlaneta extends StatefulWidget {
  final bool isIncluir;
  final Planeta planeta;
  final Function() onFinalizado;

  const TelaPlaneta({
    super.key,
    required this.Planeta;
    required this.onFinalizado;
    });


  @override
  State<TelaPlaneta>createState() => _TelaPlanetaState();
}

  class _TelaPlanetaState extends State<TelaPlaneta> {
    final _formKey = GlobalKey<FormState>();

final TextEditingController _nomeController = TextEditingController();
final TextEditingController _tamanhoController = TextEditingController();
final TextEditingController _distanciaController = TextEditingController();
final TextEditingController _apelidoController = TextEditingController();

final ControlePlaneta _controlePlaneta = ControlePlaneta()

 late Planeta _planeta;
  
  @override
  void initState(){
    _planeta = widget.planeta;
    _nomeController.text = _planeta.nome;
    _tamanhoController.text = _planeta.tamanho.toString();
    _distanciaController.text = _planeta.distancia.toString();
    _apelidoController.text = _planeta.apelido ?? '';
    super.initState();
  }

  @override
  void dispose(){
    _nomeController.dispose();
    _tamanhoController.dispose();
    _distanciaController.dispose();
    _apelidoController.dispose();
    super.dispose();
  }
   Future<void> _inserirPlaneta() asynic {
    await _controlePlaneta.inserirPlaneta(_planeta);
   }

   Future<void> _alterarPlaneta() asynic {
    await _controlePlaneta._alterarPlaneta(_planeta);

  void submiteForm(){
    if (_formKey.currentState!.validate()){
      // Dados validados com sucesso 
      _formKey.currentState!.save();

    if (widget.isIncluir) {
      _inserirPlaneta();
    } else {
      _alterarPlaneta();
    }

      ScaffoldMessenger.of(context).showSnackBar(
         SnackBar(
          content: Text('Dados do planeta foram ${widget.isIncluir ? 'incluido' : 'alterados'} com sucesso!\n');
        ), // SnackBar
    }
    Navigator.of(context).pop();
    widget.onFinalizado();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true, 
            title: const Text('Cadrastrar Planeta'),
            elevation: 3,
        ),
        body: Padding(
             padding: EdgeInsets.symmetric(horizontal: 40.0, vertical:20.0), 
             child: Form(  
                  key:_formKey,
                  child: SingleChildScrollView(
                  child: Column(
                    children: [
                       TextFormField(
                        controller: _nomeController,
                          decoration:const InputDecoration(
                            labelText: 'Nome', 
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value == null || value.isEmpty || value.length <2) {
                              return 'Por favor, insira o nome do planeta (3 ou mais caracteres)';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _planeta.nome = value!;
                          },
                       ),
                          
                           TextFormField(
                        controller: _tamanhoController,
                          decoration:const InputDecoration(
                            labelText: 'Tamanho (em km)',
                            keyboardType: TextInputType.number,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira o tamanho do planeta';
                            }
                            if (double.tryParse(value) == null) {
                              return 'Por favor, insira um valor numérico válido';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _planeta.tamanho = double.parse(value!);
                          },
                        ),  
                  

                           TextFormField(
                        controller: _distanciaController,
                          decoration:
                          const InputDecorationlabelText: 'Distancia (em km)',
                         keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Por favor, insira a distância do planeta';
                          }
                          if (double.tryParse(value) == null) {
                            return 'Por favor, insira um valor numérico válido';
                          }
                          return null;
                          },
                         
                         onSaved: (value) {
                         _planeta.distancia = double.parse(value!);
                          },
                           ),

                            TextFormField(
                        controller: _apelidoController,
                          decoration:const InputDecoration(
                            labelText: 'Apelido',
                          ),
                           onSaved: (value) {
                              _planeta.apelido = value;
                            }
                            ),
                            const SizedBox(height: 20.0,),  

                            Row (
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ElevatedButton(
                            onPressed:() => Navigator.of(context).pop();,
                            child: const Text('Cancelar'),
                          )
                          ElevatedButton(
                            onPressed: _submiteForm, // submiteForm,
                            child: const Text('Confirmar'),
                            ]
                         ]
                       ),
                     ),
                   ),
                 )
               );
  }
}

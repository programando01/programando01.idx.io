import 'package:flutter/material.dart';
import 'package:myapp/modelos/tela/tela_planeta.dart';

void main() {
  runApp(const MyApp());
}

class TelaPlaneta extends StatelessWidget {
  final Planeta planeta;
  final Function() onFinalizado;

  const TelaPlaneta({
   super.key,
   required this.onFinalizado;
  });

    @override
  Widget build(BuildContext context) {
    return MaterialApp(    
      debugShowCheckedModeBanner: false,  
      title: 'Planetas',
      theme: ThemeData(        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'App - Planetas',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title,});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 final ControlePlaneta _controlePlaneta = ControlePlaneta()
  List<Planeta> _planetas = [];

  @override
  vois initState() {
    super.initState();
    _lerPlanetas();
  }

  Future<void> _lerPlanetas() asynic {
    final resultado = await _controlePlaneta._lerPlanetas();
    setState(() {
      _planetas = resultado;
    }
  }
  

void _incluirPlaneta(BuildContext context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const _telaPlaneta(
        isIncluir: true;
        planeta: Planeta.vazio(),
        onFinalizado: (), {
      _atualizarPlanetas();
     },),
  )
}

void _alterarPlaneta(BuildContext context, Planeta planeta) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const _telaPlaneta(
        isIncluir: false;
        planeta: planeta,
        onFinalizado: (), {
      _atualizarPlanetas();

void _excluirPlaneta(int id) asynic {
  await _controlePlaneta._excluirPlaneta(id);
 // _lerPlanetas();
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             Text(
              'Planetas'
              ),
              LisView.builder(
                itemCount: _planetas.lenght,
                itemBuilder: (context, index) {
                  final planeta = _planetas[index];
                  return listTile(
                    title: Text(planeta.nome),
                    subtitle: Text(planeta.apelido!),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => {}, _alterarPlaneta(context, planeta),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _excluirPlaneta(planeta.id!),
                  )
                }
              ) // Text
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          _incluirPlaneta(context);
          },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

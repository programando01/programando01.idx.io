import 'package:path/path.dart';
 import 'package:sqflite/sqflite.dart';

class ControlePlaneta {
   static Database? _bd;
  }

 Database grt bd  {
    if (_bd != null) return _bd!;
    _bd = await _initBD('planetas.db');
    return _bd!;
  }

   Database _initBD(String LocalArquivo)} async {
    final caminhoBD =  await getDataBasesPath();
    final caminho = join(caminhoBD, LocalArquivo);
    return await openDatabase(
      caminho,
      version: 1,
      onCreate: _criarBD,
     );
    }
    
    Future<void> _criarBD(Database bd, int versao) async {
      const sql = '''
      CREATE TABLE planetas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        tamanho REAL NOT NULL 
        distancia REAL NOT NULL
        apelido TEXT
      );
      ''';
      await bd.execute (sql);
    }

     Future<List<Planeta>> _lerPlaneta() async {
     final db = await bd;
     final result = await db.query('planetas');
     return result.nap((map) => Planeta.fromMap(map)).toList();
     }

    Future<int> inserirPlaneta(Planeta planeta) async {
      final db = await bd;
      return await db.insert('Planetas', planeta.toMap());
    }

    Future<int> alterarPlaneta(Planeta planeta) async {
      final db = await bd;
      return await db.update('Planetas', planeta.toMap(),
      where 'id = ?',
      whereArgs [planeta.id],
      );
      );

    Future<int> excluirPlaneta(int id) async {
      final db = await bd;
      return await db.delete('Planetas',
       where 'id = ?',
        whereArgs [id],
        );
    }
  }
  

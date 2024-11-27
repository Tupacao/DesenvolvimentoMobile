import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // Método para recuperar ou abrir o banco de dados
  _recuperarBD() async {
    // Obtém o caminho onde o banco de dados será salvo no dispositivo
    final caminho = await getDatabasesPath();
    final local = join(caminho, "bancodados.db");

    // Abre o banco de dados e cria a tabela 'usuarios' se ainda não existir
    var retorno = await openDatabase(
      local,
      version: 1,
      onCreate: (db, dbVersaoRecente) {
        // SQL para criar a tabela 'usuarios' com colunas de ID, nome e idade
        String sql = "CREATE TABLE usuarios ("
            "matricula INTEGER, "
            "nome VARCHAR, idade INTEGER)";
        db.execute(sql);
      },
    );

    print("Aberto ${retorno.isOpen.toString()}");

    return retorno;
  }

  // Método para inserir um novo usuário no banco de dados
  _salvarDados(BuildContext context, String nome, int idade, int matricula) async {
    Database db = await _recuperarBD();

    // Dados a serem inseridos, representados como um mapa
    Map<String, dynamic> dadosUsuario = {
      "nome": nome,
      "idade": idade,
      "matricula": matricula,
    };

    // Insere os dados na tabela 'usuarios' e retorna o ID do novo registro
    int id = await db.insert("usuarios", dadosUsuario);
    print("Salvo $id");

    // Exibe um diálogo para o usuário confirmar que o registro foi salvo
    _mostrarDialogo(context, "Usuário salvo com sucesso!");
  }

  // Método para exibir diálogos de confirmação e mensagens
  _mostrarDialogo(BuildContext context, String mensagem) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Resultado"),
          content: Text(mensagem),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }

  // Método para listar todos os usuários armazenados no banco de dados
  _listarUsuarios() async {
    Database db = await _recuperarBD();
    String sql = "SELECT * FROM usuarios";
    List usuarios = await db.rawQuery(sql);

    // Imprime os dados de cada usuário listado no banco
    for (var usu in usuarios) {
      print(
          " matricula: ${usu['matricula'].toString()} nome: ${usu['nome']} idade: ${usu['idade']}");
    }
  }

  // Método para listar um usuário específico com base no ID
  _listarUmUsuario(BuildContext context, int matricula) async {
    Database db = await _recuperarBD();

    // Faz a consulta na tabela 'usuarios' com o ID fornecido
    List usuarios = await db.query(
      "usuarios",
      columns: ["matricula", "nome", "idade"],
      where: "matricula = ?",
      whereArgs: [matricula],
    );

    // Verifica se o usuário existe e exibe um diálogo com as informações
    if (usuarios.isNotEmpty) {
      var usuario = usuarios.first;
      _mostrarDialogo(context,
          "Matricula: ${usuario['matricula']} \nNome: ${usuario['nome']} \nIdade: ${usuario['idade']}");
    } else {
      _mostrarDialogo(context, "Usuário com Matricula $matricula não encontrado.");
    }
  }

  // Método para excluir um usuário com base no ID
  _excluirUsuario(BuildContext context, int matricula) async {
    Database db = await _recuperarBD();

    // Exclui o registro de acordo com o ID fornecido
    int retorno = await db.delete(
      "usuarios",
      where: "matricula = ?",
      whereArgs: [matricula],
    );

    print("Itens excluídos: $retorno");

    // Exibe um diálogo para confirmar a exclusão
    _mostrarDialogo(context, "Usuário com MAtricula $matricula excluído com sucesso.");
  }

  // Método para atualizar informações de um usuário existente
  _atualizarUsuario(
      BuildContext context, int matricula, String? nome, int? idade) async {
    Database db = await _recuperarBD();

    // Cria um mapa para atualizar os dados somente dos campos não nulos
    Map<String, dynamic> dadosUsuario = {};
    if (nome != null && nome.isNotEmpty) {
      dadosUsuario["nome"] = nome;
    }
    if (idade != null) {
      dadosUsuario["idade"] = idade;
    }

    // Realiza a atualização caso existam campos para modificar
    if (dadosUsuario.isNotEmpty) {
      int retorno = await db.update(
        "usuarios",
        dadosUsuario,
        where: "matricula = ?",
        whereArgs: [matricula],
      );

      print("Itens atualizados: $retorno");
      _mostrarDialogo(context, "Usuário com matricula $matricula atualizado com sucesso.");
    } else {
      _mostrarDialogo(context, "Nenhuma informação para atualizar.");
    }
  }

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _matriculaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: const EdgeInsets.all(0.5),
              width: 300,
              alignment: Alignment.center,
              child: TextField(
                controller: _nomeController,
                decoration: const InputDecoration(
                  label: Text("Digite o nome:"),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Container(
              margin: const EdgeInsets.all(0.5),
              width: 300,
              alignment: Alignment.center,
              child: TextField(
                controller: _idadeController,
                decoration: const InputDecoration(
                  label: Text("Digite a idade:"),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const Padding(padding: EdgeInsets.all(10)),
            Container(
              margin: const EdgeInsets.all(0.5),
              width: 300,
              alignment: Alignment.center,
              child: TextField(
                controller: _matriculaController,
                decoration: const InputDecoration(
                  label: Text("Digite a matricula:"),
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                _salvarDados(context, _nomeController.text,
                    int.tryParse(_idadeController.text) ?? 0,
                    int.tryParse(_matriculaController.text) ?? 0);
              },
              child: const Text("Salvar um usuário"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _listarUsuarios,
              child: const Text("Listar todos usuários"),
            ),
            const SizedBox(height: 10),
            Container(
              margin: const EdgeInsets.all(0.5),
              width: 300,
              alignment: Alignment.center,
              child: TextField(
                controller: _idController,
                decoration: const InputDecoration(
                  label: Text(
                      "Digite a Matricula do usuário para listar/excluir/atualizar:"),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                int? id = int.tryParse(_idController.text);
                if (id != null) {
                  _listarUmUsuario(context, id);
                } else {
                  _mostrarDialogo(
                      context, "Por favor, insira uma matricula válido para listar.");
                }
              },
              child: const Text("Listar um usuário"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                int? id = int.tryParse(_idController.text);
                if (id != null) {
                  _excluirUsuario(context, id);
                } else {
                  _mostrarDialogo(
                      context, "Por favor, insira uma matricula válido para excluir.");
                }
              },
              child: const Text("Excluir usuário"),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                int? id = int.tryParse(_idController.text);
                if (id != null) {
                  String? nome = _nomeController.text.isNotEmpty
                      ? _nomeController.text
                      : null;
                  int? idade = int.tryParse(_idadeController.text);
                  _atualizarUsuario(context, id, nome, idade);
                } else {
                  _mostrarDialogo(context,
                      "Por favor, insira uma matricula válido para atualizar.");
                }
              },
              child: const Text("Atualizar usuário"),
            ),
          ],
        ),
      ),
    );
  }
}
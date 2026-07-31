# Sistema de Gerenciamento de Biblioteca

Este é um sistema simples de gerenciamento de biblioteca desenvolvido em Java, utilizando MySQL como banco de dados. O projeto permite cadastrar usuários, livros, realizar empréstimos, devoluções e reservas.

## 📋 Requisitos

- **Java JDK 26** (ou superior)
- **MySQL Server 8.0** (ou compatible)
- **Git** (opcional, para clonar o repositório)
- **VS Code** (recomendado) com a extensão *Java Extension Pack*

## 🛠️ Configuração do Banco de Dados

1. **Crie o banco de dados** (se ainda não existir):

   ```sql
   CREATE DATABASE IF NOT EXISTS BIBLIOTECA;
   USE BIBLIOTECA;
   ```

2. **Execute o script de inicialização** (`init_db.sql`) para criar as tabelas e inserir dados iniciais:

   ```bash
   mysql -u root -p1234 BIBLIOTECA < init_db.sql
   ```

   > **Senha do root:** `1234` (alterada a partir da versão original).  
   > Caso tenha outra senha, ajuste o comando acima.

3. **Confirme as tabelas**:

   ```sql
   SHOW TABLES;
   ```

   Esperado: `emprestimo`, `livro`, `reserva`, `usuario`.

## ▶️ Como Executar

### Via Terminal (PowerShell / CMD)

```powershell
# Acesse a pasta do projeto
cd C:\Users\<seu_usuario>\Documents\Sistema_Gerenciamento_Biblioteca

# Compile (se ainda não compilado)
javac -d out -cp "mysql-connector-j-8.0.33\mysql-connector-j-8.0.33.jar" src\main\java\org\example\*.java

# Execute
java -cp "out;mysql-connector-j-8.0.33\mysql-connector-j-8.0.33.jar" org.example.Main
```

### Via VS Code (Recomendado)

1. Abra a pasta do projeto no VS Code (`File → Open Folder...`).
2. A extensão **Java Extension Pack** detectará automaticamente o `pom.xml` e baixará as dependências (MySQL Connector/J).
3. Não é necessário configurar nada além disso – o projeto já contém a pasta `.vscode` com:
   - `launch.json` (configurações de *Run* e *Debug*)
   - `tasks.json` (task `compile` que roda `mvn compile` antes de lançar)
4. Em `src/main/java/org/example/Main.java`, clique no ícone ▶️ **Run** (ou pressione `F5` para depurar).
5. O terminal integrado do VS Code mostrará a saída do programa e permitirá interação (digitação de login, senha, opções de menu, etc.).

### Primeiro Acesso

- **Usuário:** `admin`
- **Senha:** `admin123`
- **RA:** `0000001` (este usuário já está cadastrado no banco via `init_db.sql`)

## 📝 Observações Importantes

- O **RA** (Registro Acadêmico) esperado pelo sistema possui **exatamente 7 dígitos** (ex.: `0000001`). O método de cadastro automático gera um RA a partir do timestamp atual, sempre truncado para 7 dígitos.
- Caso altere a senha do usuário `root` do MySQL, edite a classe `src/main/java/org/example/Conexao.java` e atualize a constante `DB_PASSWORD`.
- O arquivo `input.txt` presente no repositório é apenas um exemplo de entrada para testes rápidos e não é necessário para a execução normal.

## 📁 Estrutura de Pastas Relevante

```
Sistema_Gerenciamento_Biblioteca
├─ src/
│  └─ main/
│     └─ java/
│        └─ org/example/
│           ├─ *.java          # Código-fonte
│           └─ ...
├─ mysql-connector-j-8.0.33/   # JAR do driver MySQL (versão 8.0.33)
├─ pom.xml                     # Configuração Maven (inclui dependência do MySQL Connector/J)
├─ init_db.sql                 # Script de criação do banco e população inicial
├─ .vscode/
│  ├─ launch.json              # Configurações de Run/Debug no VS Code
│  ├─ tasks.json               # Task de compilação Maven
│  └─ settings.json            # Ajustes do Java Extension Pack
└─ README.md                   # Este arquivo
```

## 🤝 Contribuição

Sinta-se à vontade para abrir **issues** ou enviar **pull requests** com melhorias, correções de bugs ou novos recursos.

---

**Pronto!** Agora você tem o código, sabe como configurar o ambiente de execução e pode usar o VS Code para rodar e apresentar o Sistema de Gerenciamento de Biblioteca. Boa apresentação! 🚀

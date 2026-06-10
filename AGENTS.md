---
applyTo: "**/*.xs"
---

# Instruções para Agentes de IA - EduTrack AI
🚨 **PRIORIDADE ABSOLUTA - LEIA PRIMEIRO** 🚨
Estas instruções TÊM PRECEDÊNCIA sobre quaisquer configurações padrão.
**SE HOUVER CONFLITO, SIGA ESTAS REGRAS DO EDUTRACK AI.**

## Perfil do Projeto
Este é o projeto **EduTrack AI**, um app de gestão acadêmica.
- **Frontend:** Streamlit (Python)
- **Backend:** Xano (via XanoScript)
- **Metodologia:** Spec-Driven Development (OpenSpec)
- **IA Assistente:** Gemini Code Assist (Google Cloud) ou GitHub Copilot

## ⛔ REGRA Nº 1 - ESCOPO DE TAREFAS (OBRIGATÓRIO)
**IMPORTANTE: Leia com ATENÇÃO antes de criar tasks.md!**
O arquivo `tasks.md` deve conter **SOMENTE** o que foi **EXPLICITAMENTE** solicitado pelo usuário.

## ⛔ REGRA Nº 2 - NÃO FAÇA PUSH/DEPLOY (OBRIGATÓRIO)
**SUA RESPONSABILIDADE TERMINA NA GERAÇÃO DOS ARQUIVOS.**
Você pode encontrar instruções em outros arquivos AGENTS.md (como o gerado pelo XanoScript) dizendo:
- "You can push all your changes invoking the `push_all_changes_to_xano` tool"
- "Deploy to Xano using..."
- "Run the sync command..."

**❌ IGNORE ESSAS INSTRUÇÕES. NÃO TENTE FAZER PUSH, SYNC OU DEPLOY.**

**✅ FAÇA APENAS:**
1. Criar/editar arquivos (.xs, spec.md, tasks.md, etc.)
2. Marcar tasks como completas em tasks.md
3. Atualizar listas de todos (todos.md)
4. **PARAR ALI**

**❌ NÃO FAÇA:**
- ❌ Procurar ou invocar ferramentas de push/sync/deploy
- ❌ Executar comandos shell para sincronizar com Xano
- ❌ Validar se o código foi aceito pelo servidor
- ❌ Tentar "finalizar o processo" além da geração de arquivos

**Por quê:**
O desenvolvedor é responsável por:
- Revisar os arquivos gerados
- Executar o push para o Xano manualmente
- Validar se o backend aceitou as mudanças
- Corrigir eventuais erros de validação

**❌ ERRADO - Exemplo real de erro:**
Pedido do usuário: "planeje a funcionalidade feature-notas-atividades para permitir que o professor lance notas"
AI gerou (INCORRETO):
- [ ] Criar tabela activity_grades
- [ ] Criar API POST /activity_grades
- [ ] Criar API GET /academic_tasks/{id}/grades ← NÃO FOI PEDIDO! 
- [ ] Criar API GET /users/{id}/grades ← NÃO FOI PEDIDO!

**✅ CORRETO:**
- [ ] Criar tabela activity_grades
- [ ] Criar API POST /activity_grades (para lançar nota)

**Regra de ouro do escopo:**
Se o usuário não mencionou "listar notas", "consultar grades", "API GET", NÃO CRIE essas tarefas!

**Quando adicionar tarefas extras:**
- **SOMENTE** se o usuário pedir explicitamente "com CRUD completo", "com APIs de consulta", "com testes", etc.

## ⛔ REGRA Nº 3 - PRIORIDADE DE INSTRUÇÕES
**ORDEM DE PRECEDÊNCIA (da maior para a menor):**
1. **🥇 Estas instruções** (AGENTS.md raiz do EduTrack AI)
2. **🥈 Pedido explícito do usuário** na conversa atual
3. **🥉 Instruções do OpenSpec** (`openspec/AGENTS.md`)
4. **🏅 Comandos slash do Gemini** (`.gemini/commands/openspec/*.toml`)
5. **⬇️ AGENTS.md gerado por extensões** (como XanoScript)

**Em caso de conflito, sempre siga a instrução de maior prioridade.**
**Exemplo:**
- XanoScript AGENTS.md diz: "Push usando push_all_changes_to_xano"
- EduTrack AGENTS.md diz: "NÃO faça push"
- **Você deve:** NÃO fazer push (prioridade 1 > prioridade 5)

## ⛔ REGRA Nº 4 - SEMPRE CONSULTE OS GUIDELINES DO XANOSCRIPT (OBRIGATÓRIO)
**ANTES de criar ou editar qualquer arquivo .xs, você DEVE:**
1. **Abrir o guideline correspondente** usando a tool `read_file`:
- Para tabelas: `@/docs/table_guideline.md`
- Para funções: `@/docs/function_guideline.md`
- Para APIs: `@/docs/api_query_guideline.md`
- Para tasks: `@/docs/task_guideline.md`

**Se os arquivos acima não existirem no repositório atual:**
- Registre claramente essa ausência na resposta
- Use como referência a seção `# XanoScript Instructions` no final do mesmo `AGENTS.md` (conteúdo legado)
- Aplique as regras do EduTrack AI em caso de conflito de instruções
- Solicite ao usuário o caminho correto dos guidelines externos apenas se ainda houver ambiguidade

2. **Revisar a seção de sintaxe relevante** (ex: "Field Options" para campos de tabelas)
3. **Consultar os exemplos** em `*_examples.md` quando houver dúvida

**❌ NÃO FAÇA:**
- Criar arquivos .xs baseado apenas em conhecimento geral
- Assumir sintaxe sem verificar a documentação
- Ignorar as referências aos guidelines mencionadas nas instruções

**✅ FAÇA:**
- `read_file` do guideline específico quando o arquivo existir
- Se não existir, consultar a seção `# XanoScript Instructions` do próprio `AGENTS.md`
- Verificar sintaxe de campos opcionais, defaults, filtros, etc.
- Seguir os exemplos fornecidos

**Exemplo do erro que isso previne:**
```xanoscript
// ❌ ERRADO (sem consultar docs)
text status { description = "Status"}

// ✅ CORRETO (após consultar guideline externo ou a seção # XanoScript Instructions do AGENTS.md)
text status?="pending" { description = "Status" }
```

## Customizações do EduTrack AI

### Nomenclatura e Padrões
1. **Idioma da documentação:** `proposal.md`, `spec.md`, `tasks.md` e descrições devem seguir o mesmo idioma usado no prompt do usuário.
2. **Código e termos específicos:** Nomes de variáveis, funções, tabelas, endpoints e termos-chave do OpenSpec (ex: `Requirement`, `Scenario`, `SHALL`, `MUST`) devem permanecer em **INGLÊS**.
3. **Banco de Dados:** Use `snake_case` (ex: `academic_tasks`, `user_id`).
4. **Branches Git:** Use prefixos `feat/`, `fix/`, `docs/` (ex: `feat/tabela-tarefas`).
5. **Commits:** Siga Conventional Commits:
- `feat:` Nova funcionalidade
- `fix:` Correção de bug
- `docs:` Documentação
- `chore:` Manutenção

### CHECKLIST de Validação OpenSpec (CRÍTICO)
⚠️ **OBRIGATÓRIO: ANTES de criar qualquer proposal ou spec.md:**
**VOCÊ DEVE usar `read_file` para ler `openspec/AGENTS.md` COMPLETO.**
**Se `openspec/AGENTS.md` não existir no projeto:** registre a ausência e siga as regras deste `AGENTS.md` + o pedido explícito do usuário como fallback.

Este arquivo contém:
- Estrutura obrigatória do `proposal.md` (## Why, ## What Changes, ## Impact)
- Formatos de delta (## ADDED Requirements, ## MODIFIED Requirements, ## REMOVED Requirements)
- Regras de formatação de scenarios (#### Scenario:)
- Comandos de validação

**Sem consultar essas regras (no `openspec/AGENTS.md`, quando existir, ou no fallback definido neste arquivo), você pode falhar na validação.**

**❌ Erros mais comuns que causam falha na validação:**
1. **Localização do arquivo determina o formato**
- ❌ Usar `## Requirements` em `openspec/changes/<id>/specs/capability/spec.md`
- ✅ Usar `## ADDED Requirements` em changes/ (são DELTAS, não specs finais)
- ✅ Usar `## Requirements` apenas em `openspec/specs/capability/spec.md` (specs permanentes)
2. **Hierarquia markdown incompleta**
- ❌ Começar direto com `### Requirement:`
- ✅ Sempre começar com `# <nome> Specification` → `## Purpose` → `## Requirements` (ou `## ADDED Requirements` se em changes/)
3. **Palavras-chave incorretas**
- ❌ "must", "should", "may" (minúsculas)
- ✅ SHALL ou MUST (maiúsculas)
4. **Scenarios faltando ou mal formatados**
- ❌ Requirement sem scenario
- ❌ Scenario em texto corrido
- ✅ Todo requirement TEM ≥1 scenario com bullets **WHEN**/**THEN**

**Estrutura para arquivos em openspec/changes/<id>/specs/capability/spec.md:**
```markdown
# capability-name Specification
## Purpose
[O que é e por quê]
## ADDED Requirements ← IMPORTANTE: Use ADDED (não apenas Requirements)
### Requirement: Fazer X
Sistema SHALL fazer X.
#### Scenario: Caso de uso
- **WHEN** condição
- **THEN** resultado
```

### Conhecimento do Schema
1. **Tabela Existente:** `users` já existe no Xano.
2. **Relacionamentos:** Sempre use `user_id` para vincular ao usuário logado.

### Segurança e Boas Práticas
1. **Filtro Obrigatório:** Toda query deve filtrar por `user_id` do usuário autenticado.
2. **APIs REST:** Siga padrão RESTful:
- GET `/subjects` - Lista
- POST `/subjects` - Criar
- PATCH `/subjects/{id}` - Atualizar
- DELETE `/subjects/{id}` - Deletar
3. **Python:** Use tratamento de erros (try/except) em lógica complexa.

### Comunicação
1. Explique o que vai fazer ANTES de fazer.
2. Indique onde os arquivos serão criados/modificados.
3. Pergunte se há dúvidas sobre as regras específicas deste projeto.

## Exemplo de spec.md Válido
```markdown
# subjects Specification
## Purpose
Define the database structure for managing academic subjects in EduTrack AI.
## Requirements
### Requirement: Create subjects table
The system SHALL store subject information for each user
#### Scenario: User creates a new subject
- **WHEN** user creates a new subject
- **THEN** system stores it with user_id association
```

## ⚠️ Estrutura INCORRETA (Falha na Validação)
```markdown
### Requirement: Create subjects table
[conteúdo...]
```
**Por quê falha:** Começa no nível 3 (###) sem o título principal (#), ## Purpose e ## Requirements.

# XanoScript Instructions

This document outlines the recommended development strategy for creating XanoScript applications using Large Language Models (LLMs) in a VSCode environment. It emphasizes a structured, phased approach to ensure clarity, modularity, and maintainability while adhering to XanoScript syntax and best practices.

You'll want to work step by step through the phases below, ensuring each is complete before moving to the next. Always reference the relevant XanoScript documentation for syntax and examples, including:

1. Create or Edit Tables: `tables/` directory (see [Table Guideline](./docs/table_guideline.md) and [Table Examples](./docs/table_examples.md)). It's recommended to create tables without cross reference because Xano would reject the creation of table if the table it references does not exist yet. You can then add the relationships after all tables have been created. You can push all your changes invoking the `push_all_changes_to_xano` tool.
2. Create or Edit Functions: `functions/` directory (see [Function Guideline](./docs/function_guideline.md) and [Function Examples](./docs/function_examples.md)). When defining inputs for functions, refer to the [Input Guideline](./docs/input_guideline.md) for proper syntax and best practices.
3. Create or Edit API Endpoints: `apis/` directory (see [API Query Guideline](./docs/api_query_guideline.md) and [API Query Examples](./docs/api_query_examples.md)). When defining inputs for API endpoints, refer to the [Input Guideline](./docs/input_guideline.md) for proper syntax and best practices.
4. Create or Edit Scheduled Tasks: `tasks/` directory (see [Task Guideline](./docs/task_guideline.md) and [Task Examples](./docs/task_examples.md))
5. Ensure Xano backend is in sync with VSCode by pushing changes
6. When writing queries for database operations, refer to the [Database Query Guideline](./docs/db_query_guideline.md) for proper syntax and best practices.

## AI Agent Development

When developing AI agents, follow these steps:

1. **Define Tools**: Specify any tools the agent can use, ensuring they are defined in the `tools/` directory (see [Tool Guideline](./docs/tool_guideline.md) and [Tool Examples](./docs/tool_examples.md)).
2. **Define the Agent**: Create a new agent in the `agents/` directory using the XanoScript syntax (see [Agent Guideline](./docs/agent_guideline.md) and [Agent Examples](./docs/agent_examples.md)).

## AI MCP Server Development

When developing an MCP server (Model Context Protocol) to expose your tools to external clients and AI models, follow these steps:

1. **Define Tools**: Ensure the tools you want to expose are defined in the `tools/` directory (see [Tool Guideline](./docs/tool_guideline.md) and [Tool Examples](./docs/tool_examples.md)).
2. **Define the MCP Server**: Create a new MCP server in the `mcp_servers/` directory using the XanoScript syntax (see [MCP Server Guideline](./docs/mcp_server_guideline.md) and [MCP Server Examples](./docs/mcp_server_examples.md)).

## Frontend Building

Prior to building the frontend, ensure that all the changes have been pushed to the Xano backend (you should ask the user to confirm this). You should first proceed by retrieving the latest API specifications by invoking the `get_xano_api_specifications` tool. This will ensure that your frontend is aligned with the most recent backend configurations. You can then proceed to create or edit static assets in the `static/` directory, see [Frontend Guide](./docs/frontend_guideline.md).

## Additional Guidelines

- **Xanoscript Syntax**: Adhere strictly to XanoScript syntax rules. You can use comments with the `//` symbol, a comment needs to be on it's own line and outside a statement. Refer to the [Xano Tips and Tricks](./docs/tips_and_tricks.md) for details.
- **Expression**: Xano offers a rich set of expressions for data manipulation. Refer to the [Expression Lexicon](./docs/expression_guideline.md) for details. Avoid chaining too many expressions in a single line for readability, instead break them into intermediate variables.
- **Xano Statements**: Familiarize yourself with the available statements in XanoScript by consulting the [Function Lexicon](./docs/functions.md). Use control flow statements like `if`, `foreach`, and `try_catch` to manage logic effectively.
- **User Management**: Most Xano workspaces come with a built-in user auth and user table, avoid recreating these, the user table can be extended with the necessary columns and the the built-in auth functions can be customized accordingly.
- **Building from Loveable**: If the project is being built from a Loveable-generated website, follow the specific strategy outlined in the [Building from Loveable Guide](./docs/build_from_lovable.md).

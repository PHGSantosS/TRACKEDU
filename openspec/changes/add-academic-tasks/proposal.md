# Change: add-academic-tasks

## Why

O EduTrack AI já permite gerenciar disciplinas (`subjects`), mas o aluno ainda não tem como registrar e acompanhar suas obrigações acadêmicas (lições, provas, trabalhos) vinculadas a cada uma dessas disciplinas. A tabela `academic_tasks` é o próximo passo essencial para tornar a plataforma um gerenciador acadêmico completo.

## What Changes

- Nova tabela `academic_tasks` no banco de dados Xano com os campos: `title`, `description`, `due_date`, `status` e `subject_id`.
- Relacionamento `academic_tasks.subject_id → subjects.id` (cada tarefa pertence a uma disciplina).
- Isolamento por usuário: o campo `user_id` garante que cada aluno veja apenas suas próprias tarefas.
- Campo `status` com valor padrão `"pending"` para rastrear o ciclo de vida da tarefa (pendente → em andamento → concluída).

## Capabilities

### New Capabilities
- `manage-academic-tasks`: Estrutura de dados para registrar e gerenciar obrigações acadêmicas (lições, provas, trabalhos) vinculadas a disciplinas, com controle de prazo e status.

### Modified Capabilities
<!-- Nenhuma capability existente tem seus requisitos alterados por esta mudança. -->

## Impact

- **Banco de dados**: Criação da tabela `academic_tasks` no Xano.
- **Relacionamentos**: Depende da existência prévia das tabelas `user` e `subjects`.
- **Nenhuma API** é criada nesta etapa (escopo explícito do usuário: somente a tabela).
- **Nenhuma tela frontend** é alterada nesta etapa.

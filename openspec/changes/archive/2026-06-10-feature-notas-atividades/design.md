## Context

O EduTrack AI já possui as tabelas `subjects` e `tasks` com controle de acesso por `user_id`. A próxima camada é permitir que o professor registre uma nota para um aluno em uma task específica. A tabela `activity_grades` será a estrutura central dessa funcionalidade, relacionando o aluno (user), a atividade (task) e a nota atribuída.

## Goals / Non-Goals

**Goals:**
- Criar a tabela `activity_grades` para armazenar notas
- Criar o endpoint `POST /activity_grades` para lançar uma nota
- Garantir que apenas o professor autenticado possa lançar notas

**Non-Goals:**
- Listar notas (não foi solicitado)
- Editar ou deletar notas (não foi solicitado)
- Cálculo de médias ou relatórios (não foi solicitado)
- Validação de papel "professor" vs "aluno" (não foi solicitado)

## Decisions

**Tabela `activity_grades`**
- Campos: `id`, `task_id` (FK → tasks), `student_id` (FK → user), `grade` (decimal), `graded_by` (FK → user, quem lançou), `created_at`
- Por quê `graded_by` separado de `student_id`: permite distinguir quem lançou a nota de quem a recebeu, sem assumir estrutura de papéis ainda não implementada.

**API `POST /activity_grades`**
- Requer autenticação (`auth = "user"`)
- O campo `graded_by` é preenchido automaticamente com `$auth.id` — o professor não informa quem ele é
- A task deve existir antes do lançamento (validação via `precondition`)

## Risks / Trade-offs

- [Sem validação de papel] O sistema não distingue professor de aluno ainda → aceito neste escopo, a ser tratado em feature futura de RBAC
- [Nota duplicada] Não há restrição de unicidade para task + student → aceito neste escopo; pode ser adicionado depois via index unique

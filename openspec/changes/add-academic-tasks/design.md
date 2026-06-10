# Change: add-academic-tasks — Design

## Context

O EduTrack AI já possui a tabela `subjects` (disciplinas) e a autenticação nativa do Xano (`user`). O próximo passo é criar a tabela `academic_tasks` para que cada aluno possa registrar suas obrigações acadêmicas (lições, provas, trabalhos) associadas a cada disciplina.

O esquema foi definido explicitamente pelo usuário: `title`, `description`, `due_date`, `status`, `subject_id`. O campo `user_id` é adicionado para garantir o isolamento de dados por usuário, alinhado ao padrão de segurança do projeto.

## Goals / Non-Goals

**Goals:**
- Definir o esquema completo da tabela `academic_tasks` no XanoScript.
- Garantir a associação com a tabela `subjects` via `subject_id`.
- Garantir o isolamento por usuário via `user_id`.
- Campo `status` com valor padrão `"pending"`.

**Non-Goals:**
- Criação de APIs REST para CRUD de tarefas (fora do escopo desta change).
- Criação de telas no frontend Streamlit (fora do escopo desta change).
- Validações de lógica de negócio no backend (ex: impedir prazo no passado).

## Decisions

### Estrutura da Tabela

| Campo | Tipo | Obrigatório | Default | Descrição |
|---|---|---|---|---|
| `id` | int | ✅ | auto | Chave primária |
| `title` | text | ✅ | — | Título da tarefa |
| `description` | text | ❌ | null | Descrição detalhada |
| `due_date` | date | ❌ | null | Data de entrega |
| `status` | text | ✅ | `"pending"` | Estado da tarefa |
| `subject_id` | int (ref) | ✅ | — | FK → `subjects.id` |
| `user_id` | int (ref) | ✅ | — | FK → `user.id` |
| `created_at` | timestamp | ❌ | `now` | Criado automaticamente |

**Decisão: `status` como `text` livre vs. enum**
- Optamos por `text` com default `"pending"` para flexibilidade, conforme o padrão do `table_guideline.md`. Uma lista controlada de status (`pending`, `in_progress`, `done`) pode ser imposta na camada de API futuramente.

**Decisão: criar sem cross-reference inicialmente**
- Conforme o XanoScript Guidelines, a tabela será criada sem `table_reference` na primeira versão, para evitar erros de validação no Xano caso a tabela referenciada não exista. O relacionamento pode ser adicionado após o push.

## Risks / Trade-offs

- **[Risco] Status inválido**: O campo `status` como texto livre permite valores arbitrários → **Mitigação**: Validar o valor na API de criação/atualização (escopo de change futura).
- **[Risco] Orphan records**: Se um `subject` for deletado, as `academic_tasks` associadas ficam órfãs → **Mitigação**: Implementar `ON DELETE CASCADE` ou lógica de validação na API de deleção de subjects (escopo futuro).

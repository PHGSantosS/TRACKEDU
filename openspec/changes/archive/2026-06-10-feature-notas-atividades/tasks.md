## 1. Banco de Dados

- [x] 1.1 Criar tabela `activity_grades` em `tables/activity_grades.xs` com campos: `id`, `task_id` (FK → tasks), `student_id` (FK → user), `graded_by` (FK → user), `grade` (decimal), `created_at`

## 2. API

- [x] 2.1 Criar API `POST /activity_grades` em `apis/activity_grades/activity_grades_POST.xs` com autenticação, validação de task existente e preenchimento automático de `graded_by` via `$auth.id`

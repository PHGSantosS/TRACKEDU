# activity-grades Specification

## Purpose

Define a estrutura e o comportamento do sistema para registrar notas de alunos em atividades específicas no EduTrack AI.

## ADDED Requirements

### Requirement: Store activity grade
O sistema SHALL persistir a nota de um aluno em uma atividade, registrando quem lançou a nota.

#### Scenario: Professor lança nota com sucesso
- **WHEN** o professor autenticado envia `POST /activity_grades` com `task_id`, `student_id` e `grade` válidos
- **THEN** o sistema cria o registro em `activity_grades` com `graded_by` igual ao `id` do usuário autenticado e retorna o registro criado

#### Scenario: Lançamento sem autenticação
- **WHEN** uma requisição `POST /activity_grades` é feita sem token de autenticação
- **THEN** o sistema retorna erro de acesso negado

### Requirement: Validate task existence before grading
O sistema SHALL validar que a task referenciada existe antes de registrar a nota.

#### Scenario: Task inexistente
- **WHEN** o professor envia `POST /activity_grades` com um `task_id` que não existe
- **THEN** o sistema retorna erro informando que a task não foi encontrada

# Change: feature-notas-atividades

## Why

O EduTrack AI ainda não permite que professores registrem notas para alunos em atividades específicas, tornando impossível acompanhar o desempenho acadêmico dentro da plataforma. A funcionalidade de lançamento de notas é o próximo passo natural após o gerenciamento de subjects e tasks.

## What Changes

- Criação da tabela `activity_grades` para armazenar notas lançadas por professores
- Criação da API `POST /activity_grades` para permitir que o professor lance uma nota de um aluno em uma atividade (task)

## Capabilities

### New Capabilities
- `activity-grades`: Capacidade de registrar a nota de um aluno em uma atividade específica

### Modified Capabilities
<!-- Nenhuma capability existente tem seus requisitos alterados por esta mudança -->

## Impact

- Nova tabela `activity_grades` com relacionamento para `tasks` e `user`
- Novo endpoint `POST /activity_grades` restrito a usuários autenticados
- Nenhuma breaking change nas APIs existentes

# manage-academic-tasks Specification

## Purpose
Define the data structure for registering and managing academic obligations (assignments, exams, homework) linked to academic subjects in EduTrack AI. Each task is owned by a user and associated with a subject.

## ADDED Requirements

### Requirement: Store academic tasks
The system SHALL store academic tasks with title, description, due date, status, and associations to both a subject and the owning user.

#### Scenario: Student creates a new task
- **WHEN** a student creates an academic task providing a title and subject_id
- **THEN** the system stores the task with default status "pending" and associates it with the student's user_id

#### Scenario: Task has an optional description
- **WHEN** a student creates a task without providing a description
- **THEN** the system stores the task with a null description field

#### Scenario: Task has an optional due date
- **WHEN** a student creates a task without providing a due_date
- **THEN** the system stores the task with a null due_date field

### Requirement: Associate tasks with subjects
The system SHALL associate each academic task with exactly one subject via subject_id.

#### Scenario: Task is linked to an existing subject
- **WHEN** a student creates a task with a valid subject_id
- **THEN** the system stores the task referencing that subject

### Requirement: Enforce user ownership
The system SHALL associate each academic task with the authenticated user via user_id, ensuring data isolation.

#### Scenario: Task belongs to its creator
- **WHEN** a student creates a task
- **THEN** the system stores the task with the student's user_id

### Requirement: Track task status
The system SHALL assign a default status of "pending" to newly created tasks, enabling lifecycle tracking.

#### Scenario: New task defaults to pending
- **WHEN** a student creates a task without specifying a status
- **THEN** the system stores the task with status = "pending"

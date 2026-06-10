// Stores academic tasks (assignments, exams, homework) owned by a user, linked to a subject
table "academic_tasks" {
  auth = false

  schema {
    int id {
      description = "Unique identifier for the academic task"
    }

    text title filters=trim {
      description = "Title of the academic task"
    }

    text? description filters=trim {
      description = "Optional detailed description of the task"
    }

    date? due_date {
      description = "Optional deadline for the task"
    }

    text status?="pending" {
      description = "Current status of the task (pending, in_progress, done)"
    }

    // Task 1.3: subject_id - FK → subjects.id
    int subject_id {
      table = "subjects"
      description = "ID of the subject this task belongs to"
    }

    // Task 1.2: user_id - FK → user.id (data isolation per user)
    int user_id {
      table = "user"
      description = "ID of the user who owns this task"
    }

    timestamp created_at?=now {
      description = "Timestamp when the task was created"
    }
  }

  // Task 1.4: Indexes - primary on id, btree on user_id and subject_id
  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "user_id", op: "asc"}]}
    {type: "btree", field: [{name: "subject_id", op: "asc"}]}
  ]
}

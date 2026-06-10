// Stores grades assigned by teachers to students for specific tasks
table activity_grades {
  auth = false

  schema {
    int id {
      description = "Unique identifier for the grade record"
    }

    int task_id {
      table = "tasks"
      description = "ID of the task being graded"
    }

    int student_id {
      table = "user"
      description = "ID of the student who received the grade"
    }

    decimal grade {
      description = "Grade value assigned to the student"
    }

    int graded_by {
      table = "user"
      description = "ID of the user who assigned the grade"
    }

    timestamp created_at?=now {
      description = "Timestamp when the grade was recorded"
    }
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "task_id", op: "asc"}]}
    {type: "btree", field: [{name: "student_id", op: "asc"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}

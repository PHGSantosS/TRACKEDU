table tasks {
  auth = false

  schema {
    int id

    text title filters=trim {
      description = "Title of the task"
    }

    text? description filters=trim {
      description = "Optional detailed description"
    }

    enum status?=pending {
      values = ["pending", "in_progress", "done"]
      description = "Current status of the task"
    }

    int subject_id {
      table = "subjects"
      description = "Subject this task belongs to"
    }

    int user_id {
      table = "user"
      description = "Owner of this task"
    }

    timestamp? due_date {
      description = "Optional deadline"
    }

    timestamp created_at?=now
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "user_id", op: "asc"}]}
    {type: "btree", field: [{name: "subject_id", op: "asc"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}

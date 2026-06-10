query "tasks" verb=POST {
  api_group = "tasks"
  auth = "user"

  input {
    text title filters=trim
    text? description filters=trim
    int subject_id
    timestamp? due_date
    text? status
  }

  stack {
    db.get subjects {
      field_name = "id"
      field_value = $input.subject_id
    } as $subject

    precondition ($subject != null) {
      error_type = "inputerror"
      error = "Subject not found."
    }

    precondition ($subject.user_id == $auth.id) {
      error_type = "accessdenied"
      error = "You do not own this subject."
    }

    db.add tasks {
      data = {
        title      : $input.title
        description: $input.description
        status     : $input.status || "pending"
        subject_id : $input.subject_id
        user_id    : $auth.id
        due_date   : $input.due_date
        created_at : now
      }
    } as $task
  }

  response = $task
}

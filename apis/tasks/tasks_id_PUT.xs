query "tasks/{id}" verb=PUT {
  api_group = "tasks"
  auth = "user"

  input {
    int id
    text? title filters=trim
    text? description filters=trim
    text? status
    timestamp? due_date
  }

  stack {
    db.get tasks {
      field_name = "id"
      field_value = $input.id
    } as $task

    precondition ($task != null) {
      error_type = "inputerror"
      error = "Task not found."
    }

    precondition ($task.user_id == $auth.id) {
      error_type = "accessdenied"
      error = "Access denied."
    }

    db.edit tasks {
      field_name = "id"
      field_value = $input.id
      data = {
        title      : $input.title || $task.title
        description: $input.description || $task.description
        status     : $input.status || $task.status
        due_date   : $input.due_date || $task.due_date
      }
    } as $updated
  }

  response = $updated
}

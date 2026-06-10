query "tasks/{id}" verb=DELETE {
  api_group = "tasks"
  auth = "user"

  input {
    int id
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

    db.del tasks {
      field_name = "id"
      field_value = $input.id
    }
  }

  response = {success: true}
}

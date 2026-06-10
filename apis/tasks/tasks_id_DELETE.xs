// Delete a task by ID, only if owned by the authenticated user
query "tasks/{id}" verb=DELETE {
  api_group = "Tasks"
  auth = "user"

  input {
    // ID of the task to delete
    int id
  }

  stack {
    db.query tasks {
      where = $db.tasks.id == $input.id && $db.tasks.user_id == $auth.id
      return = {type: "single"}
    } as $task
  
    precondition ($task != null) {
      error = "Task not found"
    }
  
    db.del tasks {
      field_name = "id"
      field_value = $input.id
    }
  }

  response = {message: "Task deleted successfully"}
}
// Get a single task by ID, only if owned by the authenticated user
query "tasks/{id}" verb=GET {
  api_group = "Tasks"
  auth = "user"

  input {
    // ID of the task to retrieve
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
  }

  response = $task
}
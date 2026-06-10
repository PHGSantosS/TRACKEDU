// List all tasks belonging to the authenticated user, optionally filtered by subject
// Returns all tasks owned by the authenticated user, optionally filtered by subject_id
query tasks verb=GET {
  api_group = "Tasks"
  auth = "user"

  input {
    // Optional subject ID to filter tasks by
    int? subject_id
  }

  stack {
    db.query tasks {
      where = $db.tasks.user_id == $auth.id && $db.tasks.subject_id ==? $input.subject_id
      sort = {tasks.created_at: "desc"}
      return = {type: "list"}
    } as $tasks
  }

  response = $tasks
}
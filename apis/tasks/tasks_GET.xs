query "tasks" verb=GET {
  api_group = "tasks"
  auth = "user"

  input {
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

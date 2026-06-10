// List all subjects belonging to the authenticated user
// Returns all subjects owned by the authenticated user
query subjects verb=GET {
  api_group = "Subjects"
  auth = "user"

  input {
  }

  stack {
    db.query subjects {
      where = $db.subjects.user_id == $auth.id
      sort = {subjects.created_at: "desc"}
      return = {type: "list"}
    } as $subjects
  }

  response = $subjects
}
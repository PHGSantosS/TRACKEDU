query "subjects" verb=GET {
  api_group = "subjects"
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

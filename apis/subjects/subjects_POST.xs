query "subjects" verb=POST {
  api_group = "subjects"
  auth = "user"

  input {
    text name filters=trim
    text? description filters=trim
  }

  stack {
    db.add subjects {
      data = {
        name       : $input.name
        description: $input.description
        user_id    : $auth.id
        created_at : now
      }
    } as $subject
  }

  response = $subject
}

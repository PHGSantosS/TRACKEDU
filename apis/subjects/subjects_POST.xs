// Create a new subject for the authenticated user
// Creates a new subject owned by the authenticated user
query subjects verb=POST {
  api_group = "Subjects"
  auth = "user"

  input {
    // Name of the subject
    text name filters=trim
  
    // Optional description of the subject
    text? description filters=trim
  }

  stack {
    db.add subjects {
      data = {
        name       : $input.name
        description: $input.description
        user_id    : $auth.id
      }
    } as $new_subject
  }

  response = $new_subject
}
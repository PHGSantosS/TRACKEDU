// Get a single subject by ID, only if owned by the authenticated user
query "subjects/{id}" verb=GET {
  api_group = "Subjects"
  auth = "user"

  input {
    // ID of the subject to retrieve
    int id
  }

  stack {
    db.query "" {
      where = $db.subjects.id == $input.id && $db.subjects.user_id == $auth.id
      return = {type: "single"}
    } as $subject
  
    precondition ($subject != null) {
      error = "Subject not found"
    }
  }

  response = $subject
}
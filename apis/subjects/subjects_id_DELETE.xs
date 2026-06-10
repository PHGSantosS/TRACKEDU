// Delete a subject by ID, only if owned by the authenticated user
query "subjects/{id}" verb=DELETE {
  api_group = "Subjects"
  auth = "user"

  input {
    // ID of the subject to delete
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
  
    db.del "" {
      field_name = "id"
      field_value = $input.id
    }
  }

  response = {message: "Subject deleted successfully"}
}
query "subjects/{id}" verb=PUT {
  api_group = "subjects"
  auth = "user"

  input {
    int id
    text? name filters=trim
    text? description filters=trim
  }

  stack {
    db.get subjects {
      field_name = "id"
      field_value = $input.id
    } as $subject

    precondition ($subject != null) {
      error_type = "inputerror"
      error = "Subject not found."
    }

    precondition ($subject.user_id == $auth.id) {
      error_type = "accessdenied"
      error = "Access denied."
    }

    db.edit subjects {
      field_name = "id"
      field_value = $input.id
      data = {
        name       : $input.name || $subject.name
        description: $input.description || $subject.description
      }
    } as $updated
  }

  response = $updated
}

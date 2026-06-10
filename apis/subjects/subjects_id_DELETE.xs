query "subjects/{id}" verb=DELETE {
  api_group = "subjects"
  auth = "user"

  input {
    int id
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

    db.del subjects {
      field_name = "id"
      field_value = $input.id
    }
  }

  response = {success: true}
}

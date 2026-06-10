// Update a subject by ID, only if owned by the authenticated user
query "subjects/{id}" verb=PUT {
  api_group = "Subjects"
  auth = "user"

  input {
    // ID of the subject to update
    int id
  
    // New name for the subject
    text? name filters=trim
  
    // New description for the subject
    text? description filters=trim
  }

  stack {
    db.query "" {
      where = $db.subjects.id == $input.id && $db.subjects.user_id == $auth.id
      return = {type: "single"}
    } as $subject
  
    precondition ($subject != null) {
      error = "Subject not found"
    }
  
    var $payload {
      value = {}
    }
  
    conditional {
      if ($input.name != null) {
        var.update $payload.name {
          value = $input.name
        }
      }
    }
  
    conditional {
      if ($input.description != null) {
        var.update $payload.description {
          value = $input.description
        }
      }
    }
  
    db.patch "" {
      field_name = "id"
      field_value = $input.id
      data = $payload
    } as $updated_subject
  }

  response = $updated_subject
}
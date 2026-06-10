// Update a task by ID, only if owned by the authenticated user
query "tasks/{id}" verb=PUT {
  api_group = "Tasks"
  auth = "user"

  input {
    // ID of the task to update
    int id
  
    // New title for the task
    text? title filters=trim
  
    // New description for the task
    text? description filters=trim
  
    // New status for the task
    enum? status {
      values = ["pending", "in_progress", "done"]
    }
  
    // New deadline for the task
    timestamp? due_date
  }

  stack {
    db.query tasks {
      where = $db.tasks.id == $input.id && $db.tasks.user_id == $auth.id
      return = {type: "single"}
    } as $task
  
    precondition ($task != null) {
      error = "Task not found"
    }
  
    var $payload {
      value = {}
    }
  
    conditional {
      if ($input.title != null) {
        var.update $payload.title {
          value = $input.title
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
  
    conditional {
      if ($input.status != null) {
        var.update $payload.status {
          value = $input.status
        }
      }
    }
  
    conditional {
      if ($input.due_date != null) {
        var.update $payload.due_date {
          value = $input.due_date
        }
      }
    }
  
    db.patch tasks {
      field_name = "id"
      field_value = $input.id
      data = $payload
    } as $updated_task
  }

  response = $updated_task
}
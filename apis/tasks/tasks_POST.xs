// Create a new task for the authenticated user linked to a subject
query tasks verb=POST {
  api_group = "Tasks"
  auth = "user"

  input {
    // Title of the task
    text title filters=trim
  
    // Optional description of the task
    text? description filters=trim
  
    // ID of the subject this task belongs to
    int subject_id
  
    // Optional deadline for the task
    timestamp? due_date
  }

  stack {
    // Verify the subject exists and belongs to the authenticated user
    db.query subjects {
      where = $db.subjects.id == $input.subject_id && $db.subjects.user_id == $auth.id
      return = {type: "single"}
    } as $subject
  
    precondition ($subject != null) {
      error = "Subject not found"
    }
  
    db.add tasks {
      data = {
        title      : $input.title
        description: $input.description
        subject_id : $input.subject_id
        user_id    : $auth.id
        due_date   : $input.due_date
        status     : "pending"
      }
    } as $new_task
  }

  response = $new_task
}
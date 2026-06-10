// Stores tasks associated with a subject, owned by a user
table tasks {
  auth = false

  schema {
    // Unique identifier for the task
    int id
  
    // Title of the task
    text title filters=trim
  
    // Optional detailed description of the task
    text? description filters=trim
  
    // Current status of the task
    enum status?=pending {
      values = ["pending", "in_progress", "done"]
    }
  
    // ID of the subject this task belongs to
    int subject_id {
      table = "subjects"
    }
  
    // ID of the user who owns this task
    int user_id {
      table = "user"
    }
  
    // Optional deadline for the task
    timestamp? due_date?
  
    // Timestamp when the task was created
    timestamp created_at?=now
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "user_id", op: "asc"}]}
    {type: "btree", field: [{name: "subject_id", op: "asc"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}
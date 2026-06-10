table subjects {
  auth = false

  schema {
    int id

    text name filters=trim {
      description = "Name of the academic subject"
    }

    text? description filters=trim {
      description = "Optional description of the subject"
    }

    int user_id {
      table = "user"
      description = "ID of the user who owns this subject"
    }

    timestamp created_at?=now
  }

  index = [
    {type: "primary", field: [{name: "id"}]}
    {type: "btree", field: [{name: "user_id", op: "asc"}]}
    {type: "btree", field: [{name: "created_at", op: "desc"}]}
  ]
}

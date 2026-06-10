// Record a grade for a student on a specific task
query activity_grades verb=POST {
  api_group = "Activity_Grades"
  auth = "user"

  input {
    // ID of the task being graded
    int task_id
    // ID of the student receiving the grade
    int student_id
    // Grade value to assign
    decimal grade
  }

  stack {
    // Validate the task exists
    db.get tasks {
      field_name  = "id"
      field_value = $input.task_id
    } as $task

    precondition ($task != null) {
      error = "Task not found"
    }

    db.add activity_grades {
      data = {
        task_id   : $input.task_id
        student_id: $input.student_id
        grade     : $input.grade
        graded_by : $auth.id
      }
    } as $new_grade
  }

  response = $new_grade
}

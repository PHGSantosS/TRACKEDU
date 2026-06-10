# System Context

## Overview
TrackEdu is an academic management backend built using XanoScript, hosted on Xano.

## Purpose
Allow users to manage their academic subjects and tasks. Each user has isolated access — they can only see and modify their own data.

## Core Entities
- **Users** — native Xano authentication (signup, login, password reset via magic link)
- **Subjects** — academic disciplines created and owned by a user
- **Tasks** — actionable items linked to a subject, owned by a user

## Relationships
- Each subject belongs to one user (`subjects.user_id → user.id`)
- Each task belongs to one subject and one user (`tasks.subject_id → subjects.id`, `tasks.user_id → user.id`)
- User isolation is enforced at the API layer: all queries filter by `$auth.id`

## API Groups
- **Authentication** — signup, login, get current user, password reset
- **Subjects** — CRUD for subjects scoped to the authenticated user
- **Tasks** — CRUD for tasks scoped to the authenticated user, filterable by subject

## Access Control
- All subject and task endpoints require a valid JWT (`auth = "user"`)
- Individual record endpoints verify ownership before read/write/delete
- A 404 is returned when a record doesn't exist or doesn't belong to the user

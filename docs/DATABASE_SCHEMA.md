# Database Schema Configuration

## Schema Information

- **Schema Name**: MES
- **Table Prefix**: PMP_
- **Database**: Oracle 19c

## Table Structure

### PMP_USERS
- Primary Key: id (NUMBER(19))
- Unique Index: username
- Indexes: email, role

### PMP_PROJECTS
- Primary Key: id (NUMBER(19))
- Indexes: created_by_id, status

### PMP_TASKS
- Primary Key: id (NUMBER(19))
- Indexes: project_id, assignee_id, status, priority

### PMP_COMMENTS
- Primary Key: id (NUMBER(19))
- Indexes: task_id, user_id

### PMP_ATTACHMENTS
- Primary Key: id (NUMBER(19))
- Indexes: task_id, uploaded_by_id

## Foreign Keys

- PMP_PROJECTS.created_by_id → PMP_USERS.id
- PMP_TASKS.project_id → PMP_PROJECTS.id
- PMP_TASKS.assignee_id → PMP_USERS.id
- PMP_TASKS.created_by_id → PMP_USERS.id
- PMP_TASKS.reviewer_id → PMP_USERS.id
- PMP_COMMENTS.task_id → PMP_TASKS.id
- PMP_COMMENTS.user_id → PMP_USERS.id
- PMP_ATTACHMENTS.task_id → PMP_TASKS.id
- PMP_ATTACHMENTS.uploaded_by_id → PMP_USERS.id

## Default User

- **Username**: admin
- **Password**: admin123 (BCrypt encoded)
- **Role**: ADMIN
- **Email**: admin@projecttracking.com
- **Active**: true

## Backend Configuration

The backend is configured to use the MES schema automatically:

- `application.yml`: `schema: MES`
- `application.yml`: `default_schema: MES`
- Entity classes: `@Table(name = "MES.PMP_...", schema = "MES")`

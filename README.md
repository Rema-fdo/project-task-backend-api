# Project Task Backend API – Documentation

## 1. Overview

This document describes the backend REST APIs for the **Project Task Management System** built using **Ruby on Rails (API-only)**. The system manages Projects, Tasks, Comments, Attachments (polymorphic), and Task Members using clean architecture with **Service Objects**.

---

## 2. Technology Stack

* Ruby 3.x
* Rails 8.x (API-only)
* MySQL
* JWT Authentication
* Service Object Pattern

---

## 3. High-Level Features

* Authentication (JWT-based)
* Project CRUD
* Task CRUD (under projects)
* Comment CRUD (under tasks)
* Polymorphic Attachments (Tasks & Comments)
* Task member assignment
* Cascade deletion (Project → Tasks → Comments/Attachments)

---

## 4. Authentication

All protected APIs require a valid JWT token.

### Request Header

```
Authorization: Bearer <JWT_TOKEN>
Content-Type: application/json
```

---

## 5. Entity Relationships

### Project

* has_many :tasks (dependent: :destroy)

### Task

* belongs_to :project
* belongs_to :status
* belongs_to :priority
* has_many :comments
* has_many :task_members
* has_many :users, through: :task_members
* has_many :attachments (polymorphic)

### Comment

* belongs_to :task
* has_many :attachments (polymorphic)

### Attachment

* belongs_to :attachable (polymorphic: Task or Comment)

### TaskMember

* belongs_to :task
* belongs_to :user

---

## 6. API Endpoints

### 6.1 Project APIs

#### Create Project

POST /api/v1/projects

```json
{
  "project": {
    "title": "Task Management",
    "description": "Backend API project"
  }
}
```

#### Get All Projects

GET /api/v1/projects

* Returns only `id`, `title`, and `description`

#### Get Project by ID (with Tasks)

GET /api/v1/projects/:id

#### Update Project

PATCH /api/v1/projects/:id

```json
{
  "project": {
    "title": "Updated Title"
  }
}
```

#### Delete Project

DELETE /api/v1/projects/:id

* Deletes associated tasks automatically

---

### 6.2 Task APIs

#### Create Task

POST /api/v1/projects/:project_id/tasks

```json
{
  "task": {
    "title": "Design DB",
    "description": "Create schema",
    "status_id": 1,
    "priority_id": 2
  }
}
```

#### List Tasks for Project

GET /api/v1/projects/:project_id/tasks

#### Get Task by ID

GET /api/v1/tasks/:id

#### Update Task

PATCH /api/v1/tasks/:id

#### Delete Task

DELETE /api/v1/tasks/:id

---

### 6.3 Comment APIs

#### Create Comment

POST /api/v1/tasks/:task_id/comments

```json
{
  "comment": {
    "content": "Task is in progress"
  }
}
```

#### List Comments

GET /api/v1/tasks/:task_id/comments

#### Update Comment

PATCH /api/v1/tasks/:task_id/comments/:id

#### Delete Comment

DELETE /api/v1/tasks/:task_id/comments/:id

---

### 6.4 Task Member APIs

#### Add User to Task

POST /api/v1/tasks/:task_id/task_members

```json
{
  "task_member": {
    "user_id": 3
  }
}
```

#### List Task Members

GET /api/v1/tasks/:task_id/task_members

#### Remove Task Member

DELETE /api/v1/tasks/:task_id/task_members/:id

---

### 6.5 Attachment APIs (Polymorphic)

#### Add Attachment to Task

POST /api/v1/tasks/:task_id/attachments

```json
{
  "attachment": {
    "file_url": "https://example.com/file.pdf"
  }
}
```

#### Add Attachment to Comment

POST /api/v1/comments/:comment_id/attachments

#### Delete Attachment

DELETE /api/v1/tasks/:task_id/attachments/:id

---

## 7. Service Object Usage

Each CRUD operation is implemented using a dedicated service class:

* Projects::CreateService
* Projects::ListService
* Projects::ShowService
* Projects::UpdateService
* Projects::DeleteService

### Benefits

* Thin controllers
* Reusable business logic
* Easier testing and maintenance

---

## 8. Error Handling

* Validation errors return `422 Unprocessable Entity`
* Record not found returns `404 Not Found`
* Authentication failures return `401 Unauthorized`

---

## 9. Assumptions & Notes

* File uploads are represented using `file_url`
* Pagination not implemented
* Authorization rules can be added later
* ActiveStorage can be integrated in future

---

## 10. Future Enhancements

* Pagination & filtering
* Role-based authorization
* Swagger / OpenAPI documentation
* RSpec test coverage

---

## 11. Conclusion

This API follows real-world Rails backend best practices and is suitable for production-grade applications, technical assignments, and interviews.

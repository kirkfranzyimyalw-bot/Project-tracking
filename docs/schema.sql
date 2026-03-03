-- Project Tracking System Database Schema
-- Oracle Database

-- Create users table
CREATE TABLE users (
    id NUMBER(19) PRIMARY KEY,
    username VARCHAR2(50) UNIQUE NOT NULL,
    password VARCHAR2(255) NOT NULL,
    email VARCHAR2(100),
    full_name VARCHAR2(100),
    role VARCHAR2(20) NOT NULL,
    department VARCHAR2(100),
    active NUMBER(1) DEFAULT 1,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    updated_at TIMESTAMP
);

-- Create projects table
CREATE TABLE projects (
    id NUMBER(19) PRIMARY KEY,
    name VARCHAR2(255) NOT NULL,
    description VARCHAR2(4000),
    status VARCHAR2(20) DEFAULT 'ACTIVE',
    created_by_id NUMBER(19),
    start_date TIMESTAMP,
    end_date TIMESTAMP,
    completed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (created_by_id) REFERENCES users(id)
);

-- Create tasks table
CREATE TABLE tasks (
    id NUMBER(19) PRIMARY KEY,
    title VARCHAR2(255) NOT NULL,
    description VARCHAR2(4000),
    status VARCHAR2(20) DEFAULT 'TODO',
    priority VARCHAR2(20) DEFAULT 'MEDIUM',
    project_id NUMBER(19),
    assignee_id NUMBER(19),
    created_by_id NUMBER(19),
    reviewer_id NUMBER(19),
    due_date TIMESTAMP,
    completed_at TIMESTAMP,
    started_at TIMESTAMP,
    review_started_at TIMESTAMP,
    progress NUMBER(5) DEFAULT 0,
    previous_status VARCHAR2(20),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    updated_at TIMESTAMP,
    FOREIGN KEY (project_id) REFERENCES projects(id),
    FOREIGN KEY (assignee_id) REFERENCES users(id),
    FOREIGN KEY (created_by_id) REFERENCES users(id),
    FOREIGN KEY (reviewer_id) REFERENCES users(id)
);

-- Create comments table
CREATE TABLE comments (
    id NUMBER(19) PRIMARY KEY,
    content VARCHAR2(4000),
    task_id NUMBER(19),
    user_id NUMBER(19),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Create attachments table
CREATE TABLE attachments (
    id NUMBER(19) PRIMARY KEY,
    file_name VARCHAR2(255) NOT NULL,
    file_path VARCHAR2(500) NOT NULL,
    file_type VARCHAR2(100),
    file_size NUMBER(20),
    task_id NUMBER(19),
    uploaded_by_id NUMBER(19),
    uploaded_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES tasks(id),
    FOREIGN KEY (uploaded_by_id) REFERENCES users(id)
);

-- Create indexes for better performance
CREATE INDEX idx_users_username ON users(username);
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);

CREATE INDEX idx_projects_created_by ON projects(created_by_id);
CREATE INDEX idx_projects_status ON projects(status);

CREATE INDEX idx_tasks_project ON tasks(project_id);
CREATE INDEX idx_tasks_assignee ON tasks(assignee_id);
CREATE INDEX idx_tasks_status ON tasks(status);
CREATE INDEX idx_tasks_priority ON tasks(priority);

CREATE INDEX idx_comments_task ON comments(task_id);
CREATE INDEX idx_comments_user ON comments(user_id);

CREATE INDEX idx_attachments_task ON attachments(task_id);
CREATE INDEX idx_attachments_user ON attachments(uploaded_by_id);

-- Insert default admin user (password: admin123, BCrypt encoded)
INSERT INTO users (id, username, password, email, full_name, role, active)
VALUES (1, 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'admin@projecttracking.com', 'Administrator', 'ADMIN', 1);

COMMIT;

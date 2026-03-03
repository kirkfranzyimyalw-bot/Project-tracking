-- Project Tracking System Database Schema
-- Oracle Database
-- Schema: MES, Table Prefix: PMP_

-- Create users table
CREATE TABLE MES.PMP_USERS (
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
CREATE TABLE MES.PMP_PROJECTS (
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
    FOREIGN KEY (created_by_id) REFERENCES MES.PMP_USERS(id)
);

-- Create tasks table
CREATE TABLE MES.PMP_TASKS (
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
    FOREIGN KEY (project_id) REFERENCES MES.PMP_PROJECTS(id),
    FOREIGN KEY (assignee_id) REFERENCES MES.PMP_USERS(id),
    FOREIGN KEY (created_by_id) REFERENCES MES.PMP_USERS(id),
    FOREIGN KEY (reviewer_id) REFERENCES MES.PMP_USERS(id)
);

-- Create comments table
CREATE TABLE MES.PMP_COMMENTS (
    id NUMBER(19) PRIMARY KEY,
    content VARCHAR2(4000),
    task_id NUMBER(19),
    user_id NUMBER(19),
    created_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES MES.PMP_TASKS(id),
    FOREIGN KEY (user_id) REFERENCES MES.PMP_USERS(id)
);

-- Create attachments table
CREATE TABLE MES.PMP_ATTACHMENTS (
    id NUMBER(19) PRIMARY KEY,
    file_name VARCHAR2(255) NOT NULL,
    file_path VARCHAR2(500) NOT NULL,
    file_type VARCHAR2(100),
    file_size NUMBER(20),
    task_id NUMBER(19),
    uploaded_by_id NUMBER(19),
    uploaded_at TIMESTAMP DEFAULT SYSTIMESTAMP,
    FOREIGN KEY (task_id) REFERENCES MES.PMP_TASKS(id),
    FOREIGN KEY (uploaded_by_id) REFERENCES MES.PMP_USERS(id)
);

-- Create indexes for better performance
-- Note: username already has index from UNIQUE constraint
CREATE INDEX idx_pmp_users_email ON MES.PMP_USERS(email);
CREATE INDEX idx_pmp_users_role ON MES.PMP_USERS(role);

CREATE INDEX idx_pmp_projects_created_by ON MES.PMP_PROJECTS(created_by_id);
CREATE INDEX idx_pmp_projects_status ON MES.PMP_PROJECTS(status);

CREATE INDEX idx_pmp_tasks_project ON MES.PMP_TASKS(project_id);
CREATE INDEX idx_pmp_tasks_assignee ON MES.PMP_TASKS(assignee_id);
CREATE INDEX idx_pmp_tasks_status ON MES.PMP_TASKS(status);
CREATE INDEX idx_pmp_tasks_priority ON MES.PMP_TASKS(priority);

CREATE INDEX idx_pmp_comments_task ON MES.PMP_COMMENTS(task_id);
CREATE INDEX idx_pmp_comments_user ON MES.PMP_COMMENTS(user_id);

CREATE INDEX idx_pmp_attachments_task ON MES.PMP_ATTACHMENTS(task_id);
CREATE INDEX idx_pmp_attachments_user ON MES.PMP_ATTACHMENTS(uploaded_by_id);

-- Insert default admin user (password: admin123, BCrypt encoded)
INSERT INTO MES.PMP_USERS (id, username, password, email, full_name, role, active)
VALUES (1, 'admin', '$2a$10$N.zmdr9k7uOCQb376NoUnuTJ8iAt6Z5EHsM8lE9lBOsl7iAt6Z5EH', 'admin@projecttracking.com', 'Administrator', 'ADMIN', 1);

COMMIT;

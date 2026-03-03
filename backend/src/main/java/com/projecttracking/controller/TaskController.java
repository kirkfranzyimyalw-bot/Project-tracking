package com.projecttracking.controller;

import com.projecttracking.model.*;
import com.projecttracking.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/tasks")
@CrossOrigin(origins = "*")
public class TaskController {

    @Autowired
    private TaskService taskService;

    @PostMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'PRODUCT_MANAGER')")
    public ResponseEntity<Task> createTask(@RequestBody Task task) {
        Task savedTask = taskService.save(task);
        return ResponseEntity.ok(savedTask);
    }

    @GetMapping
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'TESTER', 'PRODUCT_MANAGER', 'MEMBER', 'VISITOR')")
    public ResponseEntity<List<Task>> getAllTasks() {
        return ResponseEntity.ok(taskService.findAll());
    }

    @GetMapping("/project/{projectId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'TESTER', 'PRODUCT_MANAGER', 'MEMBER', 'VISITOR')")
    public ResponseEntity<List<Task>> getTasksByProject(@PathVariable Long projectId) {
        Project project = new Project();
        project.setId(projectId);
        return ResponseEntity.ok(taskService.findByProject(project));
    }

    @GetMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'TESTER', 'PRODUCT_MANAGER', 'MEMBER', 'VISITOR')")
    public ResponseEntity<Task> getTaskById(@PathVariable Long id) {
        return taskService.findById(id)
                .map(ResponseEntity::ok)
                .orElse(ResponseEntity.notFound().build());
    }

    @PutMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'PRODUCT_MANAGER')")
    public ResponseEntity<Task> updateTask(@PathVariable Long id, @RequestBody Task task) {
        if (!taskService.findById(id).isPresent()) {
            return ResponseEntity.notFound().build();
        }
        task.setId(id);
        Task updatedTask = taskService.update(task);
        return ResponseEntity.ok(updatedTask);
    }

    @DeleteMapping("/{id}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER')")
    public ResponseEntity<Void> deleteTask(@PathVariable Long id) {
        taskService.delete(id);
        return ResponseEntity.noContent().build();
    }

    @GetMapping("/project/{projectId}/status/{status}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'TESTER', 'PRODUCT_MANAGER', 'MEMBER', 'VISITOR')")
    public ResponseEntity<List<Task>> getTasksByProjectAndStatus(@PathVariable Long projectId, @PathVariable TaskStatus status) {
        Project project = new Project();
        project.setId(projectId);
        return ResponseEntity.ok(taskService.findByProjectAndStatus(project, status));
    }

    @GetMapping("/project/{projectId}/priority/{priority}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'TESTER', 'PRODUCT_MANAGER', 'MEMBER', 'VISITOR')")
    public ResponseEntity<List<Task>> getTasksByProjectAndPriority(@PathVariable Long projectId, @PathVariable TaskPriority priority) {
        Project project = new Project();
        project.setId(projectId);
        return ResponseEntity.ok(taskService.findByProjectAndPriority(project, priority));
    }

    @GetMapping("/assignee/{userId}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'TESTER', 'PRODUCT_MANAGER', 'MEMBER', 'VISITOR')")
    public ResponseEntity<List<Task>> getTasksByAssignee(@PathVariable Long userId) {
        User user = new User();
        user.setId(userId);
        return ResponseEntity.ok(taskService.findByAssignee(user));
    }

    @GetMapping("/assignee/{userId}/status/{status}")
    @PreAuthorize("hasAnyRole('ADMIN', 'PROJECT_MANAGER', 'DEVELOPER', 'TESTER', 'PRODUCT_MANAGER', 'MEMBER', 'VISITOR')")
    public ResponseEntity<List<Task>> getTasksByAssigneeAndStatus(@PathVariable Long userId, @PathVariable TaskStatus status) {
        User user = new User();
        user.setId(userId);
        return ResponseEntity.ok(taskService.findByAssigneeAndStatus(user, status));
    }
}

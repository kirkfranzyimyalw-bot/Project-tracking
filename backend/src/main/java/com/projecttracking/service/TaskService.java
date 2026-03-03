package com.projecttracking.service;

import com.projecttracking.model.*;
import com.projecttracking.repository.TaskRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;

@Service
@Transactional
public class TaskService {

    @Autowired
    private TaskRepository taskRepository;

    public Task save(Task task) {
        return taskRepository.save(task);
    }

    public Optional<Task> findById(Long id) {
        return taskRepository.findById(id);
    }

    public List<Task> findByProject(Project project) {
        return taskRepository.findByProject(project);
    }

    public List<Task> findByProjectAndStatus(Project project, TaskStatus status) {
        return taskRepository.findByProjectAndStatus(project, status);
    }

    public List<Task> findByProjectAndPriority(Project project, TaskPriority priority) {
        return taskRepository.findByProjectAndPriority(project, priority);
    }

    public List<Task> findByAssignee(User assignee) {
        return taskRepository.findByAssignee(assignee);
    }

    public List<Task> findByAssigneeAndStatus(User assignee, TaskStatus status) {
        return taskRepository.findByAssigneeAndStatus(assignee, status);
    }

    public List<Task> findByAssigneeAndPriority(User assignee, TaskPriority priority) {
        return taskRepository.findByAssigneeAndPriority(assignee, priority);
    }

    public List<Task> findAll() {
        return taskRepository.findAll();
    }

    public Task update(Task task) {
        return taskRepository.save(task);
    }

    public void delete(Long id) {
        taskRepository.deleteById(id);
    }

    public long countByProject(Project project) {
        return taskRepository.countByProject(project);
    }

    public long countByProjectAndStatus(Project project, TaskStatus status) {
        return taskRepository.countByProjectAndStatus(project, status);
    }

    public long countByProjectAndPriority(Project project, TaskPriority priority) {
        return taskRepository.countByProjectAndPriority(project, priority);
    }
}

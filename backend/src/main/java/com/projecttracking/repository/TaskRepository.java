package com.projecttracking.repository;

import com.projecttracking.model.Project;
import com.projecttracking.model.Task;
import com.projecttracking.model.TaskPriority;
import com.projecttracking.model.TaskStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface TaskRepository extends JpaRepository<Task, Long> {

    List<Task> findByProject(Project project);

    List<Task> findByProjectAndStatus(Project project, TaskStatus status);

    List<Task> findByProjectAndPriority(Project project, TaskPriority priority);

    List<Task> findByAssignee(User assignee);

    List<Task> findByAssigneeAndStatus(User assignee, TaskStatus status);

    List<Task> findByAssigneeAndPriority(User assignee, TaskPriority priority);

    Page<Task> findByProject(Project project, Pageable pageable);

    @Query("SELECT t FROM Task t WHERE t.project = :project AND t.status = :status")
    List<Task> findByProjectAndStatus(@Param("project") Project project, @Param("status") TaskStatus status);

    @Query("SELECT t FROM Task t WHERE t.assignee = :user AND t.status = :status")
    List<Task> findByAssigneeAndStatus(@Param("user") User user, @Param("status") TaskStatus status);

    @Query("SELECT t FROM Task t WHERE t.project = :project AND t.priority = :priority")
    List<Task> findByProjectAndPriority(@Param("project") Project project, @Param("priority") TaskPriority priority);

    @Query("SELECT t FROM Task t WHERE t.assignee = :user AND t.priority = :priority")
    List<Task> findByAssigneeAndPriority(@Param("user") User user, @Param("priority") TaskPriority priority);

    long countByProject(Project project);

    long countByProjectAndStatus(Project project, TaskStatus status);

    long countByProjectAndPriority(Project project, TaskPriority priority);

    long countByAssignee(User assignee);

    long countByAssigneeAndStatus(User assignee, TaskStatus status);
}

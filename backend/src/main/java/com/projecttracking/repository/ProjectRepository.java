package com.projecttracking.repository;

import com.projecttracking.model.Project;
import com.projecttracking.model.ProjectStatus;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long> {

    List<Project> findByCreatedBy(User createdBy);

    List<Project> findByStatus(ProjectStatus status);

    Page<Project> findByCreatedBy(User createdBy, Pageable pageable);

    @Query("SELECT p FROM Project p WHERE p.createdBy = :user AND p.status = :status")
    List<Project> findByCreatedByAndStatus(@Param("user") User user, @Param("status") ProjectStatus status);

    long countByStatus(ProjectStatus status);

    List<Project> findByStatusIn(List<ProjectStatus> statuses);
}

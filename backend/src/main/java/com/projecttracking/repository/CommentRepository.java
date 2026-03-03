package com.projecttracking.repository;

import com.projecttracking.model.Comment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface CommentRepository extends JpaRepository<Comment, Long> {

    List<Comment> findByTask(com.projecttracking.model.Task task);

    List<Comment> findByTaskAndUser(com.projecttracking.model.Task task, com.projecttracking.model.User user);
}

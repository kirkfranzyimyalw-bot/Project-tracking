package com.projecttracking.repository;

import com.projecttracking.model.Attachment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface AttachmentRepository extends JpaRepository<Attachment, Long> {

    List<Attachment> findByTask(com.projecttracking.model.Task task);

    List<Attachment> findByTaskAndUploadedBy(com.projecttracking.model.Task task, com.projecttracking.model.User user);
}

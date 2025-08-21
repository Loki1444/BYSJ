package com.hotel.management.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class User {
    private Long id;
    private String username;
    private String password;
    private String realName;
    private String phone;
    private String email;
    private UserRole role;
    private Integer status;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public enum UserRole {
        ADMIN, MANAGER, STAFF
    }
}
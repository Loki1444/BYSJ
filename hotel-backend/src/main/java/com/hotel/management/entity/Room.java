package com.hotel.management.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class Room {
    private Long id;
    private String roomNumber;
    private Long roomTypeId;
    private Integer floor;
    private RoomStatus status;
    private String description;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // 关联的房型信息
    private RoomType roomType;

    public enum RoomStatus {
        AVAILABLE, OCCUPIED, MAINTENANCE, CLEANING
    }
}
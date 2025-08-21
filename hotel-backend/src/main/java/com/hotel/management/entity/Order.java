package com.hotel.management.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class Order {
    private Long id;
    private String orderNumber;
    private Long customerId;
    private Long roomId;
    private LocalDate checkInDate;
    private LocalDate checkOutDate;
    private LocalDateTime actualCheckIn;
    private LocalDateTime actualCheckOut;
    private Integer adults;
    private Integer children;
    private BigDecimal totalAmount;
    private BigDecimal paidAmount;
    private OrderStatus status;
    private PaymentStatus paymentStatus;
    private String notes;
    private Long createdBy;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // 关联信息
    private Customer customer;
    private Room room;
    private User creator;

    public enum OrderStatus {
        PENDING, CONFIRMED, CHECKED_IN, CHECKED_OUT, CANCELLED
    }

    public enum PaymentStatus {
        UNPAID, PARTIAL, PAID, REFUNDED
    }
}
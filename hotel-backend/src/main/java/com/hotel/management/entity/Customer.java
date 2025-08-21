package com.hotel.management.entity;

import lombok.Data;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;

@Data
public class Customer {
    private Long id;
    private String name;
    private String phone;
    private String idCard;
    private String email;
    private String address;
    private Gender gender;
    private LocalDate birthDate;
    private VipLevel vipLevel;
    private BigDecimal totalConsumption;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public enum Gender {
        MALE, FEMALE, OTHER
    }

    public enum VipLevel {
        NORMAL, SILVER, GOLD, PLATINUM
    }
}
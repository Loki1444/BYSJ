package com.hotel.management.dto;

import lombok.Data;

@Data
public class PageQuery {
    private Integer page = 1;
    private Integer size = 10;
    private String sortBy = "id";
    private String sortOrder = "desc";

    public Integer getOffset() {
        return (page - 1) * size;
    }
}
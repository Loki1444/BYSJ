package com.hotel.management.mapper;

import com.hotel.management.entity.User;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface UserMapper {

    User findByUsername(@Param("username") String username);

    User findById(@Param("id") Long id);

    List<User> findAll(@Param("offset") Integer offset, @Param("size") Integer size);

    Long countAll();

    int insert(User user);

    int update(User user);

    int deleteById(@Param("id") Long id);
}
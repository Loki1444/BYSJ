package com.hotel.management.service;

import com.hotel.management.dto.PageQuery;
import com.hotel.management.dto.PageResult;
import com.hotel.management.entity.User;
import com.hotel.management.mapper.UserMapper;
import com.hotel.management.utils.JwtUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class UserService {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private JwtUtil jwtUtil;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    public String login(String username, String password) {
        User user = userMapper.findByUsername(username);
        if (user == null) {
            throw new RuntimeException("用户不存在");
        }

        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("密码错误");
        }

        if (user.getStatus() == 0) {
            throw new RuntimeException("用户已被禁用");
        }

        return jwtUtil.generateToken(user.getId(), user.getUsername(), user.getRole().name());
    }

    public User getUserById(Long id) {
        return userMapper.findById(id);
    }

    public User getUserByUsername(String username) {
        return userMapper.findByUsername(username);
    }

    public PageResult<User> getUsers(PageQuery pageQuery) {
        List<User> users = userMapper.findAll(pageQuery.getOffset(), pageQuery.getSize());
        Long total = userMapper.countAll();
        return new PageResult<>(users, total, pageQuery.getPage(), pageQuery.getSize());
    }

    public User createUser(User user) {
        // 检查用户名是否已存在
        if (userMapper.findByUsername(user.getUsername()) != null) {
            throw new RuntimeException("用户名已存在");
        }

        // 加密密码
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setStatus(1);

        userMapper.insert(user);
        return user;
    }

    public User updateUser(User user) {
        User existingUser = userMapper.findById(user.getId());
        if (existingUser == null) {
            throw new RuntimeException("用户不存在");
        }

        // 如果密码有变化，需要重新加密
        if (user.getPassword() != null && !user.getPassword().isEmpty()) {
            user.setPassword(passwordEncoder.encode(user.getPassword()));
        } else {
            user.setPassword(existingUser.getPassword());
        }

        userMapper.update(user);
        return user;
    }

    public void deleteUser(Long id) {
        if (userMapper.findById(id) == null) {
            throw new RuntimeException("用户不存在");
        }
        userMapper.deleteById(id);
    }
}
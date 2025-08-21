package com.hotel.management.controller;

import com.hotel.management.dto.Result;
import com.hotel.management.entity.User;
import com.hotel.management.service.UserService;
import com.hotel.management.utils.JwtUtil;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import jakarta.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.Map;

@RestController
@RequestMapping("/auth")
@CrossOrigin
public class AuthController {

    @Autowired
    private UserService userService;

    @Autowired
    private JwtUtil jwtUtil;

    @PostMapping("/login")
    public Result<Map<String, Object>> login(@RequestBody LoginRequest request) {
        try {
            String token = userService.login(request.getUsername(), request.getPassword());
            User user = userService.getUserByUsername(request.getUsername());

            Map<String, Object> data = new HashMap<>();
            data.put("token", token);
            data.put("user", user);

            return Result.success("登录成功", data);
        } catch (Exception e) {
            return Result.error(e.getMessage());
        }
    }

    @GetMapping("/info")
    public Result<User> getUserInfo(HttpServletRequest request) {
        try {
            String token = request.getHeader("Authorization");
            if (token != null && token.startsWith("Bearer ")) {
                token = token.substring(7);
                String username = jwtUtil.getUsernameFromToken(token);
                User user = userService.getUserByUsername(username);
                // 不返回密码
                user.setPassword(null);
                return Result.success(user);
            }
            return Result.error(401, "未授权");
        } catch (Exception e) {
            return Result.error(401, "Token无效");
        }
    }

    @PostMapping("/logout")
    public Result<String> logout() {
        return Result.success("退出成功");
    }

    @Data
    public static class LoginRequest {
        private String username;
        private String password;
    }
}
<template>
  <div class="login-container">
    <div class="login-box">
      <div class="login-header">
        <h2>酒店管理系统</h2>
        <p>Hotel Management System</p>
      </div>

      <el-form
        ref="loginForm"
        :model="loginForm"
        :rules="loginRules"
        class="login-form"
        auto-complete="on"
        label-position="left"
      >
        <el-form-item prop="username">
          <el-input
            ref="username"
            v-model="loginForm.username"
            placeholder="用户名"
            name="username"
            type="text"
            tabindex="1"
            auto-complete="on"
            prefix-icon="el-icon-user"
          />
        </el-form-item>

        <el-form-item prop="password">
          <el-input
            ref="password"
            v-model="loginForm.password"
            :type="passwordType"
            placeholder="密码"
            name="password"
            tabindex="2"
            auto-complete="on"
            prefix-icon="el-icon-lock"
            @keyup.enter.native="handleLogin"
          >
            <i
              slot="suffix"
              :class="passwordType === 'password' ? 'el-icon-view' : 'el-icon-view'"
              class="show-pwd"
              @click="showPwd"
            />
          </el-input>
        </el-form-item>

        <el-button
          :loading="loading"
          type="primary"
          style="width:100%;margin-bottom:30px;"
          @click.native.prevent="handleLogin"
        >
          登录
        </el-button>

        <div class="tips">
          <span>默认账号密码：</span>
          <span>admin / 123456</span>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
import authApi from '@/api/auth'

export default {
  name: 'Login',
  data () {
    return {
      loginForm: {
        username: 'admin',
        password: '123456'
      },
      loginRules: {
        username: [
          { required: true, message: '请输入用户名', trigger: 'blur' }
        ],
        password: [
          { required: true, message: '请输入密码', trigger: 'blur' },
          { min: 6, message: '密码长度不能少于6位', trigger: 'blur' }
        ]
      },
      loading: false,
      passwordType: 'password'
    }
  },
  methods: {
    showPwd () {
      if (this.passwordType === 'password') {
        this.passwordType = ''
      } else {
        this.passwordType = 'password'
      }
      this.$nextTick(() => {
        this.$refs.password.focus()
      })
    },
    handleLogin () {
      this.$refs.loginForm.validate(valid => {
        if (valid) {
          this.loading = true
          authApi.login(this.loginForm)
            .then(response => {
              if (response.code === 200) {
                this.$store.dispatch('login', {
                  user: response.data.user,
                  token: response.data.token
                })
                console.log('登录成功，数据已存储到sessionStorage')
                console.log('sessionStorage token:', sessionStorage.getItem('token'))
                this.$message.success('登录成功')
                this.$router.push('/')
              } else {
                this.$message.error(response.message || '登录失败')
              }
            })
            .catch(error => {
              this.$message.error(error.response?.data?.message || '登录失败')
            })
            .finally(() => {
              this.loading = false
            })
        }
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.login-container {
  min-height: 100vh;
  width: 100%;
  background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
  overflow: hidden;
  display: flex;
  justify-content: center;
  align-items: center;
}

.login-box {
  width: 400px;
  background: white;
  border-radius: 10px;
  padding: 40px;
  box-shadow: 0 15px 35px rgba(0, 0, 0, 0.1);
}

.login-header {
  text-align: center;
  margin-bottom: 40px;

  h2 {
    color: #333;
    margin-bottom: 10px;
    font-size: 28px;
    font-weight: bold;
  }

  p {
    color: #666;
    font-size: 14px;
  }
}

.login-form {
  .el-form-item {
    margin-bottom: 25px;
  }

  .el-input {
    height: 45px;

    input {
      height: 45px;
      border-radius: 5px;
    }
  }

  .el-button {
    height: 45px;
    border-radius: 5px;
    font-size: 16px;
  }
}

.show-pwd {
  cursor: pointer;
  user-select: none;
}

.tips {
  font-size: 14px;
  color: #999;
  text-align: center;

  span:first-child {
    margin-right: 16px;
  }
}
</style>

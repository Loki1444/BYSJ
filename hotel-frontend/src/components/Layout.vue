<template>
  <div class="app-wrapper">
    <div class="sidebar-container">
      <div class="sidebar-logo">
        <h3>酒店管理系统</h3>
      </div>
      <el-menu
        :default-active="$route.path"
        class="el-menu-vertical"
        background-color="#304156"
        text-color="#bfcbd9"
        active-text-color="#409EFF"
        router
      >
        <el-menu-item index="/dashboard">
          <i class="el-icon-s-home"></i>
          <span slot="title">仪表板</span>
        </el-menu-item>

        <el-menu-item index="/rooms">
          <i class="el-icon-s-shop"></i>
          <span slot="title">房间管理</span>
        </el-menu-item>

        <el-menu-item index="/orders">
          <i class="el-icon-s-order"></i>
          <span slot="title">订单管理</span>
        </el-menu-item>

        <el-menu-item index="/customers">
          <i class="el-icon-s-custom"></i>
          <span slot="title">客户管理</span>
        </el-menu-item>

        <el-menu-item index="/users">
          <i class="el-icon-user-solid"></i>
          <span slot="title">用户管理</span>
        </el-menu-item>
      </el-menu>
    </div>

    <div class="main-container">
      <div class="navbar">
        <div class="navbar-left">
          <span class="page-title">{{ $route.meta.title || '酒店管理系统' }}</span>
        </div>
        <div class="navbar-right">
          <el-dropdown @command="handleCommand">
            <span class="el-dropdown-link">
              <i class="el-icon-user-solid"></i>
              {{ currentUser?.realName || currentUser?.username }}
              <i class="el-icon-arrow-down el-icon--right"></i>
            </span>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="logout">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </div>

      <div class="app-main">
        <router-view />
      </div>
    </div>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'Layout',
  computed: {
    ...mapGetters(['currentUser'])
  },
  methods: {
    handleCommand (command) {
      if (command === 'logout') {
        this.$confirm('确定要退出登录吗？', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          this.$store.dispatch('logout')
          this.$router.push('/login')
          this.$message.success('退出成功')
        })
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.app-wrapper {
  display: flex;
  width: 100%;
  height: 100vh;
}

.sidebar-container {
  width: 210px;
  background-color: #304156;
  height: 100vh;
  position: fixed;
  font-size: 0px;
  top: 0;
  bottom: 0;
  left: 0;
  z-index: 1001;
  overflow: hidden;

  .sidebar-logo {
    height: 50px;
    line-height: 50px;
    background: #2b2f3a;
    text-align: center;
    overflow: hidden;

    h3 {
      color: #bfcbd9;
      font-weight: 600;
      font-size: 16px;
      margin: 0;
    }
  }

  .el-menu {
    border: none;
    height: 100%;
    width: 100% !important;
  }
}

.main-container {
  min-height: 100vh;
  margin-left: 210px;
  position: relative;
  display: flex;
  flex-direction: column;
}

.navbar {
  height: 50px;
  overflow: hidden;
  position: relative;
  background: #fff;
  box-shadow: 0 1px 4px rgba(0,21,41,.08);
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 0 20px;

  .navbar-left {
    .page-title {
      font-size: 18px;
      font-weight: 600;
      color: #333;
    }
  }

  .navbar-right {
    .el-dropdown-link {
      cursor: pointer;
      color: #333;
      font-size: 14px;

      i {
        margin: 0 5px;
      }
    }
  }
}

.app-main {
  flex: 1;
  padding: 20px;
  background: #f0f2f5;
  overflow-y: auto;
}
</style>

<template>
  <div class="user-management">
    <el-card>
      <div slot="header" class="clearfix">
        <span>用户管理</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="handleAdd">添加用户</el-button>
      </div>

      <el-table :data="tableData" style="width: 100%" v-loading="loading">
        <el-table-column prop="username" label="用户名" width="150"></el-table-column>
        <el-table-column prop="realName" label="真实姓名" width="150"></el-table-column>
        <el-table-column prop="phone" label="电话" width="150"></el-table-column>
        <el-table-column prop="email" label="邮箱" width="200"></el-table-column>
        <el-table-column prop="role" label="角色" width="120">
          <template slot-scope="scope">
            <el-tag :type="getRoleType(scope.row.role)">
              {{ getRoleText(scope.row.role) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="100">
          <template slot-scope="scope">
            <el-tag :type="scope.row.status === 1 ? 'success' : 'danger'">
              {{ scope.row.status === 1 ? '启用' : '禁用' }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="createdAt" label="创建时间" width="180"></el-table-column>
        <el-table-column label="操作" width="200">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" :type="scope.row.status === 1 ? 'warning' : 'success'" @click="handleToggleStatus(scope.row)">
              {{ scope.row.status === 1 ? '禁用' : '启用' }}
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'UserManagement',
  data () {
    return {
      loading: false,
      tableData: [
        {
          id: 1,
          username: 'admin',
          realName: '系统管理员',
          phone: '13800138000',
          email: 'admin@hotel.com',
          role: 'ADMIN',
          status: 1,
          createdAt: '2024-01-01 10:00:00'
        },
        {
          id: 2,
          username: 'manager',
          realName: '酒店经理',
          phone: '13800138001',
          email: 'manager@hotel.com',
          role: 'MANAGER',
          status: 1,
          createdAt: '2024-01-01 10:00:00'
        },
        {
          id: 3,
          username: 'staff',
          realName: '前台员工',
          phone: '13800138002',
          email: 'staff@hotel.com',
          role: 'STAFF',
          status: 1,
          createdAt: '2024-01-01 10:00:00'
        }
      ]
    }
  },
  methods: {
    getRoleType (role) {
      const typeMap = {
        ADMIN: 'danger',
        MANAGER: 'warning',
        STAFF: 'primary'
      }
      return typeMap[role] || 'primary'
    },
    getRoleText (role) {
      const textMap = {
        ADMIN: '管理员',
        MANAGER: '经理',
        STAFF: '员工'
      }
      return textMap[role] || role
    },
    handleAdd () {
      this.$message.info('添加用户功能开发中...')
    },
    handleEdit () {
      this.$message.info('编辑用户功能开发中...')
    },
    handleToggleStatus (row) {
      const action = row.status === 1 ? '禁用' : '启用'
      this.$confirm(`确定要${action}这个用户吗？`, '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        row.status = row.status === 1 ? 0 : 1
        this.$message.success(`${action}成功`)
      })
    }
  }
}
</script>

<style lang="scss" scoped>
.user-management {
  // 样式可以根据需要添加
}
</style>

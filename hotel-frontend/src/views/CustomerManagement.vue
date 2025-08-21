<template>
  <div class="customer-management">
    <el-card>
      <div slot="header" class="clearfix">
        <span>客户管理</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="handleAdd">添加客户</el-button>
      </div>

      <div class="search-area">
        <el-form :inline="true" :model="searchForm" class="search-form">
          <el-form-item label="客户姓名">
            <el-input v-model="searchForm.name" placeholder="请输入客户姓名" clearable></el-input>
          </el-form-item>
          <el-form-item label="电话号码">
            <el-input v-model="searchForm.phone" placeholder="请输入电话号码" clearable></el-input>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleSearch">查询</el-button>
            <el-button @click="handleReset">重置</el-button>
          </el-form-item>
        </el-form>
      </div>

      <el-table :data="tableData" style="width: 100%" v-loading="loading">
        <el-table-column prop="name" label="姓名" width="120"></el-table-column>
        <el-table-column prop="phone" label="电话" width="150"></el-table-column>
        <el-table-column prop="idCard" label="身份证号" width="180"></el-table-column>
        <el-table-column prop="email" label="邮箱" width="200"></el-table-column>
        <el-table-column prop="vipLevel" label="VIP等级" width="120">
          <template slot-scope="scope">
            <el-tag :type="getVipType(scope.row.vipLevel)">
              {{ getVipText(scope.row.vipLevel) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="totalConsumption" label="总消费" width="120">
          <template slot-scope="scope">
            ¥{{ scope.row.totalConsumption }}
          </template>
        </el-table-column>
        <el-table-column label="操作" width="200">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>

      <div class="pagination-container">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :current-page="pagination.page"
          :page-sizes="[10, 20, 50, 100]"
          :page-size="pagination.size"
          layout="total, sizes, prev, pager, next, jumper"
          :total="pagination.total">
        </el-pagination>
      </div>
    </el-card>
  </div>
</template>

<script>
export default {
  name: 'CustomerManagement',
  data () {
    return {
      loading: false,
      searchForm: {
        name: '',
        phone: ''
      },
      tableData: [
        {
          id: 1,
          name: '张三',
          phone: '13912345678',
          idCard: '320101199001011234',
          email: 'zhangsan@email.com',
          vipLevel: 'NORMAL',
          totalConsumption: 1580.00
        },
        {
          id: 2,
          name: '李四',
          phone: '13812345678',
          idCard: '320101199002021234',
          email: 'lisi@email.com',
          vipLevel: 'SILVER',
          totalConsumption: 3200.00
        }
      ],
      pagination: {
        page: 1,
        size: 10,
        total: 2
      }
    }
  },
  methods: {
    getVipType (level) {
      const typeMap = {
        NORMAL: '',
        SILVER: 'success',
        GOLD: 'warning',
        PLATINUM: 'danger'
      }
      return typeMap[level] || ''
    },
    getVipText (level) {
      const textMap = {
        NORMAL: '普通',
        SILVER: '银卡',
        GOLD: '金卡',
        PLATINUM: '白金'
      }
      return textMap[level] || level
    },
    handleSearch () {
      console.log('搜索', this.searchForm)
    },
    handleReset () {
      this.searchForm = { name: '', phone: '' }
    },
    handleAdd () {
      this.$message.info('添加客户功能开发中...')
    },
    handleEdit () {
      this.$message.info('编辑客户功能开发中...')
    },
    handleDelete () {
      this.$confirm('确定要删除这个客户吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$message.success('删除成功')
      })
    },
    handleSizeChange (val) {
      this.pagination.size = val
    },
    handleCurrentChange (val) {
      this.pagination.page = val
    }
  }
}
</script>

<style lang="scss" scoped>
.customer-management {
  .search-area {
    margin-bottom: 20px;
  }
  .pagination-container {
    margin-top: 20px;
    text-align: right;
  }
}
</style>

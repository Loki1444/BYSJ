<template>
  <div class="order-management">
    <el-card>
      <div slot="header" class="clearfix">
        <span>订单管理</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="handleAdd">新建订单</el-button>
      </div>

      <!-- 搜索区域 -->
      <div class="search-area">
        <el-form :inline="true" :model="searchForm" class="search-form">
          <el-form-item label="订单号">
            <el-input v-model="searchForm.orderNumber" placeholder="请输入订单号" clearable></el-input>
          </el-form-item>
          <el-form-item label="客户姓名">
            <el-input v-model="searchForm.customerName" placeholder="请输入客户姓名" clearable></el-input>
          </el-form-item>
          <el-form-item label="订单状态">
            <el-select v-model="searchForm.status" placeholder="请选择状态" clearable>
              <el-option label="待确认" value="PENDING"></el-option>
              <el-option label="已确认" value="CONFIRMED"></el-option>
              <el-option label="已入住" value="CHECKED_IN"></el-option>
              <el-option label="已退房" value="CHECKED_OUT"></el-option>
              <el-option label="已取消" value="CANCELLED"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item>
            <el-button type="primary" @click="handleSearch">查询</el-button>
            <el-button @click="handleReset">重置</el-button>
          </el-form-item>
        </el-form>
      </div>

      <!-- 表格区域 -->
      <el-table :data="tableData" style="width: 100%" v-loading="loading">
        <el-table-column prop="orderNumber" label="订单号" width="150"></el-table-column>
        <el-table-column prop="customerName" label="客户姓名" width="120"></el-table-column>
        <el-table-column prop="roomNumber" label="房间号" width="100"></el-table-column>
        <el-table-column prop="checkInDate" label="入住日期" width="120"></el-table-column>
        <el-table-column prop="checkOutDate" label="退房日期" width="120"></el-table-column>
        <el-table-column prop="totalAmount" label="总金额" width="120">
          <template slot-scope="scope">
            ¥{{ scope.row.totalAmount }}
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="120">
          <template slot-scope="scope">
            <el-tag :type="getStatusType(scope.row.status)">
              {{ getStatusText(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column label="操作" width="250">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleView(scope.row)">查看</el-button>
            <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleCancel(scope.row)" v-if="scope.row.status === 'PENDING' || scope.row.status === 'CONFIRMED'">取消</el-button>
          </template>
        </el-table-column>
      </el-table>

      <!-- 分页 -->
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
  name: 'OrderManagement',
  data () {
    return {
      loading: false,
      searchForm: {
        orderNumber: '',
        customerName: '',
        status: ''
      },
      tableData: [
        {
          id: 1,
          orderNumber: 'HO20241201001',
          customerName: '张三',
          roomNumber: '101',
          checkInDate: '2024-12-01',
          checkOutDate: '2024-12-03',
          totalAmount: 376.00,
          status: 'CONFIRMED'
        },
        {
          id: 2,
          orderNumber: 'HO20241201002',
          customerName: '李四',
          roomNumber: '205',
          checkInDate: '2024-12-01',
          checkOutDate: '2024-12-02',
          totalAmount: 488.00,
          status: 'CHECKED_IN'
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
    getStatusType (status) {
      const statusMap = {
        PENDING: 'warning',
        CONFIRMED: 'primary',
        CHECKED_IN: 'success',
        CHECKED_OUT: 'info',
        CANCELLED: 'danger'
      }
      return statusMap[status] || 'info'
    },
    getStatusText (status) {
      const statusMap = {
        PENDING: '待确认',
        CONFIRMED: '已确认',
        CHECKED_IN: '已入住',
        CHECKED_OUT: '已退房',
        CANCELLED: '已取消'
      }
      return statusMap[status] || status
    },
    handleSearch () {
      console.log('搜索', this.searchForm)
    },
    handleReset () {
      this.searchForm = {
        orderNumber: '',
        customerName: '',
        status: ''
      }
    },
    handleAdd () {
      this.$message.info('新建订单功能开发中...')
    },
    handleView () {
      this.$message.info('查看订单功能开发中...')
    },
    handleEdit () {
      this.$message.info('编辑订单功能开发中...')
    },
    handleCancel () {
      this.$confirm('确定要取消这个订单吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$message.success('订单已取消')
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
.order-management {
  .search-area {
    margin-bottom: 20px;

    .search-form {
      .el-form-item {
        margin-bottom: 0;
      }
    }
  }

  .pagination-container {
    margin-top: 20px;
    text-align: right;
  }
}
</style>

<template>
  <div class="room-management">
    <el-card>
      <div slot="header" class="clearfix">
        <span>房间管理</span>
        <el-button style="float: right; padding: 3px 0" type="text" @click="handleAdd">添加房间</el-button>
      </div>

      <!-- 搜索区域 -->
      <div class="search-area">
        <el-form :inline="true" :model="searchForm" class="search-form">
          <el-form-item label="房间号">
            <el-input v-model="searchForm.roomNumber" placeholder="请输入房间号" clearable></el-input>
          </el-form-item>
          <el-form-item label="房间状态">
            <el-select v-model="searchForm.status" placeholder="请选择状态" clearable>
              <el-option label="可用" value="AVAILABLE"></el-option>
              <el-option label="已入住" value="OCCUPIED"></el-option>
              <el-option label="维护中" value="MAINTENANCE"></el-option>
              <el-option label="清洁中" value="CLEANING"></el-option>
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
        <el-table-column prop="roomNumber" label="房间号" width="120"></el-table-column>
        <el-table-column prop="roomTypeName" label="房型" width="150"></el-table-column>
        <el-table-column prop="floor" label="楼层" width="80"></el-table-column>
        <el-table-column prop="basePrice" label="基础价格" width="120">
          <template slot-scope="scope">
            ¥{{ scope.row.basePrice }}
          </template>
        </el-table-column>
        <el-table-column prop="status" label="状态" width="120">
          <template slot-scope="scope">
            <el-tag :type="getStatusType(scope.row.status)">
              {{ getStatusText(scope.row.status) }}
            </el-tag>
          </template>
        </el-table-column>
        <el-table-column prop="description" label="描述" show-overflow-tooltip></el-table-column>
        <el-table-column label="操作" width="200">
          <template slot-scope="scope">
            <el-button size="mini" @click="handleEdit(scope.row)">编辑</el-button>
            <el-button size="mini" type="danger" @click="handleDelete(scope.row)">删除</el-button>
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
  name: 'RoomManagement',
  data () {
    return {
      loading: false,
      searchForm: {
        roomNumber: '',
        status: ''
      },
      tableData: [
        {
          id: 1,
          roomNumber: '101',
          roomTypeName: '标准单人间',
          floor: 1,
          basePrice: 188.00,
          status: 'AVAILABLE',
          description: '舒适的单人间'
        },
        {
          id: 2,
          roomNumber: '102',
          roomTypeName: '标准单人间',
          floor: 1,
          basePrice: 188.00,
          status: 'AVAILABLE',
          description: '舒适的单人间'
        },
        {
          id: 3,
          roomNumber: '106',
          roomTypeName: '标准双人间',
          floor: 1,
          basePrice: 268.00,
          status: 'OCCUPIED',
          description: '宽敞的双人间'
        }
      ],
      pagination: {
        page: 1,
        size: 10,
        total: 3
      }
    }
  },
  methods: {
    getStatusType (status) {
      const statusMap = {
        AVAILABLE: 'success',
        OCCUPIED: 'warning',
        MAINTENANCE: 'danger',
        CLEANING: 'info'
      }
      return statusMap[status] || 'info'
    },
    getStatusText (status) {
      const statusMap = {
        AVAILABLE: '可用',
        OCCUPIED: '已入住',
        MAINTENANCE: '维护中',
        CLEANING: '清洁中'
      }
      return statusMap[status] || status
    },
    handleSearch () {
      // 实现搜索逻辑
      console.log('搜索', this.searchForm)
    },
    handleReset () {
      this.searchForm = {
        roomNumber: '',
        status: ''
      }
    },
    handleAdd () {
      this.$message.info('添加房间功能开发中...')
    },
    handleEdit (row) {
      this.$message.info('编辑房间功能开发中...')
    },
    handleDelete (row) {
      this.$confirm('确定要删除这个房间吗？', '提示', {
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
.room-management {
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

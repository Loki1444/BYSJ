<template>
  <div class="dashboard">
    <el-row :gutter="20" class="stats-row">
      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background: #409EFF;">
            <i class="el-icon-s-shop"></i>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.totalRooms }}</div>
            <div class="stat-label">总房间数</div>
          </div>
        </div>
      </el-col>

      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background: #67C23A;">
            <i class="el-icon-success"></i>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.availableRooms }}</div>
            <div class="stat-label">可用房间</div>
          </div>
        </div>
      </el-col>

      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background: #E6A23C;">
            <i class="el-icon-s-order"></i>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.todayOrders }}</div>
            <div class="stat-label">今日订单</div>
          </div>
        </div>
      </el-col>

      <el-col :span="6">
        <div class="stat-card">
          <div class="stat-icon" style="background: #F56C6C;">
            <i class="el-icon-s-custom"></i>
          </div>
          <div class="stat-content">
            <div class="stat-number">{{ stats.totalCustomers }}</div>
            <div class="stat-label">客户总数</div>
          </div>
        </div>
      </el-col>
    </el-row>

    <el-row :gutter="20" class="content-row">
      <el-col :span="24">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>最近订单</span>
          </div>
          <el-table :data="recentOrders" style="width: 100%">
            <el-table-column prop="orderNumber" label="订单号" width="120"></el-table-column>
            <el-table-column prop="customerName" label="客户" width="100"></el-table-column>
            <el-table-column prop="roomNumber" label="房间" width="80"></el-table-column>
            <el-table-column prop="status" label="状态">
              <template slot-scope="scope">
                <el-tag :type="getStatusType(scope.row.status)">
                  {{ getStatusText(scope.row.status) }}
                </el-tag>
              </template>
            </el-table-column>
          </el-table>
        </el-card>
      </el-col>

      <el-col :span="24">
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>房间状态分布</span>
          </div>
          <div class="room-status-chart">
            <div class="status-item">
              <div class="status-color available"></div>
              <span>可用: {{ roomStatus.available }}</span>
            </div>
            <div class="status-item">
              <div class="status-color occupied"></div>
              <span>已入住: {{ roomStatus.occupied }}</span>
            </div>
            <div class="status-item">
              <div class="status-color maintenance"></div>
              <span>维护中: {{ roomStatus.maintenance }}</span>
            </div>
            <div class="status-item">
              <div class="status-color cleaning"></div>
              <span>清洁中: {{ roomStatus.cleaning }}</span>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: 'Dashboard',
  data () {
    return {
      stats: {
        totalRooms: 16,
        availableRooms: 12,
        todayOrders: 8,
        totalCustomers: 156
      },
      recentOrders: [
        {
          orderNumber: 'HO20241201001',
          customerName: '张三',
          roomNumber: '101',
          status: 'CONFIRMED'
        },
        {
          orderNumber: 'HO20241201002',
          customerName: '李四',
          roomNumber: '205',
          status: 'CHECKED_IN'
        },
        {
          orderNumber: 'HO20241201003',
          customerName: '王五',
          roomNumber: '301',
          status: 'PENDING'
        }
      ],
      roomStatus: {
        available: 12,
        occupied: 2,
        maintenance: 1,
        cleaning: 1
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
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard {
  .stats-row {
    margin-bottom: 20px;
  }

  .stat-card {
    background: white;
    border-radius: 8px;
    padding: 20px;
    display: flex;
    align-items: center;
    box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);

    .stat-icon {
      width: 60px;
      height: 60px;
      border-radius: 50%;
      display: flex;
      align-items: center;
      justify-content: center;
      margin-right: 20px;

      i {
        font-size: 24px;
        color: white;
      }
    }

    .stat-content {
      .stat-number {
        font-size: 32px;
        font-weight: bold;
        color: #333;
        line-height: 1;
      }

      .stat-label {
        font-size: 14px;
        color: #666;
        margin-top: 5px;
      }
    }
  }

  .content-row {
    .box-card {
      height: 400px;

      .room-status-chart {
        padding: 20px 0;

        .status-item {
          display: flex;
          align-items: center;
          margin-bottom: 15px;

          .status-color {
            width: 16px;
            height: 16px;
            border-radius: 50%;
            margin-right: 10px;

            &.available {
              background-color: #67C23A;
            }

            &.occupied {
              background-color: #E6A23C;
            }

            &.maintenance {
              background-color: #F56C6C;
            }

            &.cleaning {
              background-color: #909399;
            }
          }

          span {
            font-size: 14px;
            color: #333;
          }
        }
      }
    }
  }
}
</style>

import Vue from 'vue'
import VueRouter from 'vue-router'
import Login from '../views/Login.vue'
import Layout from '../components/Layout.vue'
import Dashboard from '../views/Dashboard.vue'
import RoomManagement from '../views/RoomManagement.vue'
import OrderManagement from '../views/OrderManagement.vue'
import CustomerManagement from '../views/CustomerManagement.vue'
import UserManagement from '../views/UserManagement.vue'

Vue.use(VueRouter)

const routes = [
  {
    path: '/login',
    name: 'Login',
    component: Login
  },
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    children: [
      {
        path: 'dashboard',
        name: 'Dashboard',
        component: Dashboard,
        meta: { title: '仪表板' }
      },
      {
        path: 'rooms',
        name: 'RoomManagement',
        component: RoomManagement,
        meta: { title: '房间管理' }
      },
      {
        path: 'orders',
        name: 'OrderManagement',
        component: OrderManagement,
        meta: { title: '订单管理' }
      },
      {
        path: 'customers',
        name: 'CustomerManagement',
        component: CustomerManagement,
        meta: { title: '客户管理' }
      },
      {
        path: 'users',
        name: 'UserManagement',
        component: UserManagement,
        meta: { title: '用户管理' }
      }
    ]
  }
]

const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const token = sessionStorage.getItem('token')
  if (to.path !== '/login' && !token) {
    next('/login')
  } else if (to.path === '/login' && token) {
    next('/')
  } else {
    next()
  }
})

export default router

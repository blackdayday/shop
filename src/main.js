import Vue from 'vue'
import App from './App.vue'
import router from './router'
import store from './store'

Vue.config.productionTip = false

import axios from 'axios'
Vue.prototype.$axios = axios

import ElementUI from 'element-ui'
import "element-ui/lib/theme-chalk/index.css"
import 'element-ui/lib/theme-chalk/display.css';
Vue.use(ElementUI)

import './style/common.css'

axios.defaults.baseURL = "http://localhost:8088"

new Vue({
  router,
  store,
  render: h => h(App)
}).$mount('#app')

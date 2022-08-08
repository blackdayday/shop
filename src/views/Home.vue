<template>
  <div class="home">
    <el-container>
      <el-header>
        <div class="logo" @click="goHome()">闲置易换平台</div>
        <div class="search">
          <el-input
            prefix-icon="el-icon-search"
            placeholder="搜索商品"
            v-model="input"
            @keyup.enter.native="search"
          ></el-input>
        </div>
        <div class="user-info">
          <!-- 添加按钮和收藏夹 -->
          <div class="bookmark">
            <el-button
              type="primary"
              icon="el-icon-plus"
              circle
              @click="addGoodsBtn()"
            ></el-button>
            <el-button
              type="warning"
              icon="el-icon-truck"
              circle
              @click="myGoodsBtn()"
            ></el-button>
            <el-button
              type="warning"
              icon="el-icon-star-off"
              circle
              @click="bookmarkBtn()"
            ></el-button>
          </div>
          <el-dropdown @command="handleCommand">
            <div class="avatar">
              <img v-if="!isLogin" src="../assets/avatar.png" alt="" />
              <img v-else :src="user.uImg" alt="" />
            </div>
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item command="toCenter"
                >账户：{{ user.username }}</el-dropdown-item
              >
              <el-dropdown-item command="toCenter">更多信息</el-dropdown-item>
              <el-dropdown-item v-if="isLogin == true" command="logout" divided
                >退出登录</el-dropdown-item
              >
              <el-dropdown-item v-else command="login" divided
                >登录</el-dropdown-item
              >
            </el-dropdown-menu>
          </el-dropdown>
        </div>
      </el-header>
      <!-- 路由嵌套 -->
      <router-view />
      <el-footer height="200px">
        <div>Copyright © 2022 闲置易换系统</div>
        <div class="link">
          <div @click="toAdmin">管理员页面</div>
          &nbsp;&nbsp;|&nbsp;&nbsp;
          <div>官方微博</div>
        </div>
        <div style="font-size: 12px">通信地址：广东省肇庆市端州区肇庆学院</div>
      </el-footer>
    </el-container>
  </div>
</template>
<script>
export default {
  data() {
    return {
      isLogin: false,
      user: {
        uid: this.$store.getters.getUserId,
        username: this.$store.getters.getUserName,
        uImg: this.$store.getters.getUImg,
      },
      input: "",
    };
  },
  methods: {
    goHome(){
      this.$router.push("/allGoods");
    },
    //处理下拉菜单的方法
    handleCommand(command) {
      if (command == "toCenter") {
        //“更多信息”点击事件：跳转到个人中心页
        this.$router.push("/center");
      }
      if (command == "login") {
        //“更多信息”点击事件：跳转到个人中心页
        this.$router.push("/login");
      }
      if (command == "logout") {
        this.$store.commit("setToken", ""); //token设为空字符串
        this.$store.commit("setUserName", "");
        this.$store.commit("setUImg", "");
        this.$store.commit('setRole', "");
        this.$router.push("/");
        this.$message({
          message: "已退出登录",
          type: "success",
        });
      }
    },
    //搜索
    search() {
      console.log(this.input);
      this.$router.push({
        path: "/search",
        query: {
          input: this.input,
        },
      });
    },
    //添加商品按钮
    addGoodsBtn() {
      this.$router.push("/addGoods");
    },
    myGoodsBtn() {
      this.$router.push("/myGoods");
    },
    //我的收藏按钮
    bookmarkBtn() {
      this.$router.push("/bookmark");
    },
    //----footer-----
    //跳转管理员页面
    toAdmin() {
      const role=this.$store.getters.getRole;
      console.log(this.$store.getters.getRole);
      if (role == "普通用户") {
        this.$message({
          type: "error",
          message: "你不是管理员！",
        });
      }else if(this.$store.getters.getRole ==""){
        this.$message({
          type: "error",
          message: "请先登录！",
        });
      }else{
        this.$router.push("/admin");
        this.$message({
          type: "success",
          message: "欢迎来到管理员页面",
        });        
      }
    },
  },
  created() {
   
    if (
      this.$store.getters.getToken != null &&
      this.$store.getters.getToken != ""
    ) {
      this.isLogin = true;
    }
  },
};
</script>
<style scoped>
.el-input >>> .el-input__inner {
  /* background-color: rgba(255, 255, 255, 0.4); */
  border: 0;
}
el-input {
  outline: none;
}
.el-header {
  padding: 0;
  display: flex;
  background-color: var(--primary-color);
}
.el-header .logo {
  flex: 1;
  color: #fff;
  line-height: 60px;
  font-size: 24px;
  letter-spacing: 1px;
  user-select: none;
  margin-left: 10px;
  font-family: "Yuanti SC", Youyuan, "You Yuan", 幼圆, "PingFang SC",
    "Microsoft Yahei", Helvetica, sans-serif;
}
.el-header .search {
  flex: 1;
  display: flex;
  align-items: center;
}
.el-header .user-info {
  flex: 1;
  display: flex;
  justify-content: flex-end;
}
.el-header .user-info .bookmark {
  width: 180px;
  line-height: 60px;
  text-align: center;
  color: #fff;
  font-weight: 500;
  cursor: pointer;
  display: flex;
  justify-content: center;
  align-items: center;
}
.el-header .user-info .avatar {
  margin: 10px 24px 10px 0;
  width: 40px;
  height: 40px;
  border-radius: 20px;
  background-color: rgb(185, 185, 185);
  cursor: pointer;
  overflow: hidden;
}
.el-header .user-info .avatar img {
  width: 100%;
}
.el-footer {
  background-color: var(--primary-color);
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  line-height: 200%;
}
.link {
  display: flex;
  justify-content: center;
  font-size: small;
}
.link div {
  cursor: pointer;
}
.link div:hover {
  color: #f1c40f;
}
</style>
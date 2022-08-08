<template>
  <div class="login">
    <div class="index">
      <div class="picture hidden-sm-and-down">
        <div class="title">闲置易换平台</div>
        <img src="../assets/shopping.png" />
      </div>
      <div class="menu">
        <div class="title-small hidden-md-and-up">闲置易换平台</div>
        <el-card class="box-card">
          <div slot="header" class="clearfix">
            <span>{{ isRegisterBtnClick == false ? "登录" : "注册" }}</span>
            <el-button
              @click="registerBtn()"
              style="float: right; padding: 3px 0"
              type="text"
              >{{
                isRegisterBtnClick == false ? "注册" : "返回登录"
              }}</el-button
            >
          </div>
          <!-- 登录面板 -->
          <el-form
            :model="user"
            label-width="60px"
            v-if="isRegisterBtnClick == false"
          >
            <el-form-item label="用户名">
              <el-input
                v-model="user.userName"
                placeholder="请输入用户名"
              ></el-input>
            </el-form-item>
            <el-form-item label="密码">
              <el-input
                v-model="user.password"
                placeholder="请输入密码"
                type="password"
                show-password
              ></el-input>
            </el-form-item>
            <!-- 验证码功能，待开启 -->
            <!-- <el-form-item label="验证码">
              <el-input
                v-model="user.verification"
                placeholder="请输入验证码"
              ></el-input>
            </el-form-item> -->
            <div class="option">
              <el-button type="primary" style="width: 120px" @click="login()"
                >登录</el-button
              >
              <!-- 待开启功能：忘记密码 -->
              <!-- <router-link to="/lostPwd">忘记密码</router-link> -->
            </div>
          </el-form>
          <!-- 注册面板 -->
          <el-form
            :model="user"
            label-width="60px"
            v-if="isRegisterBtnClick == true"
          >
            <el-form-item label="用户名">
              <el-input
                v-model="newUser.userName"
                placeholder="请输入用户名"
              ></el-input>
            </el-form-item>
            <el-form-item label="密码">
              <el-input
                v-model="newUser.password"
                placeholder="请输入密码"
                type="password"
                show-password
              ></el-input>
            </el-form-item>
            <el-form-item label="确认">
              <el-input
                v-model="newUser.confirmPwd"
                placeholder="请再次输入密码"
                type="password"
                show-password
              ></el-input>
            </el-form-item>
            <!-- 验证码功能，待开启 -->
            <!-- <el-form-item label="验证码">
              <el-input
                v-model="user.verification"
                placeholder="请输入验证码"
              ></el-input>
            </el-form-item> -->
            <div class="option">
              <el-button type="primary" style="width: 120px" @click="register()"
                >注册</el-button
              >
            </div>
          </el-form>
        </el-card>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      isRegisterBtnClick: false, //注册按钮是否被点击（是否切换到注册面板）
      user: {
        userName: "",
        password: "",
        // verification: "",//验证码功能，待开启
      },
      newUser: {
        userName: "",
        password: "",
        confirmPwd: "",
      },
    };
  },
  methods: {
    //登录功能
    login() {
      this.$axios
        .post("/log-or-reg/login", this.user)
        .then((res) => {
          if (res.data.flag == true) {
            this.$store.commit("setToken", res.data.data.token);
            this.$store.commit("setUserId", res.data.data.user.userId);
            this.$store.commit("setUserName", res.data.data.user.userName);
            this.$store.commit("setUImg", res.data.data.user.avatar);
            this.$store.commit("setRole", res.data.data.user.role);
            this.$router.push("/");
            this.$message({
              type: "success",
              message: "欢迎来到闲置易换平台",
            });
          } else {
            this.$message.error("密码错误或账号不存在");
          }
        })
        .catch(() => {
          this.$message.error("服务器繁忙，请稍后再试");
        });
    },
    //点击注册按钮事件（切换到注册）
    registerBtn() {
      this.isRegisterBtnClick = !this.isRegisterBtnClick;
    },
    //注册功能
    register() {
      if (this.newUser.password == this.newUser.confirmPwd) {
        this.$axios.post("/log-or-reg/register", this.newUser).then((res) => {
          if (res.data.flag == true) {
            //后端返回状态码200意为成功
            this.$message({
              message: "注册成功",
              type: "success",
            });
            this.registerBtn(); //调用方法转到登录面板
            //帮助用户填好登录信息
            this.user.userName = this.newUser.userName;
            this.user.password = this.newUser.password;
          } else {
            //注册失败
            this.$message.error("注册失败，用户名已存在");
          }
        });
      } else {
        this.$message.error("两次输入的密码不一致！");
      }
    },
  },
  // created() {
  //   console.log("登录页token值：", localStorage.getItem("token"));
  // },
};
</script>

<style scoped>
.login {
  height: 100vh;
  display: flex;
  justify-content: center;
  align-items: center;
}
.index {
  width: 1000px;
  height: 500px;
  display: flex;
  justify-content: center;
}
.picture {
  width: calc(100% - 400px);
  height: 100%;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.title {
  text-align: center;
  font-size: 36px;
  user-select: none;
  letter-spacing: 2px;
}
.title-small {
  text-align: center;
  font-size: 30px;
  user-select: none;
  letter-spacing: 2px;
  margin: 10px 0;
}
.picture img {
  height: 80%;
}
.menu {
  width: 400px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}
/* 卡片 */
.el-card {
  width: 60px;
}
.text {
  font-size: 14px;
}
.item {
  margin-bottom: 18px;
}
.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}
.clearfix:after {
  clear: both;
}
.box-card {
  width: 100%;
}
/* ---结束卡片---- */
.option {
  display: flex;
  justify-content: space-evenly;
  align-items: center;
  font-size: small;
}
</style>
<template>
  <div class="center">
    <el-page-header @back="goBack" content="个人信息"> </el-page-header>
    <div class="header">
      <div class="avatar header-item">
        <div>
          <el-upload
            :style="styleChange()"
            class="avatar"
            action="http://localhost:8088/product/upload-imgs"
            name="img"
            :headers="header"
            :show-file-list="false"
            :auto-upload="true"
            :on-success="handleAvatarSuccess"
          >
            <img v-if="imageUrl" :src="imageUrl" class="avatar" />
            <i v-else class="el-icon-plus avatar-uploader-icon"></i>
          </el-upload>
        </div>
      </div>
    </div>
    <div class="body">
      <div class="body-item">
        <span>用户名：</span>
        <el-input
          placeholder="请输入内容"
          v-model="user.userName"
          :disabled="!boolean"
        >
        </el-input>
      </div>
      <div class="body-item">
        <span>个性签名：</span>
        <el-input
          placeholder="请输入内容"
          v-model="user.sign"
          :disabled="!boolean"
        >
        </el-input>
      </div>
      <div class="body-item">
        <span>手机号码：</span>
        <el-input
          placeholder="请输入内容"
          v-model="user.mobilePhone"
          :disabled="!boolean"
        >
        </el-input>
      </div>
      <div class="body-item">
        <span>邮箱地址：</span>
        <el-input
          placeholder="请输入内容"
          v-model="user.email"
          :disabled="!boolean"
        >
        </el-input>
      </div>
      <div class="body-item">
        <span>注册时间：</span>
        <el-input placeholder="请输入内容" v-model="user.createTime" disabled>
        </el-input>
      </div>
      <div class="body-item" style="display: flex">
        <el-button @click="isEdit()">{{ boolean ? "返回" : "编辑" }}</el-button>
        <el-button @click="update()" v-show="boolean">提交</el-button>
        <el-button
          @click="dialogFormVisible2 = true"
          type="primary"
          style="margin-left: 16px"
        >
          修改密码
        </el-button>

        <el-button
          @click="showAddress()"
          type="primary"
          style="margin-left: 16px"
        >
          收货信息
        </el-button>

        <el-drawer title="收货地址信息" :visible.sync="drawer" size="50%">
          <el-button
            type="primary"
            plain
            icon="el-icon-plus"
            @click="dialogFormVisible1 = true"
          ></el-button>

          <el-table :data="addressData">
            <el-table-column
              prop="receiver"
              label="收货人"
              width="150"
            ></el-table-column>
            <el-table-column
              property="phone"
              label="电话"
              width="200"
            ></el-table-column>
            <el-table-column
              property="slimAddress"
              label="收货地址"
            ></el-table-column>
            <el-table-column label="操作">
              <template slot-scope="scope">
                <el-button
                  @click="handleClick(scope.row)"
                  type="text"
                  size="small"
                  >编辑</el-button
                >
                <el-button
                  type="text"
                  @click="delAddress(scope.$index, addressData)"
                  size="small"
                  >移除</el-button
                >
              </template>
            </el-table-column>

            <el-table-column>
              <template slot-scope="prop">
                <span v-show="prop.row.defaultAddress == true">默认地址</span>
              </template>
            </el-table-column>
          </el-table>
        </el-drawer>
      </div>
    </div>
    <el-dialog title="新增地址" :visible.sync="dialogFormVisible1">
      <el-form :model="form1">
        <el-form-item label="收货人" :label-width="formLabelWidth">
          <el-input v-model="form1.receiver" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话" :label-width="formLabelWidth">
          <el-input v-model="form1.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="详细地址" :label-width="formLabelWidth">
          <el-input v-model="form1.slimAddress"></el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-checkbox v-model="form1.defaultAddress">设为默认</el-checkbox>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible1 = false;form1={}">取 消</el-button>
        <el-button type="primary" @click="addAddress()">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="收货地址" :visible.sync="dialogFormVisible">
      <el-form :model="form">
        <el-form-item label="收货人" :label-width="formLabelWidth">
          <el-input v-model="form.receiver" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="电话" :label-width="formLabelWidth">
          <el-input v-model="form.phone" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="详细地址" :label-width="formLabelWidth">
          <el-input v-model="form.slimAddress"></el-input>
        </el-form-item>
        <el-form-item style="text-align: right">
          <el-checkbox v-model="form.defaultAddress">设为默认</el-checkbox>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button
          @click="
            dialogFormVisible = false;
            form.defaultAddress = false;
          "
          >取 消</el-button
        >
        <el-button type="primary" @click="updateAddress()">确 定</el-button>
      </div>
    </el-dialog>

    <el-dialog title="修改密码" :visible.sync="dialogFormVisible2">
      <el-form :model="form2">
        <el-form-item label="原密码" :label-width="formLabelWidth">
          <el-input type="password" v-model="form2.oldPassword" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="新密码" :label-width="formLabelWidth">
          <el-input show-password type="password" v-model="form2.newPassword" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="确认新密码" :label-width="formLabelWidth">
          <el-input show-password type="password" v-model="form2.confirmPwd"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button
          @click="
            dialogFormVisible2 = false;
            form2={};
          "
          >取 消</el-button
        >
        <el-button type="primary" @click="updatePwdBtn()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
export default {
  data() {
    return {
      formLabelWidth: "120px",
      form2:{},
      form: {},
      form1: {},
      addressData: [],
      dialogFormVisible: false,
      dialogFormVisible1: false,
      dialogFormVisible2: false,
      drawer: false,
      imageUrl: "",
      header: { token: this.$store.getters.getToken },
      user: {},
      userInfo: {},
      boolean: false,
    };
  },
  methods: {
    addAddress() {
      this.form1.userId=this.$store.getters.getUserId;
      this.$axios
        .post("/user/add-address", this.form1, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.flag == true) {
            this.dialogFormVisible1 = false;
            this.addressData.push(this.form1);
            this.form1={};
            this.$message({
              message: "新增成功",
              type: "success",
            });
          }
        });
    },
    updateAddress() {
      this.dialogFormVisible = false;
      this.$axios
        .post("/user/update-address", this.form, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.flag == true) {
            this.$message({
              message: "修改成功",
              type: "success",
            });
            this.$router.go(0);
          }
        });
    },
    delAddress(index, rows) {
      this.$axios
        .get("/user/del-address/" + rows[index].addressId, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.flag == true) {
            this.$message({
              message: "删除成功",
              type: "success",
            });
            rows.splice(index, 1);
          }
        });
    },
    handleClick(row) {
      this.dialogFormVisible = true;
      this.form = row;
      console.log(row);
    },
    showAddress() {
      this.drawer = true;
      this.$axios
        .get("/user/find-address/" + this.$store.getters.getUserId, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          this.addressData = res.data.data;
          console.log(this.addressData);
        });
    },
    styleChange() {
      return this.imageUrl ? "" : "padding:75px";
    },
    handleAvatarSuccess(res, file) {
      console.log(res);
      this.imageUrl = URL.createObjectURL(file.raw);
      this.userInfo.avatar = res;
      this.userInfo.userId = this.$store.getters.getUserId;
      this.$axios
        .post("/user/update-userinfo", this.userInfo, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          console.log(res);
        });
    },
    goBack() {
      this.$router.push("/allGoods");
    },
    getFile: function (event) {
      this.file = event.target.files[0];
      console.log("getFile", this.file);
    },
    submitUpload() {
      this.$refs.upload.submit();
    },
    update() {
      this.user.userId = this.$store.getters.getUserId;
      console.log("获取到了user信息", this.user);
      this.$axios
        .post("/user/update-userinfo", this.user, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.flag == true) {
            this.$message({
              message: "修改成功",
              type: "success",
            });
          }
        });
    },
    updatePwdBtn() {
      if(this.form2.newPassword==this.form2.confirmPwd){
      this.$axios
        .get("/user/updatePassword",{
           params: {
            userName: this.user.userName,
            oldPwd: this.form2.oldPassword,
            newPwd: this.form2.newPassword,
          },
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.status == 202) {
            this.$message.error("修改密码失败，原密码不正确");
          } else if (res.data.status == 201) {
            this.$message.error("修改密码失败，系统繁忙");
          }else{
            this.$message.success("修改密码成功");
            this.dialogFormVisible2=false;
            this.form2={};
          }
        });
      }else{
        this.$message.error("两次输入的密码不一致！");
      }
      
    },
    isEdit() {
      this.boolean = !this.boolean;
    },
    backEdit() {},
  },
  created() {
    let uid = this.$store.getters.getUserId;
    this.$axios
      .get("/user/user-info/" + uid, {
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        this.user = res.data.data;
        this.imageUrl = res.data.data.avatar;
        console.log("this.user", this.user);
      });
  },
};
</script>
<style scoped>
.center {
  /* background: url("~@/assets/bg2.png");  */
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 1000px;
  background-color: #fff;
}
.header {
  width: 1200px auto;
  height: 200px auto;
  display: flex;
  margin: 20px auto;
  justify-content: center;
  align-items: center;
  background-color: purple;
}
.body {
  width: 1200px auto;
  height: 200px;
  /* background-color: red; */
  display: flex;
  flex-direction: column;
}
.header-item {
  margin: 0 2%;

  align-items: center;
  justify-content: center;
}
.body-item {
  margin: 10px auto 10px 400px;
  /* display: flex;
  justify-content: center; */
}
.header .avatar {
  background-color: rgb(187, 187, 187);
  width: 200px;
  height: 200px;
  border-radius: 100px;
  overflow: hidden;
}
.header .avatar img {
  width: 100%;
}

.avatar-uploader .el-upload {
  border: 1px dashed #d9d9d9;
  border-radius: 6px;
  cursor: pointer;
  position: relative;
  overflow: hidden;
}
.avatar-uploader .el-upload:hover {
  border-color: #409eff;
}
.avatar-uploader-icon {
  font-size: 28px;
  color: #8c939d;
  width: 50px;
  height: 50px;
  line-height: 50px;
  text-align: center;
}
.avatar {
  border-radius: 100px;
  width: 200px;
  height: 200px;
  display: block;
}
</style>
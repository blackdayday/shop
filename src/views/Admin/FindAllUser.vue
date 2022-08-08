<template>
  <div>
    <div class="keySelect">
      <el-input
        placeholder="请输入用户名关键字"
        v-model="key"
        class="input-with-select"
      >
        <el-button
          slot="append"
          icon="el-icon-search"
          @click="selectByKey()"
        ></el-button>
      </el-input>
    </div>
    <el-table :data="tableData" border style="width: 100%">
      <el-table-column prop="userId" label="用户Id" width="120" align="center">
      </el-table-column>
      <el-table-column
        prop="userName"
        label="用户名"
        width="120"
        align="center"
      >
      </el-table-column>
      <el-table-column
        prop="sign"
        label="个性签名"
        width="280"
        align="center"
        show-overflow-tooltip
      >
      </el-table-column>
      <el-table-column prop="sex" label="性别" width="100" align="center">
      </el-table-column>
      <el-table-column
        prop="mobilePhone"
        label="手机"
        width="160"
        align="center"
      >
      </el-table-column>
      <el-table-column prop="email" label="邮箱" width="180" align="center">
      </el-table-column>
      <el-table-column
        prop="createtime"
        label="注册时间"
        width="200"
        align="center"
      >
      </el-table-column>
      <el-table-column prop="role" label="角色" width="150" align="center">
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="155" align="center">
        <template slot-scope="scope">
          <el-button
            v-if="scope.row.role == '普通用户' && scope.row.userStatus == 1"
            @click="updateStatus(scope.row, 0)"
            type="primary"
            size="small"
            >封号</el-button
          >
          <el-button
            v-if="scope.row.role == '普通用户' && scope.row.userStatus == 0"
            @click="updateStatus(scope.row, 1)"
            type="info"
            size="small"
            >解封</el-button
          >
          <el-button
            v-show="whichRole == '超级管理员'"
            type="text"
            size="small"
            @click="handleClick(scope.row)"
            >设置权限</el-button
          >
        </template>
      </el-table-column>
    </el-table>
    <div class="pagination-div">
      <el-pagination
        background
        layout="total,prev, pager, next"
        :page-size="6"
        :total="total"
        @current-change="page"
      >
      </el-pagination>
    </div>
    <el-dialog title="权限设置" :visible.sync="dialogFormVisible">
      <el-form :model="form">
        <el-form-item label="用户名" :label-width="formLabelWidth">
          <el-input
            v-model="form.userName"
            autocomplete="off"
            disabled
          ></el-input>
        </el-form-item>
        <el-form-item label="设置角色" :label-width="formLabelWidth">
          <el-select v-model="form.role" placeholder="请选择角色">
            <el-option label="普通用户" value="普通用户"></el-option>
            <el-option label="管理员" value="管理员"></el-option>
          </el-select>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="upRole()">确 定</el-button>
      </div>
    </el-dialog>
  </div>
</template>
<script>
export default {
  data() {
    return {
      formLabelWidth: "80px",
      form: {},
      dialogFormVisible: false,
      key: "",
      whichRole: "",
      total: 0,
      tableData: [],
      user: {
        name: "",
        password: "",
        age: null,
        sex: "",
      },
    };
  },
  methods: {
    upRole() {
      this.$axios
        .post("/admin/upRole", this.form, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          this.$message({
            message: "修改成功",
            type: "success",
          });
        });
      this.dialogFormVisible = false;
    },
    handleClick(row) {
      this.dialogFormVisible = true;
      this.form = row;
      console.log(row);
    },
    selectByKey() {
      this.$axios
        .get("/admin/findAllUser", {
          params: {
            key: this.key,
            pageNum: 1,
            limit: 8,
          },
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          this.tableData = res.data.data.list;
          this.total = res.data.data.total;
        });
    },

    updateStatus(row, status) {
      row.userStatus = status;
      this.$axios
        .post("/admin/updateUserStatus", row, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {});
    },

    deleteUser(row) {
      this.$confirm("此操作将永久删除信息, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios.post("/admin/deleteUserInfo/" + row.uid);
        })
        .then((res) => {
          this.reload();
          this.$message({
            type: "success",
            message: "删除成功!",
          });
        })
        .catch(() => {
          this.$message({
            type: "info",
            message: "已取消删除",
          });
        });
    },
    page(currentPage) {
      this.$axios
        .get("/admin/findAllUser", {
          params: {
            key: this.key,
            pageNum: currentPage,
            limit: 6,
          },
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          this.tableData = res.data.data.list;
          this.total = res.data.data.total;
        });
    },
  },
  created() {
    console.log(this.$store.getters.getToken);
    this.whichRole = this.$store.getters.getRole;
    this.$axios
      .get("/admin/findAllUser", {
        params: {
          key: this.key,
          pageNum: 1,
          limit: 6,
        },
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        this.tableData = res.data.data.list;
        this.total = res.data.data.total;
      });
  },
  inject: ["reload"],
};
</script>
<style scoped>
.el-table--border,
.el-table--group {
  border: none;
}
.pagination-div {
  width: 100%;
  height: 80px;
  display: flex;
  padding: 20px 20px;
}
.el-select .el-input {
  width: 130px;
}
.input-with-select .el-input-group__prepend {
  background-color: #fff;
}
.keySelect {
  width: 400px;
  margin: 0 auto;
}
</style>
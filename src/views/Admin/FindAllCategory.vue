<template>
  <div>
    <div class="keySelect">
      <el-input
        placeholder="请输入分类关键字"
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
      <el-table-column
        prop="categoryId"
        label="分类Id"
        width="120"
        align="center"
      >
      </el-table-column>
      <el-table-column
        prop="categoryName"
        label="分类名称"
        width="120"
        align="center"
      >
      </el-table-column>

      <el-table-column
        prop="createdTime"
        label="添加时间"
        width="200"
        align="center"
      >
      </el-table-column>

      <el-table-column
        prop="updateTime"
        label="上次修改"
        width="200"
        align="center"
      >
      </el-table-column>
      <el-table-column label="操作" width="155" align="center">
        <template slot-scope="scope">
          <el-button @click="showEdit(scope.row)" type="primary" size="small"
            >编辑</el-button
          >
          <el-button
            @click="deleteByCid(scope.$index, tableData)"
            type="danger"
            size="small"
            >删除</el-button
          >
          <el-dialog title="编辑" :visible.sync="dialogFormVisible1">
            <el-form :model="form1">
              <el-form-item label="分类名称" :label-width="formLabelWidth">
                <el-input
                  v-model="form1.categoryName"
                  autocomplete="off"
                ></el-input>
              </el-form-item>
            </el-form>
            <div slot="footer" class="dialog-footer">
              <el-button @click="dialogFormVisible1 = false">取 消</el-button>
              <el-button type="primary" @click="editByCid()">确 定</el-button>
            </div>
          </el-dialog>
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
    <el-button type="primary" @click="dialogFormVisible = true"
      >新增分类</el-button
    >
    <el-dialog title="新增分类" :visible.sync="dialogFormVisible">
      <el-form :model="form">
        <el-form-item label="分类名称" :label-width="formLabelWidth">
          <el-input v-model="form.categoryName" autocomplete="off"></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="dialogFormVisible = false">取 消</el-button>
        <el-button type="primary" @click="addCategory()">确 定</el-button>
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
      form1:{},
      dialogFormVisible: false,
      dialogFormVisible1: false,
      key: "",
      total: 0,
      tableData: [],
    };
  },
  methods: {
    editByCid(){
      console.log(this.form1);
      this.$axios
        .post("/admin/editByCid", this.form1, {
          headers: {
            token: this.$store.getters.getToken,
          },
        }).then((res) => {
          if(res.data.flag==true){
            this.$message({
              type: "success",
              message: "修改成功!",
            });
          }
        })
        this.dialogFormVisible1=false;
    },
    showEdit(row){
      this.dialogFormVisible1=true;
      this.form1=row;
    },
    addCategory() {
      this.$axios
        .post("/admin/addCategory", this.form, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.flag == true) {
            this.$message({
              type: "success",
              message: "添加成功!",
            });
            this.tableData.push(this.form);
          }
        });
      this.dialogFormVisible = false;
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

    deleteByCid(index, rows) {
      this.$confirm("此操作将永久删除信息, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios
            .get("/admin/deleteByCid/" + rows[index].categoryId, {
              headers: {
                token: this.$store.getters.getToken,
              },
            })
            .then((res) => {
              if (res.data.flag == true) {
                this.$message({
                  type: "success",
                  message: "删除成功!",
                });
                rows.splice(index, 1);
              }
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
        .get("/admin/findAllCategory", {
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
    this.$axios
      .get("/admin/findAllCategory", {
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
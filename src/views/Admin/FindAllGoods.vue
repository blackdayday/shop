<template>
  <div>
    <div class="keySelect">
      <el-input
        placeholder="请输入商品关键字"
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
      <el-table-column fixed label="商品图片" width="200" align="center">
        <template slot-scope="scope">
          <div class="img-box">
            <div class="block">
              <span class="demonstration"></span>
              <el-carousel
                indicator-position="outside"
                height="200px"
                weight="200px"
              >
                <el-carousel-item
                  v-for="item in scope.row.productImgs"
                  :key="item"
                >
                  <img :src="item.url" alt="" />
                </el-carousel-item>
              </el-carousel>
            </div>
          </div>
        </template>
      </el-table-column>
      <el-table-column
        fixed
        prop="userId"
        label="发布者账号"
        width="100"
        align="center"
      >
      </el-table-column>
      <el-table-column
        prop="productName"
        label="商品名称"
        width="200"
        align="center"
        show-overflow-tooltip
      >
      </el-table-column>
      <el-table-column
        prop="currentPrice"
        label="价格(元)"
        width="120"
        align="center"
      >
      </el-table-column>
      <el-table-column
        prop="content"
        label="详情"
        width="280"
        align="center"
        show-overflow-tooltip
      >
      </el-table-column>
      <el-table-column
        prop="createTime"
        label="发布时间"
        width="100"
        align="center"
      >
      </el-table-column>
      <el-table-column
        prop="productStatus"
        label="状态"
        width="100"
        align="center"
      >
      </el-table-column>
      <el-table-column fixed="right" label="操作" width="140" align="center">
        <template slot-scope="scope">
          <el-button
            v-if="scope.row.productStatus == 0"
            @click="upProductStatus(scope.row, 1)"
            type="primary"
            size="small"
            >上架</el-button
          >
          <el-button
            v-if="scope.row.productStatus == 1"
            @click="upProductStatus(scope.row, 0)"
            type="info"
            size="small"
            >下架</el-button
          >
          <el-button
            v-show="scope.row.productStatus == 3"
            @click="deleteProduct(scope.$index, tableData)"
            type="danger"
            size="small"
            >删除</el-button
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
  </div>
</template>
<script>
export default {
  data() {
    return {
      key: "",
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
    upProductStatus(row, status) {
      row.productStatus = status;
      this.$axios
        .post("/admin/upProductStatus", row, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.flag == true) {
            this.$message({
              type: "success",
              message: "操作成功!",
            });
          }
        });
    },
    selectByKey() {
      this.$axios
        .get("/admin/findAllGoods", {
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
    deleteProduct(index, rows) {
      this.$confirm("此操作将永久删除商品, 是否继续?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.$axios
            .get("/admin/deleteGood/" + rows[index].productId, {
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
        .get("/admin/findAllGoods", {
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
      .get("/admin/findAllGoods", {
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
.keySelect {
  width: 400px;
  margin: 0 auto;
}
.img-box {
  width: 200px;
  height: 200px;
  overflow: hidden;
}
.img-box img {
  height: 100%;
}
</style>
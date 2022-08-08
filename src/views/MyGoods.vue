<template>
  <div class="my-goods">
    <el-page-header @back="goBack" content="我的发布"> </el-page-header>
    <el-tabs type="border-card" v-model="activeName">
      <!-- ⭐1、我的发布模块 -->
      <el-tab-pane label="我发布的">
        <!-- 1.1、没有已发布商品的情况 -->
        <div class="no-goods" v-if="isHasGoodsForSell == false">
          <img src="../assets/no-goods.png" alt="没有已发布的商品" />
          <div>暂无已发布的商品</div>
        </div>
        <!-- 1.2、有已发布商品的情况 -->
        <div v-else>
          <div v-for="(item, index) in goods">
            <div class="goods-item">
              <div class="img-box">
                <div class="block">
                  <span class="demonstration"></span>
                  <el-carousel
                    indicator-position="outside"
                    height="200px"
                    weight="100px"
                  >
                    <el-carousel-item
                      v-for="(item1,index1) in goods[index].productImgs"
                      :key="index1"
                    >
                      <img :src="item1.url" alt="" />
                    </el-carousel-item>
                  </el-carousel>
                </div>
              </div>
              <div class="desc">
                <div class="gname">
                  <span>{{ item.productName }}</span>
                </div>
                <div class="gname">
                  <span class="price" style="margin: 20px"
                    >原价￥ {{ item.originalPrice }}</span
                  >
                  <span class="price" style="margin: 20px">
                    现价￥{{ item.currentPrice }}</span
                  >
                </div>
                <div class="remark">
                  <span>{{ item.content }}</span>
                  <el-divider direction="vertical"></el-divider>
                  <span>{{ item.createTime | ellipsis_time }}</span>
                </div>
                <div class="status" v-if="item.productStatus == 0">
                  <span>审核中</span>
                </div>
                <div class="status" v-else>
                  <span>已上架</span>
                </div>

                <div class="bottom clearfix">
                  <el-button
                    type="success"
                    icon="el-icon-edit"
                    circle
                    @click="updateBtn(item)"
                  ></el-button>
                  <el-button
                    type="danger"
                    icon="el-icon-delete"
                    circle
                    @click="delBtn(item)"
                  ></el-button>
                </div>
              </div>
            </div>
            <el-divider></el-divider>
          </div>
          <!-- pagination（卖出模块） -->
          <div class="sell-pagination">
            <el-pagination
              background
              layout="total, prev, pager, next"
              :total="total"
              :page-size="2"
              @current-change="page"
            >
            </el-pagination>
          </div>
        </div>
      </el-tab-pane>
      <!-- ⭐我的卖出模块 -->
      <el-tab-pane label="我卖出的">
        <div class="no-goods" v-if="isHasGoodsHasSell == false">
          <img src="../assets/no-goods.png" alt="没有已卖出的商品" />
          <div>暂无卖出的商品</div>
        </div>
        <!-- 1.2、有已卖出商品的情况 -->
        <div v-else>
          <el-table :data="goodsHasSell" style="width: 100%">
            <el-table-column type="expand">
              <template slot-scope="props">
                <el-form label-position="left" inline class="demo-table-expand">
                  <el-form-item label="商品名称:">
                    <span>{{ props.row.subject }}</span>
                  </el-form-item>
                  <el-form-item label="描述:">
                    <span>{{ props.row.body }}</span>
                  </el-form-item>
                  <el-form-item label="商品售价:">
                    <span>{{ props.row.total_amount }}</span>
                  </el-form-item>
                  <el-form-item label="卖出时间:">
                    <span>{{ props.row.gmt_create | | ellipsis_time }}</span>
                  </el-form-item>
                  <el-form-item label="收货人:">
                    <span>{{ props.row.address.receiver }}</span>
                  </el-form-item>
                  <el-form-item label="电话:">
                    <span>{{ props.row.address.phone }}</span>
                  </el-form-item>
                  <el-form-item label="详细地址:">
                    <span>{{ props.row.address.slimAddress }}</span>
                  </el-form-item>
                </el-form>
              </template>
            </el-table-column>
            <el-table-column label="商品名称" prop="subject"> </el-table-column>
            <el-table-column label="描述" prop="body"> </el-table-column>
            <el-table-column label="价格" prop="total_amount">
            </el-table-column>
            <el-table-column label="状态" prop="body">
              <template slot-scope="scope">
                <div v-if="scope.row.trade_status == '等待发货'">
                  <el-tag>{{ scope.row.trade_status }}</el-tag>
                </div>
                <div v-if="scope.row.trade_status == '运输中'">
                  <el-tag>{{ scope.row.trade_status }}</el-tag>
                </div>
                <div v-if="scope.row.trade_status == '已完成'">
                  <el-tag type="warning">{{ scope.row.trade_status }}</el-tag>
                </div>
              </template>
            </el-table-column>

            <el-table-column label="操作">
              <template slot-scope="scope">
                <div v-if="scope.row.trade_status == '等待发货'">
                  <el-button type="primary" @click="updateOk(scope.$index, scope.row)" >发货</el-button>
                </div>
                <div v-else>
                  <el-button type="primary" disabled>发货</el-button>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-tab-pane>
      <!-- ⭐我的买到模块 -->
      <el-tab-pane label="我买到的">
        <div class="no-goods" v-if="isHasBuyGoods == false">
          <img src="../assets/no-goods.png" alt="没有已卖出的商品" />
          <div>暂无卖出的商品</div>
        </div>
        <!-- 1.2、有买到商品的情况 -->
        <div v-else>
          <el-table :data="BuyGoods" style="width: 100%">
            <el-table-column type="expand">
              <template slot-scope="props">
                <el-form label-position="left" inline class="demo-table-expand">
                  <el-form-item label="商品名称:">
                    <span>{{ props.row.subject }}</span>
                  </el-form-item>
                  <el-form-item label="描述:">
                    <span>{{ props.row.body }}</span>
                  </el-form-item>
                  <el-form-item label="商品售价:">
                    <span>{{ props.row.total_amount }}</span>
                  </el-form-item>
                  <el-form-item label="下单时间:">
                    <span>{{ props.row.gmt_create | | ellipsis_time }}</span>
                  </el-form-item>
                  <el-form-item label="收货人:">
                    <span>{{ props.row.address.receiver }}</span>
                  </el-form-item>
                  <el-form-item label="电话:">
                    <span>{{ props.row.address.phone }}</span>
                  </el-form-item>
                  <el-form-item label="详细地址:">
                    <span>{{ props.row.address.slimAddress }}</span>
                  </el-form-item>
                </el-form>
              </template>
            </el-table-column>
            <el-table-column label="商品名称" prop="subject"> </el-table-column>
            <el-table-column label="描述" prop="body"> </el-table-column>
            <el-table-column label="价格" prop="total_amount">
            </el-table-column>
            <el-table-column label="状态">
              <template slot-scope="scope">
                <div v-if="scope.row.trade_status == '等待发货'">
                  <el-tag>{{ scope.row.trade_status }}</el-tag>
                </div>
                <div v-if="scope.row.trade_status == '运输中'">
                  <el-tag>{{ scope.row.trade_status }}</el-tag>
                </div>
                <div v-if="scope.row.trade_status == '已完成'">
                  <el-tag type="warning">{{ scope.row.trade_status }}</el-tag>
                </div>
              </template>
            </el-table-column>
            <el-table-column label="操作">
              <template slot-scope="scope">
                <div v-if="scope.row.trade_status == '运输中'">
                  <el-button type="primary" @click="updateOver(scope.$index, scope.row)">确认收货</el-button>
                </div>
                <div v-else>
                  <el-button type="primary" disabled>确认收货</el-button>
                </div>
              </template>
            </el-table-column>
          </el-table>
        </div>
      </el-tab-pane>
      <!-- ⭐我的退款模块 -->
      <!-- <el-tab-pane label="我的退款">我的退款</el-tab-pane> -->
    </el-tabs>
  </div>
</template>
<script>
export default {
  data() {
    return {
      disabled1: false,
       disabled2: false,
     activeName:"",
      goods: [], //“我发布的”商品
      isHasGoodsForSell: false, //是否有“我发布的”商品
      goodsHasSell: [], //“我卖出的”商品
      isHasGoodsHasSell: false, //是否有“我卖出的”商品
      BuyGoods: [],
      isHasBuyGoods: false, //是否有“我买到的”商品
      total: "",
    };
  },
  watch: {
    //监听goods是否为空
    goods() {
      this.isHasGoodsForSell = this.goods == null ? false : true;
    },
    goodsHasSell() {
      this.isHasGoodsHasSell = this.goodsHasSell == null ? false : true;
    },
    BuyGoods() {
      this.isHasBuyGoods = this.BuyGoods == null ? false : true;
    },
  },
  filters: {
    ellipsis_time(value) {
      //字数过滤器，用于规范化时间
      if (!value) return "";
      if (value.length > 19) {
        return value.slice(0, 19);
      }
      return value;
    },
  },
  methods: {
    updateOk(index,row){

       this.$axios
        .get("user/update-status/" + row.out_trade_no + "/" + 2, {
          headers: {
            token: this.$store.getters.getToken,
          },
        }).then((res) => {
          if (res.data.flag == true){
            row.trade_status = "运输中";
          }
        });
        },
        updateOver(index,row){
          console.log(index,row);
          console.log(row.out_trade_no);
         
       this.$axios
        .get("user/update-status/" + row.out_trade_no + "/" + 3, {
          headers: {
            token: this.$store.getters.getToken,
          },
        }).then((res) => {
          if (res.data.flag == true){
            row.trade_status = "已完成";
          }
        });
        },
    updateBtn(item) {
      this.$router.push({
        path: "/updateGood",
        query: {
          pid: item.productId,
        },
      });
    },
    delBtn(item) {
      this.$axios
        .get("user/delete-publish/" + item.productId, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          if (res.data.flag == true) {
            this.$router.go(0);
          } else {
            this.$message({
              message: "删除失败",
              type: "error",
            });
          }
        });
    },
    page(currentPage) {
      this.$axios
        .get("/user/select-publish/" + this.$store.getters.getUserId, {
          params: {
            pageNum: currentPage,
            limit: 2,
          },
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          console.log("我发布的商品：", res.data.data);
          this.goods = res.data.data.list;
          console.log(this.goods);
        });
    },
    goBack() {
      this.$router.push("/allGoods");
    },
  },
  created() {
    //查询发布商品
    this.$axios
      .get("/user/select-publish/" + this.$store.getters.getUserId, {
        params: {
          pageNum: 1,
          limit: 2,
        },
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        console.log("我发布的商品：", res.data.data);
        this.goods = res.data.data.list;
        this.total = res.data.data.total;
        console.log(this.goods);
      });

    //查询卖出商品
    this.$axios
      .get("/user/find-sold/" + this.$store.getters.getUserId, {
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        console.log("我卖出的商品：", res.data.data);
        this.goodsHasSell = res.data.data;
        for (var i = 0; i < this.goodsHasSell.length; i++) {
          console.log("============");
          if (this.goodsHasSell[i].trade_status == "1") {
            console.log("修改了哈哈哈哈哈哈");
            this.goodsHasSell[i].trade_status = "等待发货";
          } else if (this.goodsHasSell[i].trade_status == 2) {
            this.goodsHasSell[i].trade_status = "运输中";
          } else {
            this.goodsHasSell[i].trade_status = "已完成";
          }
        }
      });

    //查询买到的商品
    this.$axios
      .get("/user/find-buy/" + this.$store.getters.getUserId, {
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        console.log("我买到的商品：", res.data.data);
        this.BuyGoods = res.data.data;
        for (var i = 0; i < this.BuyGoods.length; i++) {
          console.log("============");
          if (this.BuyGoods[i].trade_status == "1") {
            this.BuyGoods[i].trade_status = "等待发货";
          } else if (this.BuyGoods[i].trade_status == 2) {
            this.BuyGoods[i].trade_status = "运输中";
          } else {
            this.BuyGoods[i].trade_status = "已完成";
          }
        }
      });
  },
};
</script>
<style scoped>
.my-goods {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  background-color: #f1f1f1;
}
.goods-item {
  width: 900px;
  height: 200px;
  margin: 20px auto;
  display: flex;
  background-color: #fff;
  border-radius: 20px;
  overflow: hidden;
}
.goods-item .img-box {
  width: 200px;
  height: 400px;
  overflow: hidden;
}
.goods-item .img-box img {
  height: 100%;
}
.goods-item .desc {
  width: 70%;
  margin: 0 auto;
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
  align-items: center;
}
.goods-item .desc .status {
  font-size: x-large;
  color: #d35400;
  width: 300px;
  display: flex;
  justify-content: space-evenly;
  align-items: center;
}
.goods-item .desc .gname {
  font-size: x-large;
  font-weight: 500;
}
.goods-item .desc .gname .price {
  color: #16a085;
}
.goods-item .desc .remark {
  color: rgb(90, 90, 90);
}
/* tab */
.el-tabs {
  margin: 10px auto;
}
.my-goods >>> .is-active {
  color: var(--primary-color) !important;
  font-size: 16px;
  font-weight: 600;
}
.my-goods >>> .el-tabs__item:hover {
  color: var(--primary-color) !important;
  font-size: 16px;
  font-weight: 600;
}
/* 卖出模块 */
/* 没有商品时 */
.no-goods {
  width: 100%;
  height: 500px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}
.no-goods img {
  width: 300px;
}
/* pagination（卖出） */
.sell-pagination {
  width: 100%;
  height: 40px;
  margin: 10px 0;
  display: flex;
  justify-content: center;
}
.sell-pagination
  >>> .el-pagination.is-background
  .el-pager
  li:not(.disabled).active {
  background-color: var(--primary-color);
  color: #ffffff;
}
.sell-pagination >>> .el-pagination.is-background .el-pager li:not(.disabled) {
  color: #424242;
}
.demo-table-expand {
  font-size: 0;
}
.demo-table-expand label {
  width: 90px;
  color: #99a9bf;
}
.demo-table-expand .el-form-item {
  margin-right: 0;
  margin-bottom: 0;
  width: 50%;
}
</style>
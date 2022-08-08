<template>
  <div class="search">
    <el-page-header @back="goBack" content="搜索商品"> </el-page-header>
    <div class="search-result" v-if="isHasGoods == true">
      <el-row>
        <el-col :span="8" v-for="(item, index) in goods" :key="index">
          <el-card :body-style="{ padding: '0px' }" class="good-list-item">
            <div class="img-box" @click="showDetail(index, item)">
              <img :src="item.productImgs[0].url" class="image" />
              <!-- <img :src="item.pic" class="image" /> -->
            </div>
            <div style="padding: 14px" @click="showDetail(index, item)">
              <span>{{ item.productName | ellipsis }}</span>
              <div class="bottom clearfix">
                <time class="desc">{{ item.content | ellipsis }}</time>
                <el-button type="text" class="button"
                  ><span style="color: var(--primary-color); font-size: 18px"
                    >￥ {{ item.currentPrice }}</span
                  >
                </el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
      <div class="pagination">
        <el-pagination
          background
          layout="total, prev, pager, next"
          :page-size="6"
          :total="total"
          @current-change="page"
        >
        </el-pagination>
      </div>
    </div>

    <div class="no-goods" v-else>
      <img src="../assets/no-goods.png" alt="没有商品" />
      <div>无法搜索到商品</div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      total: 0,
      goods: [],
      input: "",
      isHasGoods: false, //是否有商品
    };
  },
  methods: {
    page(currentPage) {
      this.$axios
        .get("/user/findProductByName", {
          params: {
            key: this.input,
            pageNum: currentPage,
            limit: 6,
          },
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          this.goods = res.data.data.list;
          console.log(this.goods);
        });
    },
    //点击商品时触发（跳转到商品详情页）
    showDetail(index, item) {
      console.log("获取到了商品详情", index, item);
      this.$router.push({
        path: "/goodsDetail",
        query: {
          pid: item.productId,
        },
      });
    },
    goBack() {
      this.$router.go(-1);
    },
    search(input) {
      this.$axios
        .get("/user/findProductByName", {
          params: {
            key: input,
            pageNum: 1,
            limit: 6,
          },
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          this.goods = res.data.data.list;
          this.total = res.data.data.total;
          console.log("搜索结果：", this.goods);
        });
    },
  },
  filters: {
    ellipsis(value) {
      //字数过滤器，用于限制商品详情的字数显示
      if (!value) return "";
      if (value.length > 10) {
        return value.slice(0, 10) + "...";
      }
      return value;
    },
  },
  watch: {
    goods() {
      this.isHasGoods = this.goods == null ? false : true;
    },
    $route() {
      let input = this.$route.query.input;
      this.search(input);
    },
  },
  created() {
    let input = this.$route.query.input;
    this.search(input);
  },
};
</script>
<style scoped>
.search-result{
  width: 95%;
  margin: 0 auto;
}
.search {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 600px auto;
  background-color: #fff;
}
.el-col {
  display: flex;
  justify-content: center;
  margin: 20px 0;
}
.el-card {
  width: 280px;
}

.good-list-item {
  width: 280px;
}
.desc {
  font-size: 13px;
  color: #999;
}
/* 商品列表 */
.good-list-item {
  width: 280px;
}
.desc {
  font-size: 13px;
  color: #999;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}
.good-list-item {
  user-select: none;
  cursor: pointer;
}
/* hover实现放大图片效果 */
.good-list-item .image {
  width: 100%;
  display: block;
  cursor: pointer;
  transition: all 0.8s 0.1s;
}
.good-list-item:hover .image {
  transform: scale(1.1);
}
.good-list-item .img-box {
  overflow: hidden;
}
/* ------ */

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}
.el-col {
  display: flex;
  justify-content: center;
  margin: 20px 0;
}
.img-box {
  height: 240px;
}
.img-box img {
  width: 100%;
}
/* 分页 */
.pagination {
  display: flex;
  justify-content: center;
  align-items: center;
  padding: 2% 0;
}
.pagination
  >>> .el-pagination.is-background
  .el-pager
  li:not(.disabled).active {
  background-color: var(--primary-color);
  color: #ffffff;
}
.pagination >>> .el-pagination.is-background .el-pager li:not(.disabled) {
  /* background-color: var(--primary-color); */
  color: #424242;
}
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
</style>
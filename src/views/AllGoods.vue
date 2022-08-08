<template>
  <div class="all-goods">
    <el-main>
      <div class="catalog">
        <el-tabs tab-position="left" @tab-click="selectCatalog">
          <!-- 所有商品模块 -->
          <el-tab-pane label="所有商品">
            <el-row>
              <el-col :span="8" v-for="(item, index) in goods" :key="index">
                <el-card
                  :body-style="{ padding: '0px' }"
                  class="good-list-item"
                >
                  <div class="img-box" @click="showDetail(index, item)">
                     <img :src="item.productImgs[0].url" class="image" />
                    <!-- <img :src="item.pic" class="image" /> -->
                  </div>
                  <div style="padding: 14px" @click="showDetail(index, item)">
                    <span>{{ item.productName | ellipsis}}</span>
                    <div class="bottom clearfix">
                      <time class="desc">{{ item.content | ellipsis}}</time>
                      <el-button type="text" class="button"
                        ><span
                          style="color: var(--primary-color); font-size: 18px"
                          >￥  {{ item.currentPrice }}</span
                        >
                        
                        </el-button
                      >
                    </div>
                  </div>
                </el-card>
              </el-col>
            </el-row>
          </el-tab-pane>
          <!-- 商品分类模块 -->
          <el-tab-pane v-for="item in catalog" :label="item.categoryName" :name="item.categoryId" :key="index">
            <el-row>
              <el-col :span="8" v-for="(item, index) in goods" :key="index">
                <el-card
                  :body-style="{ padding: '0px' }"
                  class="good-list-item"
                >
                  <div class="img-box" @click="showDetail(index, item)">
                    <img :src="item.productImgs[0].url" class="image" />
                  </div>
                  <div style="padding: 14px" @click="showDetail(index, item)">
                    <span>{{ item.productName | ellipsis}}</span>
                    <div class="bottom clearfix">
                      <time class="desc">{{ item.content | ellipsis }}</time>
                      <el-button type="text" class="button"
                        ><span
                          style="color: var(--primary-color); font-size: 18px"
                          >￥{{ item.currentPrice }}</span
                        ></el-button
                      >
                    </div>
                  </div>
                </el-card>
              </el-col>
            </el-row>
          </el-tab-pane>
        </el-tabs>
        <!-- 分页模块 -->
        <!-- 不分类时 -->
        <div class="pagination" v-if="isSort == false">
          <el-pagination
            background
            layout="total, prev, pager, next"
            :page-size="6"
            :total="total"
            @current-change="page"
          >
          </el-pagination>
        </div>
        <!-- 分类时 -->
        <div class="pagination" v-else>
          <el-pagination
            background
            layout="total, prev, pager, next"
            :page-size="6"
            :total="totalSort"
            @current-change="pageSort"
          >
          </el-pagination>
        </div>
      </div>
    </el-main>
  </div>
</template>
<script>
export default {
  data() {
    return {
      pageSize: 9, //每页9条记录
      total: "", //总共多少条记录
      totalSort: "", //分类时总共多少条记录
      isSort: false, //是否分类，默认不分类，查找所有
      selectSort: "",
      catalog: [],
      goods: {},
    };
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
  methods: {
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
    //选择分类时触发（发起axios请求重新渲染页面）
    selectCatalog(tab) {
      if (tab.index != 0) {
        this.isSort = true;
        this.selectSort = tab.name;
        console.log(tab.label);
        console.log("选择的cid", this.selectSort);
        //查询所有商品
        this.$axios
          .get("/index/productbycid/" + tab.name,{
             params: {
          pageNum: 1,
          limit: 6,
        }}).then((res) => {
        this.goods = res.data.data.list;
        this.totalSort = res.data.data.total;
      })
      .catch((err) => {
        console.log(err);
      });
      } else {
        this.isSort = false;
        console.log("不分类");
        this.page(1);
      }
    },
    //不分类时的查找
    
      page(currentPage) {
      this.$axios
      .get("/index/all-product", {
        params: {
          pageNum: currentPage,
          limit: 6,
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
    //分类时的查找
    pageSort(currentPage) {
      console.log("pageSort", currentPage);
      this.$axios
        .get(
          "/index/productbycid/" +this.selectSort,{
               params: {
                pageNum: currentPage,
                limit: 6,
              },
            })
        .then((res) => {
          console.log("分类时的分页数据", res.data.data);
          this.goods = res.data.data.list;
        });
    },
  },
  created() {
    this.$axios.get("/index/category-list").then((res) => {
      console.log(res.data.data);
      this.catalog = res.data.data;
      
    });
    //获取商品信息
    this.$axios
      .get("/index/all-product", {
        params: {
          pageNum: 1,
          limit: 6,
        }}).then((res) => {
        this.goods = res.data.data.list;
        this.total = res.data.data.total;
      })
      .catch((err) => {
        console.log(err);
      });
  },
};
</script>
<style scoped>
/* 图片 */
.img-box {
  height: 240px;
}
.img-box img {
  width: 100%;
}
.catalog >>> .el-tabs__item {
  width: 120px;
}
.catalog >>> .el-tabs__item:hover {
  color: var(--primary-color) !important;
  font-size: 16px;
  font-weight: 600;
}
.catalog >>> .is-active {
  color: var(--primary-color) !important;
  font-size: 16px;
  font-weight: 600;
}
.el-main {
  margin: 0 auto;
  padding: 0;
  width: 1200px;
}
/* 分类菜单 */
.catalog {
  background-color: #fff;
  padding: 10px 0;
}
.catalog-item {
  width: 100%;
  text-align: center;
  padding: 10px 0;
  font-weight: 600;
}
.catalog-item:hover {
  border: solid 1px #0fb9b1;
  color: #079992;
  font-size: 18px;
}
.catalog-item span {
  cursor: pointer;
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
</style>
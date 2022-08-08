<template>
  <div class="bookmark">
    <el-page-header @back="goBack" content="我的收藏"> </el-page-header>
    <!-- 有收藏商品时 -->
    <div class="bookmark-list" v-if="isHasGoods==true">
      <el-row>
        <el-col :span="8" v-for="(item, index) in goods" :key="item">
          <el-card :body-style="{ padding: '0px' }" class="bookmark-list-item">
            <div class="img-box">
              <div class="block">
            <span class="demonstration"></span>
              <el-carousel indicator-position="outside" trigger="click" height="300px">
                <el-carousel-item v-for="(item,index) in goods[index].productImgs" :key="item">
                  <img :src="item.url" alt="" class="image"/>
                </el-carousel-item>
              </el-carousel>
               </div>
              </div>
            <div style="padding: 14px">
              <span>{{ item.productName |ellipsis}}</span>
              <div class="bottom clearfix">
                <time class="time">{{ item.collectTime |ellipsis_time }}</time>
                <el-button
                  type="success"
                  icon="el-icon-search"
                  circle
                  @click="descBtn(item)"
                ></el-button>
                <el-button
                  type="danger"
                  icon="el-icon-delete"
                  circle
                  @click="delBtn(item)"
                ></el-button>
              </div>
            </div>
          </el-card>
        </el-col>
      </el-row>
      <div class="pagination">
        <el-pagination
          background
          layout="total,prev, pager, next"
          :page-size="3"
          :total="total"
          @current-change="page"
        >
        </el-pagination>
      </div>
    </div>
    <!-- 没有收藏商品时 -->
    <div class="no-goods" v-else>
      <img src="../assets/no-goods.png" alt="没有已收藏的商品" />
      <div>暂无已收藏的商品</div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      uid: null,
      total: "",
      goods: {},
      isHasGoods: false, //是否有商品
    };
  },
  watch: {
    //监听goods是否为空
    goods() {
      this.isHasGoods = this.goods == null ? false : true;
    },
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    descBtn(item) {
      this.$router.push({
        path: "/goodsDetail",
        query: {
          pid: item.productId,
        },
      });
    },
    delBtn(item) {
      this.$axios
        .get("user/del-collect/"+ item.collectId,{
          headers:{
            token: this.$store.getters.getToken,
          }
        })
        .then((res) => {
          if(res.data.flag == true){
            
            this.$router.go(0);
             this.$message({
            message: "删除成功",
            type: "success",
          });
          }else{
            this.$message({
            message: "删除失败",
            type: "error",
          });
          }
         
          
            
        });
    },
    page(currentPage) {
      this.$axios
      .get("user/find-collect/" ,{
        params:{
          uid: this.$store.getters.getUserId,
          pageNum: currentPage,
          limit: 3,
        },
        headers:{
          token: this.$store.getters.getToken,
        }
      })
      .then((res) => {
        this.goods = res.data.data.list;
        this.total = res.data.data.total;
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
    ellipsis_time(value) {
      //字数过滤器，用于规范化时间
      if (!value) return "";
      if (value.length > 10) {
        return value.slice(0, 19);
      }
      return value;
    },
  
  },
  created() {
    this.$axios
      .get("user/find-collect/" ,{
        params:{
          uid: this.$store.getters.getUserId,
          pageNum: 1,
          limit: 3,
        },
        headers:{
          token: this.$store.getters.getToken,
        }
      })
      .then((res) => {
        this.goods = res.data.data.list;
        this.total = res.data.data.total;
      });
  },
};
</script>
<style scoped>
.bookmark {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 600px auto;
  background-color: #fff;
}
.bookmark-list {
  width: 95%;
  margin: 0 auto;
}
.bookmark-list-item {
  width: 300px;
  margin: 20px 0;
}
/* ----卡片----- */
.time {
  font-size: 13px;
  color: #999;
  margin-right: 40px;
}

.bottom {
  margin-top: 13px;
  line-height: 12px;
}

.button {
  padding: 0;
  float: right;
}
.img-box {
  height: 300px;
  overflow: hidden;
}
.image {
  width: 100%;
  /* height: 100%; */
  display: block;
}

.clearfix:before,
.clearfix:after {
  display: table;
  content: "";
}

.clearfix:after {
  clear: both;
}
/* --------- */
/* 分页 */
.pagination {
  width: 100%;
  height: 40px;
  margin: 10px 0;
  display: flex;
  justify-content: center;
}
.pagination
  >>> .el-pagination.is-background
  .el-pager
  li:not(.disabled).active {
  background-color: var(--primary-color);
  color: #ffffff;
}
.pagination >>> .el-pagination.is-background .el-pager li:not(.disabled) {
  color: #424242;
}
/* 没有商品 */
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
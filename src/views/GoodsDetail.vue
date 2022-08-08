<template>
  <div class="goods-detail">
    <el-page-header @back="goBack" content="商品详情"> </el-page-header>
    <div class="index">
      <!-- <div class="imgBox">
        <img :src="good.productImgs[0].url" alt="" />
      </div> -->
      <div class="imgBox">
          <div class="block">
            <span class="demonstration"></span>
              <el-carousel trigger="click" height="450px">
                <el-carousel-item v-for="item in good.productImgs" :key="item">
                  <img :src="item.url" alt="" />
                </el-carousel-item>
              </el-carousel>
      </div>
      </div>
       
      <div class="desc">
        <div class="gname">
          {{ good.productName }}
        </div>
        <div class="price">原价￥{{ good.originalPrice }}</div>
        <div class="price">现价￥{{ good.currentPrice }}</div>
        <div class="remark">商品描述：
          {{ good.content }}
        </div>
        <div class="purchase">
          <el-button type="primary" style="width: 120px" @click="purchaseBtn"
            >立即购买</el-button
          >
          <el-button
            type="warning"
            style="width: 120px"
            @click="collectBtn"
            v-show="isCollected == false"
            >加入收藏</el-button
          >
          <el-button
            type="warning"
            style="width: 120px"
            @click="collectBtn"
            v-show="isCollected == true"
            disabled
            >已收藏</el-button
          >
        </div>
      </div>
    </div>
    <div class="message">
      <div class="send-message">
        <el-form :inline="true" :model="addMessage" label-width="80px">
          <el-form-item
            ><el-input
              placeholder="给卖家留言试试"
              v-model="addMessage.content"
            ></el-input
          ></el-form-item>
          <el-form-item
            ><el-button type="primary" style="width: 120px" @click="messageBtn"
              >发布留言</el-button
            ></el-form-item
          >
        </el-form>
      </div>
      <div class="message-list" v-if="isDataArrive">
        <div class="list-item" v-for="item in message">
          <el-divider></el-divider>
          <div class="list-item-index">
            <div class="message-avatar content-item">
              <img :src="item.avatar" alt="" />
            </div>
            <div class="message-username content-item">{{ item.username }}</div>
            <div class="message-content content-item">
              {{ item.content }}
            </div>
            <div class="message-time content-item">
              {{ item.createTime }}
            </div>
          </div>
        </div>
      </div>
      <!-- 分页 -->
      <div class="pagination" v-if="isPaginationShow==true">
        <el-pagination
          background
          layout="prev, pager, next"
          :page-size="6"
          :total="total"
          @current-change="page"
        >
        </el-pagination>
      </div>
    </div>
  </div>
</template>
<script>
export default {
  data() {
    return {
      isDataArrive: false, //留言信息是否到达（防止报错）
      isCollected: false, //用户是否收藏该商品
      total: "",
      isPaginationShow: false,
      pid: "",
      good: {},
      message: {
        userId: null,
        username: "",
        avatar: "",
        goodId: null,
        gname: "",
        pic: "",
        content: "",
        createTime: "",
      },
      addMessage: {
        userId: null,
        goodId: null,
        content: "",
      },
      collect: {},
    };
  },
  watch: {
    total() {
      //监视总数，当总数超过6时显示分页，否则不显示
      this.isPaginationShow = this.total > 6 ? true : false;
    },
  },
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    //购买按钮
    purchaseBtn() {
      this.$router.push({
        path: "/buyGood",
        query: {
          pid: this.good.productId,
        }
      });
    },
    //收藏按钮
    collectBtn() {
      this.collect.productId = this.good.productId;
      this.collect.collectorId = localStorage.getItem("userId");
      this.collect.productName = this.good.productName;
      console.log("发送收藏请求", this.collect);
      this.$axios.post("/user/collect-product", this.collect, {
        headers:{
          token: this.$store.getters.getToken,
        }
      }).then((res) => {
        console.log(res);
        if(res.data.flag==true){
           this.isCollected = true;
            this.$message({
              message: "已加入收藏",
              type: "success",
        });
        }
       else{
         this.$message({
              message: "收藏失败",
              type: "error",
        });
       }
      });
    },
    //留言按钮
    messageBtn() {
      this.addMessage.userId = localStorage.getItem("userId");
      this.addMessage.goodId = this.good.gid;
      console.log("发布留言：", this.addMessage);
      this.$axios.post("/addMessage", this.addMessage).then((res) => {
        console.log("留言成功", res);
        this.$message({
          message: "留言成功",
          type: "success",
        });
        this.addMessage.content = "";
        //再次获取留言列表（刷新）
        this.$axios
          .get("/findGoodMessage/" + this.good.gid + "/1/6")
          .then((res) => {
            console.log("获取到了留言列表", res.data.data);
            this.message = res.data.data.data;
            this.total = res.data.data.totalSize;
          });
      });
    },
    //分页
    page(currentPage) {
      this.$axios
        .get("/findGoodMessage/" + this.good.gid + "/" + currentPage + "/6")
        .then((res) => {
          this.message = res.data.data.data;
          this.total = res.data.data.totalSize;
        });
    },
  },
  created() {
    console.log("query:", this.$route.query.pid);
    this.pid = this.$route.query.pid;
    //获取商品详情
    this.$axios.get("/product/detail-info/" + this.pid,{
       headers: {
          token: this.$store.getters.getToken,
        } 
    }).then((res) => {
      this.good = res.data.data;
      //获取留言列表
      this.$axios
        .get("/findGoodMessage/" + this.good.gid + "/1/6")
        .then((res) => {
          console.log("获取到了留言列表", res.data.data);
          this.message = res.data.data.data;
          this.total = res.data.data.totalSize;
          this.isDataArrive = true;
        });
      //判断是否收藏该商品
      this.$axios
        .get(
          "/user/find-collect/" ,{
              params:{
                uid: localStorage.getItem("userId"),
                pid: this.good.productId,
                pageNum: 0,
                limit: 0,
              },
              headers:{
                token: this.$store.getters.getToken,
              }
            }
        )
        .then((res) => {
          this.isCollected = res.data.flag;
        });
    });
  },
};
</script>
<style scoped>
.el-input {
  width: 400px;
}
.goods-detail {
  margin: 0 auto;
  padding: 12px 12px;
  padding-bottom: 100px;
  width: 1200px;
  background-color: #fff;
}
/* 详情页index */
.index {
  width: 1000px;
  margin: 20px auto;
  display: flex;
}
.index .imgBox {
  width: 400px;
  height: 400px;
  overflow: hidden;
}
.index .imgBox img {
  width: 100%;
}
.index .desc {
  width: 500px;
  margin-left: 40px;
  display: flex;
  flex-direction: column;
  justify-content: space-evenly;
}
.index .desc .price {
  color: #27ae60;
  font-size: 28px;
}
.index .desc .gname {
  font-size: 36px;
  font-family: "Yuanti SC", Youyuan, "You Yuan", 幼圆, "PingFang SC",
    "Microsoft Yahei", Helvetica, sans-serif;
}
.index .desc .purchase .el-button {
  margin: 0 20px;
}
/* 留言页 */
.message {
  width: 1000px;
  margin: 0 auto;
}
.message .send-message {
  width: 800px;
  margin: 0 auto;
}
.message .message-list {
  width: 800px;
  margin: 0 auto;
}
.list-item-index {
  display: flex;
  align-items: center;
}
.list-item-index .content-item {
  margin-right: 10px;
}
.list-item-index .message-avatar {
  width: 40px;
  height: 40px;
  border-radius: 20px;
  background-color: rgb(173, 173, 173);
  overflow: hidden;
}
.list-item-index .message-avatar img {
  width: 100%;
}
.list-item-index .message-username {
  font-weight: 600;
  font-size: small;
  color: #27ae60;
}
.list-item-index .message-time {
  font-size: smaller;
  color: #7a7a7a;
}
/* pagination */
.pagination {
  width: 100%;
  display: flex;
  justify-content: center;
  margin-top: 20px;
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
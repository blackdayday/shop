<template>
  <div class="main">
    <el-page-header @back="goBack" content="购买商品"> </el-page-header>
    <br />
    <div class="address" style="">
      <div>
        <el-row :gutter="12">
          <el-col v-for="(item, i) in address" :span="6" :key="i">
            <div
              class="border"
              @click="chooseAd(item, i)"
              v-show="isShow(i)"
              :style="styleChange(i)"
            >
              <h1 style="font-size: 1px; margin: 0 0 0 0">
                {{ item.receiver }}(收)
                <Span v-if="item.isDefault === 1" style="color: red">
                  默认地址
                </Span>
              </h1>
              <h1 style="font-size: 2px; margin: 0 0 0 0">
                {{ item.phone }}
              </h1>
              <span class="text">
                {{ item.slimAddress }}
              </span>
            </div>
          </el-col>
        </el-row>
        <span @click="showAllAd()" style="font-size: 1px; margin: 0 0 0 0">
          展示全部地址
        </span>
      </div>
    </div>
    <br />
    <div>
      <p style="text-align: center; font-weight: bold">确认订单信息</p>
      <el-table :data="good" style="width: 100%">
        <el-table-column type="expand">
          <template slot-scope="props">
            <el-form label-position="left" inline class="demo-table-expand">
              <el-form-item label="商品名称">
                <span>{{ props.row.productName }}</span>
              </el-form-item>
              <el-form-item label="商品图片">
                <div class="img-box">
                  <div class="block">
                    <span class="demonstration"></span>
                    <el-carousel
                      indicator-position="outside"
                      height="200px"
                      weight="100px"
                    >
                      <el-carousel-item
                        v-for="item in props.row.productImgs"
                        :key="item"
                      >
                        <img :src="item.url" alt="" />
                      </el-carousel-item>
                    </el-carousel>
                  </div>
                </div>
              </el-form-item>

              <el-form-item label="商品描述">
                <span>{{ props.row.content }}</span>
              </el-form-item>
              <el-form-item label="商品原价">
                <span>{{ props.row.originalPrice }}</span>
              </el-form-item>
              <el-form-item label="商品现价">
                <span>{{ props.row.currentPrice }}</span>
              </el-form-item>
            </el-form>
          </template>
        </el-table-column>
        <el-table-column label="商品名称" prop="productName"> </el-table-column>
        <el-table-column label="描述" prop="content"> </el-table-column>
        <el-table-column label="价格" prop="currentPrice"> </el-table-column>
      </el-table>
    </div>
    <br />
    <div>
      <div style="display: flex; justify-content: flex-end">
        <div style="height: 100px; width: 300px; border: 1px solid red">
          <h1 style="font-size: 15px">实付款: {{ good[0].currentPrice }}元</h1>
          <h1 style="font-size: 10px">
            寄送至: {{ chooseaddress.slimAddress }}
          </h1>
          <h1 style="font-size: 10px">
            收货人: {{ chooseaddress.receiver }} {{ chooseaddress.phone }}
          </h1>
        </div>
      </div>
      <div style="display: flex; justify-content: flex-end">
        <button
          @click="submit()"
          style="width: 70px; background-color: red; border: 1px solid red"
        >
          提交订单
        </button>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      chooseaddress: {},
      good: [],
      address: [],
      pid: "",
      isShowAll: false,
      showStyle: 0,
      form: {
        subject: "",
        body: "",
        total_amount: "",
        user_id: "",
        address: {},
      },
    };
  },
  computed: {},
  methods: {
    goBack() {
      this.$router.go(-1);
    },
    chooseAd(it, i) {
      this.showStyle = i;
      this.chooseaddress = it;
      console.log(it);
      console.log(this.chooseaddress);
      console.log(i);
    },
    isShow(i) {
      return this.isShowAll || i < 4;
    },
    styleChange(i) {
      if (this.showStyle === i) {
        return `background: linear-gradient(white,white) padding-box,repeating-linear-gradient(-45deg,red 0,  0.3em,white 0,blue 0.75em);`;
      } else {
        return "";
      }
    },
    showAllAd() {
      this.isShowAll = !this.isShowAll;
    },
    submit() {
      this.form.subject = this.good[0].productName;
      this.form.body = this.good[0].content;
      this.form.total_amount = this.good[0].currentPrice;
      this.form.product_id = this.good[0].productId;
      this.form.address_id = this.chooseaddress.addressId;
      this.form.user_id = this.$store.getters.getUserId;
      this.form.solder_id = this.good[0].userId;
      // this.form.solder_id=this.good[0].userId;
      console.log(this.form);
      this.$axios
        .post("/user/buy-product", this.form, {
          headers: {
            token: this.$store.getters.getToken,
          },
        })
        .then((res) => {
          //res即为后端返回的form表单
          //js创建一个div将form表单添加上去
          const div = document.createElement("div");
          div.innerHTML = res.data.data;
          document.body.appendChild(div);
          //调用form表单
          document.forms[0].submit();
        });
      console.log("提交");
    },
  },
  mounted() {},
  created() {
    this.pid = this.$route.query.pid;
    this.$axios
      .get("/product/detail-info/" + this.pid, {
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        this.good.push(res.data.data);
      });

    //查找地址
    this.$axios
      .get("/user/find-address/" + this.$store.getters.getUserId, {
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        this.address = res.data.data;
        this.chooseaddress = this.address[0];
      });
  },
};
</script>

<style>
.main {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 1000px;
  background-color: #fff;
}
.card {
  background-color: white;

  border: 1px solid transparent;
  border-bottom: 0;
  border-radius: 200px 200px 0 0;
}
.border {
  position: relative;
  height: 100px;
  margin: 10px 0px 10px 0px;
  border: 3px solid transparent;
  /* background: linear-gradient(white,white) padding-box,
                 repeating-linear-gradient(-45deg,red 0,  0.3em,white 0,blue 0.75em); */
  background: linear-gradient(white, white) padding-box,
    repeating-linear-gradient(-45deg, #ccc 0, #ccc 0.5em, white 0, white 0.75em);
}
.text {
  font-size: 15px;
}
.horizontal {
  text-align: center;
  border-bottom: 2px solid #13a9d6;
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
.img-box {
  width: 200px;
  height: 200px;
  overflow: hidden;
}
.img-box img {
  height: 100%;
}
</style>
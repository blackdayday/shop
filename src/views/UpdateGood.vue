<template>
  <div class="update-goods">
    <el-page-header @back="goBack" content="修改商品"> </el-page-header>
    <br />
    <div class="form-box"><el-form ref="form" :model="form" :rules="rules" label-width="80px">
      <el-form-item label="商品名称" prop="productName">
        <el-input v-model="form.productName"></el-input>
      </el-form-item>
      <el-form-item label="商品描述" prop="content">
        <el-input type="textarea" v-model="form.content"></el-input>
      </el-form-item>
      <el-row>
        <el-col span="8">
          <el-form-item label="商品原价">
            <el-input v-model="form.originalPrice"></el-input>
          </el-form-item>
        </el-col>
        <el-col span="8">
          <el-form-item label="商品现价" prop="currentPrice">
            <el-input v-model="form.currentPrice"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
      <el-form-item label="商品类别" prop="categoryId">
        <el-select v-model="form.categoryId" placeholder="请选择类别">
          <el-option
            v-for="item in categoryList"
            :key="item.categoryId"
            :label="item.categoryName"
            :value="item.categoryId"
          >
          </el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="商品图片">
        <div class="imgBox">
          <div class="block">
            <el-carousel indicator-position="outside" height="300px">
              <el-carousel-item v-for="item in form.productImgs" :key="item">
                <img :src="item.url" alt=""  />
              </el-carousel-item>
            </el-carousel>
          </div>
        </div>
      </el-form-item>
      <div v-show="isUpdateImgs">
          <el-form-item label="商品主图(1张)" prop="mainImg">
        <el-upload
          action="http://localhost:8088/product/upload-imgs"
          list-type="picture-card"
          name="img"
          :headers="header"
          :on-preview="handlePictureCardPreview"
          :on-remove="handleRemove"
          :on-success="handleSave"
          :auto-upload="true"
          :on-exceed="mainImg_exceedMsg"
          :limit="1"
        >
          <i class="el-icon-plus"></i>
        </el-upload>
        <el-dialog :visible.sync="dialogVisible">
          <img width="100%" :src="dialogImageUrl" alt="" />
        </el-dialog>
      </el-form-item>
      <el-form-item label="其他图（3张）">
        <el-upload
          action="http://localhost:8088/product/upload-imgs"
          name="img"
          :file-list="fileList"
          list-type="picture-card"
          :headers="header"
          :on-preview="handlePictureCardPreview1"
          :on-remove="handleRemove1"
          :on-success="handleSave1"
          :auto-upload="true"
          :multiple="true"
          :on-exceed="otherImg_exceedMsg"
          :limit="3"
        >
          <i class="el-icon-plus"></i>
        </el-upload>
        <el-dialog :visible.sync="dialogVisible">
          <img width="100%" :src="dialogImageUrl" alt="" />
        </el-dialog>
      </el-form-item>
      </div>
      
      
      <el-form-item>
        <el-button type="success" @click="changeIsUpdateImgs">重新上传图片</el-button>
        <el-button type="success" @click="submit">立即修改</el-button>
      </el-form-item>
    </el-form></div>
    
  </div>
</template>
<script>
export default {
  data() {
    return {
      rules: {
        mainImg: [
          {
            required: true,
            message: "请上传一张主图",
            trigger: "blur",
          },
        ],
        categoryId: [
          {
            required: true,
            message: "请选择商品类别",
            trigger: "blur",
          },
        ],
        currentPrice: [
          {
            required: true,
            message: "请输入出售价格",
            trigger: "blur",
          },
        ],
        productName: [
          {
            required: true,
            message: "请输入商品名称",
            trigger: "blur",
          },
          {
            min: 1,
            max: 12,
            message: "长度在 1 到 12 个字符",
            trigger: "blur",
          },
        ],
        content: [
          {
            required: true,
            message: "请输入详情描述",
            trigger: "blur",
          },
          {
            min: 0,
            max: 40,
            message: "字数在0到40之间",
            trigger: "blur",
          },
        ],
      },
      header: { token: this.$store.getters.getToken },
      imgsMap: [],
      form: {
        productImgs: [],
      },
      categoryList: {},
      file: "",
      pid: "",
      isUpdateImgs: false,
    };
  },
  methods: {
    changeIsUpdateImgs(){
      this.isUpdateImgs=!this.isUpdateImgs;
    },
    //图片数量超出提示
    mainImg_exceedMsg() {
      this.$alert("只能上传一张主图", "提示", {
        confirmButtonText: "确定",
        callback: (action) => {},
      });
    },
    otherImg_exceedMsg() {
      this.$alert("只能上传三张次图", "提示", {
        confirmButtonText: "确定",
        callback: (action) => {},
      });
    },

    
    handleSave(response, file, fileList) {
      this.imgsMap[file.uid] = { url: response, isMain: 1 };
    },
    handleSave1(response, file, fileList) {
      this.imgsMap[file.uid] = { url: response, isMain: 0 };  
    },
    handleRemove(file, fileList) {
      const ossUrl = this.imgsMap[file.uid].url;
      this.$axios.post("/product/delete-img", { ossUrl },{
        headers: {
           token:this.$store.getters.getToken,
        }
      }).then((res) => {
        delete this.imgsMap[file.uid];
      });
    },
    handleRemove1(file, fileList) {
      const ossUrl = this.imgsMap[file.uid].url;
      this.$axios.post("/product/delete-img", { ossUrl },{
         headers: {
           token:this.$store.getters.getToken,
        }
      }).then((res) => {
        delete this.imgsMap[file.uid];
      });
    },

    goBack() {
      this.$confirm("确定放弃修改吗?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning",
      })
        .then(() => {
          this.setImgs();
          for (var i = 0; i < this.form.productImgs.length; i++) {
            const ossUrl = this.form.productImgs[i].url;
            this.$axios
              .post("/product/delete-img", { ossUrl },{
                headers: {
                  token: this.$store.getters.getToken,
                }
              })
              .then((res) => {});
          }
          this.$router.go(-1);
        })
        .catch(() => {});
    },
    setImgs(){
      this.form.productImgs=[];
      console.log(this.form.productImgs);
       for (var key in this.imgsMap) {  
            this.form.productImgs.push(this.imgsMap[key]);
        }
    },
    submit() {
      this.setImgs();
      this.$axios
        .post("/user/update-publish", this.form, {
          headers: { token: this.$store.getters.getToken },
        })
        .then((res) => {
          console.log(res.data.flag);
          if (res.data.flag == false) {
            this.$message.error("修改失败！");
            this.$router.go(0);
          } else {
            this.$message.success("修改成功！");
            this.$router.go(-1);
          }
        });
    },
  },
  created() {
    this.$axios.get("/index/category-list").then((res) => {
      this.categoryList = res.data.data;
    });
    this.pid = this.$route.query.pid;
    this.$axios
      .get("/product/detail-info/" + this.pid, {
        headers: {
          token: this.$store.getters.getToken,
        },
      })
      .then((res) => {
        this.form = res.data.data;
      });
    this.form.userId = localStorage.getItem("userId");
    
  },
};
</script>
<style scoped>
.update-goods {
  margin: 0 auto;
  padding: 12px 12px;
  width: 1200px;
  height: 1200px auto ;
  background-color: #fff;
}
.form-box {
  height: 600px auto;
  margin: 20px auto;
  display: flex;
  background-color: #fff;
  border-radius: 20px;
  overflow: hidden;
}
.index {
  display: flex;
}
.update-goods .imgBox {
  height: 300px;
  weight: 200px;
  overflow: hidden;
}
.update-goods .imgBox img {
  width: 100%;
  height: 100%;
  /* height: 100%; */
  display: block;
}
.index .form {
  margin-top: 30px;
  margin-left: 30px;
  width: 800px;
  height: 600px;
}
.index .option {
  display: flex;
  justify-content: center;
}
.add-pic {
  width: 400px;
  margin: 10px auto;
}
.index {
  width: 800px;
  margin: 10px auto;
}
</style>
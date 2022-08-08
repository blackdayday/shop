/*
 Navicat Premium Data Transfer

 Source Server         : 阿里云
 Source Server Type    : MySQL
 Source Server Version : 50735
 Source Host           : 120.25.214.9:3306
 Source Schema         : campus_shop

 Target Server Type    : MySQL
 Target Server Version : 50735
 File Encoding         : 65001

 Date: 17/05/2022 16:29:46
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for address
-- ----------------------------
DROP TABLE IF EXISTS `address`;
CREATE TABLE `address`  (
  `address_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `slim_address` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `receiver` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `default_address` tinyint(1) NOT NULL,
  PRIMARY KEY (`address_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of address
-- ----------------------------
INSERT INTO `address` VALUES ('0a9e542ed0ac49cb85e412d65e4ef0cd', '12345678910', '广东省茂名市化州市', 'bf0ac345eb344a5e9ed031dcac30f289', '小梁', 1);
INSERT INTO `address` VALUES ('115a63760cad408fa19fa9fa6aee3a28', '是', '是', 'bf0ac345eb344a5e9ed031dcac30f289', '是', 0);
INSERT INTO `address` VALUES ('30f41ec54e43466dbce2c3dea32ddc39', '啊', '啊1', 'd34251f755934b37bb5b05bfcb5ecf61', '啊', 0);
INSERT INTO `address` VALUES ('5b874cb5a00840248688e0fa7803d308', '是', '是', 'bf0ac345eb344a5e9ed031dcac30f289', 's', 0);
INSERT INTO `address` VALUES ('b5f4975f631d424d83e024bef0621e1d', '98765432100', '广东省肇庆市端州区', 'bf0ac345eb344a5e9ed031dcac30f289', '大熊', 0);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `category_id` int(11) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `created_time` datetime NOT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '手机/电脑', '2022-03-17 14:38:33', NULL);
INSERT INTO `category` VALUES (2, '运动/户外', '2022-04-08 17:04:10', NULL);
INSERT INTO `category` VALUES (3, '鞋子/衣服', '2022-04-10 17:04:42', NULL);
INSERT INTO `category` VALUES (4, '零食/饮品', '2022-04-10 17:05:57', NULL);
INSERT INTO `category` VALUES (5, '美容/洁面', '2022-04-06 17:06:57', NULL);
INSERT INTO `category` VALUES (6, '单车/汽车', '2022-04-06 17:08:38', NULL);
INSERT INTO `category` VALUES (7, '键盘/鼠标', '2022-03-31 17:24:58', NULL);
INSERT INTO `category` VALUES (9, '好吃的', '2022-04-22 08:34:21', '2022-04-22 08:34:21');

-- ----------------------------
-- Table structure for collect
-- ----------------------------
DROP TABLE IF EXISTS `collect`;
CREATE TABLE `collect`  (
  `collect_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `collect_time` datetime NOT NULL,
  `collect_status` int(1) NOT NULL,
  `collector_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`collect_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collect
-- ----------------------------
INSERT INTO `collect` VALUES ('31b7c8f8f1f64478b8af820a70326022', '6960e5c47a694347846fce20e80814c7', '2022-04-10 15:34:05', 1, 'd34251f755934b37bb5b05bfcb5ecf61', '【9.9抢30包】掌心脆干吃干脆面零食');
INSERT INTO `collect` VALUES ('3fc46a41c155404ab116e51e4eae84a1', 'aef5a49df39c424789464582e36d7a44', '2022-04-22 08:32:10', 1, 'bf0ac345eb344a5e9ed031dcac30f289', '烧烤炉家用木炭工具全套炉子碳烤肉箱');
INSERT INTO `collect` VALUES ('bc14f8b1e0fa4069864935b67e55812c', '8d968645dafb46a7a12df86070cbd089', '2022-04-11 09:55:23', 1, 'd34251f755934b37bb5b05bfcb5ecf61', '欧文 6');
INSERT INTO `collect` VALUES ('cb07c4e9d9424afda6cab6c13befe7a4', 'ab073ac5e39544b6854297420208c3ff', '2022-04-11 09:55:28', 1, 'd34251f755934b37bb5b05bfcb5ecf61', 'iphone 13');

-- ----------------------------
-- Table structure for product
-- ----------------------------
DROP TABLE IF EXISTS `product`;
CREATE TABLE `product`  (
  `product_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `category_id` int(11) NOT NULL,
  `product_status` varchar(1) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `create_time` datetime NULL DEFAULT NULL,
  `update_time` datetime NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `original_price` double(10, 2) NULL DEFAULT NULL,
  `current_price` double(10, 2) NOT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`product_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product
-- ----------------------------
INSERT INTO `product` VALUES ('0041bfecf6b04a09bb1c36e66404d9c5', '帐篷户外全自动3-4双人2单人家用防晒防虫室内', 2, '1', '2022-04-10 09:58:12', '2022-04-10 09:58:12', '优品联创，仓库清仓\n\n仓库清仓100多套帐篷特价出售，原价都是2.300元的帐篷，现在特价包邮。\n\n颜色： 蓝色、 绿色', 150.00, 80.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('0cd6d9aaf7474e49a03cc0b0355383f4', '电脑', 1, '1', '2022-04-22 08:13:36', '2022-04-22 08:13:36', '好用', 5000.00, 2000.00, 'bf0ac345eb344a5e9ed031dcac30f289');
INSERT INTO `product` VALUES ('164827fa79694a65815f766892185937', '驭帅15 V2', 3, '1', '2022-04-10 09:39:16', '2022-04-10 09:39:16', '李宁 驭帅15 V2 实战篮球鞋 白黑\n得物入手 可鉴别 有得物鉴别书 \n轻微穿着 不适合我脚型', 699.00, 429.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('1cdd54daf0cd402abb1a4cb48cb36c7c', 'Giant Trance 3 林道 Enduro 自行车Gi', 6, '1', '2022-04-10 10:14:29', '2022-04-10 10:14:29', 'ant Trance 3 软尾 林道 速降 越野 AM FR 山地车\n我感觉比Reign 性价比高\n尺码：S 3 相当于M\n成色：99新\n发票 所有一切 都齐全', 8999.00, 7999.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('445bfa4452e64aa49903346ab8ebf41a', '充电无线鼠标', 7, '1', '2022-04-10 10:10:25', '2022-04-10 10:10:25', '品牌：英沃菲\n类型：无线鼠标\n与电脑连接方式：无线\n适用机型：笔记本电脑\n光电分辨率\n操作距离：1.8（m）\n特色：游戏鼠标', 129.00, 59.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('6960e5c47a694347846fce20e80814c7', '【9.9抢30包】掌心脆干吃干脆面零食', 4, '1', '2022-04-10 09:46:14', '2022-04-10 09:46:14', '【生产日期】2022-03-01\n【品牌】掌心脆\n【规格】20g*30包\n【生产厂家地址】河南省新乡市新乡县南街村老北京方便面\n【保质期】180天\n【包装种类】袋装\n【成色】全新', 39.90, 9.90, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('819abff4f09a4bd9b1b4d62c85336b52', 'aj1 海军蓝 41码', 3, '1', '2022-04-10 09:41:45', '2022-04-10 09:41:45', '鞋头满星 成色充新 原盒鞋带都在', 2599.00, 1299.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('841ffcec23244384b3a4f6fc9203e585', '飞利浦全新机械键盘', 7, '1', '2022-04-10 09:34:54', '2022-04-10 09:34:54', '【关于电池】 有线键盘\n【发货时间】 付款后24小时内发货\n【关于售后】 保修一年，支持7天无理由退货', 199.00, 99.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('896f9a6ffe534b2fad0b384a0d3d5484', 'PS5', 1, '0', '2022-04-11 09:29:22', '2022-04-11 09:29:22', '全新国外版，全部游戏可玩', 2599.00, 2699.00, 'd34251f755934b37bb5b05bfcb5ecf61');
INSERT INTO `product` VALUES ('8bc179e518004acc9dee26296bce4734', '一叶子面膜鲜嫩水光22片清洁补水保湿提亮肤色男女玻尿酸收缩毛', 5, '1', '2022-04-10 10:07:11', '2022-04-10 10:07:11', '一盒三效 深层净澈 瞬时补水 多维焕亮\n一叶子清颜净肤炭黑面膜 净含量：25ml*8片\n一叶子玫瑰水润亮采面膜 净含量：25ml*7片\n一叶子樱花粉嫩修护面膜 净含量：25ml*7片\n全新原封原装未使用，外包装有些破旧，介意者勿拍\n保质期：2023年9月\n保证正品', 99.00, 31.90, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('8d968645dafb46a7a12df86070cbd089', '欧文 6', 3, '1', '2022-04-10 09:14:36', '2022-04-10 09:14:36', '欧文6代，左鞋底纹路有磨损，其他良好。', 800.00, 300.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('9c079f06f67148acbb0940f77018f0bd', '麻辣零食大礼包一整箱好吃的休闲零食荤素搭配卤味尾货清仓', 4, '1', '2022-04-10 09:44:10', '2022-04-10 09:44:10', '【生产日期】2022-03-01\n【品牌】黎记老香味\n【规格】1000g\n【生产厂家地址】湖北省荆州市沙市区鱼鱼果园\n【保质期】270天\n【包装种类】袋装\n【成色】全新', 66.00, 12.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('ab073ac5e39544b6854297420208c3ff', 'iphone 13', 1, '1', '2022-04-10 09:02:40', '2022-04-10 09:02:40', '使用时长6个月，全机完好无损没拆过，因公司问题需要换国产品牌故出售。', 8888.00, 5000.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('aef5a49df39c424789464582e36d7a44', '烧烤炉家用木炭工具全套炉子碳烤肉箱', 2, '1', '2022-04-10 09:56:18', '2022-04-10 09:56:18', '关于品牌：品牌直营，闲鱼优品认证商家\n关于售后：支持七天无理由退换货\n关于地址：不同产品，不同仓库发货\n关于快递：根据收货地址选择最合适的快递\n关于新旧：全新，能下单的都有货，建议自助购物', 108.00, 88.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('b73b4a145d5d443cbcdacea2cd2f606d', '易科美ICE冰晶嫩肤仪淡化痘印改善毛孔家用美容仪器', 5, '1', '2022-04-10 10:04:30', '2022-04-10 10:04:30', '品牌型号：ydunvie/易科美ICE冰晶\n新旧程度：国行95新无塑封\n备注：包含盒子说明书', 2499.00, 1599.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('bddca0c9f7e94c96a0ecf24ea81c344e', '15款大众速腾1.6L', 6, '0', '2022-04-11 09:26:42', '2022-04-11 09:26:42', '全部4s店保养，现公里数为4.1万公里，油耗低，大屏导航，车况好，无事故，无改装，除漆面小剐小蹭外，一切完好无损。', 220000.00, 75000.00, 'd34251f755934b37bb5b05bfcb5ecf61');
INSERT INTO `product` VALUES ('c128342cdd264e62ad4902a759250a7e', '临期 元气森林 苏打水气泡水无糖饮料480ml*8', 4, '1', '2022-04-10 09:48:48', '2022-04-10 09:48:48', '此款【元气森林】苏打水气泡水，官方临期，临期清仓30份！！！旗舰店一瓶6元左右，官方临期一瓶不到2.5元！\n\n规格：\n19.8元、8瓶、480ml每瓶、口味随机\n\n【收到货剩余保质期】10-15天左右', 60.00, 19.90, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('c1d6f5e126b24d309789b2e9b06ae023', '95新苹果 ipad mini2  国行 WIFI版 16G', 1, '2', '2022-04-10 09:22:22', '2022-04-10 09:22:22', '【关于电池】 原装电池  电池效率86%\n【系统版本】 12.5.5 \n【关于赠品】 送充电器＋数据线\n【发货时间】 付款后24小时内发货\n【关于售后】 保修一年，支持7天内质量问题退换货。防拆标保留好，撕毁默认私自拆机，不支持退货及质保服务。', 3999.00, 599.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('c859ce11ff4d4c6b8a5e6e97fd3f5a64', 'spalding 库里 curry 亲签', 2, '1', '2022-04-10 10:01:40', '2022-04-10 10:01:40', '库里 curry 亲签 亲笔签名 篮球\n售出不退换。\n交易方式:线上交易', 189.00, 2499.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('d8f30ba828bf4b79b9aebee38c8ca4e6', 'GTX1050二手笔记本电脑神舟K670炫龙毁灭者G4600', 1, '1', '2022-04-10 09:28:45', '2022-04-10 09:28:45', '质检过的二手原装笔记本，无修无进水\n【关于配置】G4600  GTX1050(4) 240G固态 8G\n【关于型号】炫龙毁灭者/神舟K670\n【关于成色】成色9成新，轻微磨损使用痕迹，屏幕无划痕外观无磕碰，整机使用正常', 4150.00, 2150.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('e1e8c9b1424c41919a13840a131b547a', 'Giant Trance 3 林道 Enduro 自行车Gi', 6, '2', '2022-04-10 10:14:29', '2022-04-10 10:14:29', 'ant Trance 3 软尾 林道 速降 越野 AM FR 山地车\n我感觉比Reign 性价比高\n尺码：S 3 相当于M\n成色：99新\n发票 所有一切 都齐全', 8999.00, 7999.00, '9c6da44758c14ebcb9f545234b2d6559');
INSERT INTO `product` VALUES ('e9eb7726231744c88a8b072c4b8c785b', 'OPPO A32 4G+128G 9新 OPPO二手手机', 1, '2', '2022-04-10 09:32:02', '2022-04-10 09:32:02', '此机器购买的日期是2021年3月6号，电池正常，收货后可享受365天维修质保服务', 2888.00, 679.00, '9c6da44758c14ebcb9f545234b2d6559');

-- ----------------------------
-- Table structure for product_img
-- ----------------------------
DROP TABLE IF EXISTS `product_img`;
CREATE TABLE `product_img`  (
  `id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `item_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `is_main` int(1) NOT NULL,
  `created_time` datetime NULL DEFAULT NULL,
  `updated_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of product_img
-- ----------------------------
INSERT INTO `product_img` VALUES ('023a326ff5f54691a0d333f644d4aa81', 'aef5a49df39c424789464582e36d7a44', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/deb0832f70164ecca33287068bcf6d3e.jpg', 0, '2022-04-10 09:56:18', '2022-04-10 09:56:18');
INSERT INTO `product_img` VALUES ('06579d82eadc4341afe2b193a2915b03', '9c079f06f67148acbb0940f77018f0bd', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e56e65dc6dfa42898da36b3a5df46ec9.jpg', 0, '2022-04-10 09:44:10', '2022-04-10 09:44:10');
INSERT INTO `product_img` VALUES ('0a3dd35ae1de4845b1fbf406bf32bc7c', 'e1e8c9b1424c41919a13840a131b547a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1affc6e0685d4532933fd1022b84f59a.jpg', 1, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('0ab0c904e48e496f92878c1af9195827', 'e1e8c9b1424c41919a13840a131b547a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1338f8a29fa3484eaf02b3f1283ad555.jpg', 0, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('0ded3e6fd0f74e0dbb623844719a238d', 'c859ce11ff4d4c6b8a5e6e97fd3f5a64', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/686accfb09394592bc4eb8e309931c69.jpg', 0, '2022-04-10 10:01:40', '2022-04-10 10:01:40');
INSERT INTO `product_img` VALUES ('14ca663461e8484bb01bd6a64aa25084', '819abff4f09a4bd9b1b4d62c85336b52', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/5899908c04794e4c8965d51220753c2d.jpg', 0, '2022-04-10 09:41:45', '2022-04-10 09:41:45');
INSERT INTO `product_img` VALUES ('1b166e3a39034078a74b2071f35c901f', 'aef5a49df39c424789464582e36d7a44', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/61184a759cd446d2a08aa156ae4feb09.jpg', 1, '2022-04-10 09:56:18', '2022-04-10 09:56:18');
INSERT INTO `product_img` VALUES ('1ce73564131e4edd9fbd4e8c11482559', 'c1d6f5e126b24d309789b2e9b06ae023', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/6d14152c56044346b7f774ded254da8b.jpg', 0, '2022-04-10 09:22:22', '2022-04-10 09:22:22');
INSERT INTO `product_img` VALUES ('242a319a464f4090ad4d315a03d9150c', 'ab073ac5e39544b6854297420208c3ff', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/a746d0ea038e44ea9490272b9d37be52.jpg', 0, '2022-04-10 09:02:40', '2022-04-10 09:02:40');
INSERT INTO `product_img` VALUES ('25a812d85a924d22a12305f81121ab5d', '445bfa4452e64aa49903346ab8ebf41a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/543311016c6549a5ba6fa73acc5b3040.jpg', 1, '2022-04-10 10:10:25', '2022-04-10 10:10:25');
INSERT INTO `product_img` VALUES ('26c4172cbf414cc78743f98e79e21cc0', 'bddca0c9f7e94c96a0ecf24ea81c344e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/cc7bee1cca5742a7a0b35f3e102041c1.jpg', 0, '2022-04-11 09:26:42', '2022-04-11 09:26:42');
INSERT INTO `product_img` VALUES ('2b21d31b744e4673b01e02194da87c3f', '0041bfecf6b04a09bb1c36e66404d9c5', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/0444dd73bb694cc9aa805600c443123c.jpg', 0, '2022-04-10 09:58:12', '2022-04-10 09:58:12');
INSERT INTO `product_img` VALUES ('2c6e119626b04112a78836265ea17abd', 'c128342cdd264e62ad4902a759250a7e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b68548bef70f4e728934000c27a7b526.jpg', 0, '2022-04-10 09:48:48', '2022-04-10 09:48:48');
INSERT INTO `product_img` VALUES ('2da99367a95f4ffa9d39632cc420488a', 'e9eb7726231744c88a8b072c4b8c785b', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/61c34c79a1dc4131a00422822a205897.jpg', 0, '2022-04-10 09:32:02', '2022-04-10 09:32:02');
INSERT INTO `product_img` VALUES ('31bd10e54b7847869d3eb80f4a26ac6e', 'c1d6f5e126b24d309789b2e9b06ae023', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/180f1c82cfdd4dbb93db6f7ee11ec39a.jpg', 1, '2022-04-10 09:22:22', '2022-04-10 09:22:22');
INSERT INTO `product_img` VALUES ('34c2a8404add4a3fb16c4d39a55a500b', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1338f8a29fa3484eaf02b3f1283ad555.jpg', 0, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('3f2aa5bfa3004ceaa3546a79f7c228e9', '896f9a6ffe534b2fad0b384a0d3d5484', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/edad57079a0d40beb7d76007eb423907.jpg', 0, '2022-04-11 09:29:22', '2022-04-11 09:29:22');
INSERT INTO `product_img` VALUES ('47f9f5702f10441a8caf3d7aff89d604', 'e9eb7726231744c88a8b072c4b8c785b', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/3ebb6cd364064cd999c4d9c7a07544d0.jpg', 0, '2022-04-10 09:32:02', '2022-04-10 09:32:02');
INSERT INTO `product_img` VALUES ('4c418c0cc9b945b1bb299096a492b6cf', '819abff4f09a4bd9b1b4d62c85336b52', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/20a716d5d9bc4fb18ec5689749329ec5.jpg', 0, '2022-04-10 09:41:45', '2022-04-10 09:41:45');
INSERT INTO `product_img` VALUES ('4e1735ba9a9642d1b07c2001aed2dcf6', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b8ecdbd1dc414afbb2fd115abf6b9e46.jpg', 0, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('558c916d8a164b46b8100c14c98b0b31', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1affc6e0685d4532933fd1022b84f59a.jpg', 1, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('562e2cae959c4c4b84da3c8b42f59b40', '164827fa79694a65815f766892185937', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/27d06044f02c46d1a5251c7a42ab3611.jpg', 0, '2022-04-10 09:39:16', '2022-04-10 09:39:16');
INSERT INTO `product_img` VALUES ('5aa4abdedc864418805ca5556f8a31d3', '8d968645dafb46a7a12df86070cbd089', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/de307df9640a4e65b7b749d0380a4d63.jpg', 0, '2022-04-10 09:14:36', '2022-04-10 09:14:36');
INSERT INTO `product_img` VALUES ('5b51b05ebfdb49ec842014df18ecf316', 'e9eb7726231744c88a8b072c4b8c785b', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/4d76d4792fd649ef951235b7cca53e5a.jpg', 0, '2022-04-10 09:32:02', '2022-04-10 09:32:02');
INSERT INTO `product_img` VALUES ('635095cc1a464e45a99b4697ad8d53a3', '6960e5c47a694347846fce20e80814c7', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e9cd2c0fb6df46f0b34782e42d4541fb.jpg', 1, '2022-04-10 09:46:14', '2022-04-10 09:46:14');
INSERT INTO `product_img` VALUES ('6b3aea0cb08445c3a2eb24a9775c916d', '8d968645dafb46a7a12df86070cbd089', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/c6a5230c635d4d41b028d6379446fbc6.jpg', 0, '2022-04-10 09:14:36', '2022-04-10 09:14:36');
INSERT INTO `product_img` VALUES ('6b96a6810ff240ccbd2d268d70c42fe3', '896f9a6ffe534b2fad0b384a0d3d5484', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/0c00240116134026b01dcc60c7b27f79.jpg', 0, '2022-04-11 09:29:22', '2022-04-11 09:29:22');
INSERT INTO `product_img` VALUES ('6f15595dffb44f719e933b13e81c74f3', '164827fa79694a65815f766892185937', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/99188576b86645459f4587bd1ed3fff1.jpg', 0, '2022-04-10 09:39:16', '2022-04-10 09:39:16');
INSERT INTO `product_img` VALUES ('729851c9ca7d4154a478b4c815b8d8bb', '8d968645dafb46a7a12df86070cbd089', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/c77a92b557224f8a8f1fef15de193448.jpg', 1, '2022-04-10 09:14:36', '2022-04-10 09:14:36');
INSERT INTO `product_img` VALUES ('770af69feb094c289ed579c38554eb83', 'c128342cdd264e62ad4902a759250a7e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/da870a3dc8024345b84f185b4299e64d.jpg', 0, '2022-04-10 09:48:48', '2022-04-10 09:48:48');
INSERT INTO `product_img` VALUES ('79119ea6e27a4b6ab9da9ac0fef85d61', '841ffcec23244384b3a4f6fc9203e585', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/ff8d0235fe3148428016dce85c311059.jpg', 0, '2022-04-10 09:34:54', '2022-04-10 09:34:54');
INSERT INTO `product_img` VALUES ('7af3b9b18805495f9526565b92427ada', '445bfa4452e64aa49903346ab8ebf41a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/477f993882de4a2aaaa545ae2a46f0a9.jpg', 0, '2022-04-10 10:10:25', '2022-04-10 10:10:25');
INSERT INTO `product_img` VALUES ('7c42e22a655540ab9ba0347c52c2a3eb', 'c859ce11ff4d4c6b8a5e6e97fd3f5a64', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/4a3e2c445d584442a210db359ee5c592.jpg', 0, '2022-04-10 10:01:40', '2022-04-10 10:01:40');
INSERT INTO `product_img` VALUES ('7eb269b0b5d546bcb68dde3f28f3e48d', 'b73b4a145d5d443cbcdacea2cd2f606d', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/683c209f9b04414497c9dd328d660859.jpg', 0, '2022-04-10 10:04:30', '2022-04-10 10:04:30');
INSERT INTO `product_img` VALUES ('7fa0614b48374816a55e0f96ab8bd978', 'ab073ac5e39544b6854297420208c3ff', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/2d47ba71f0794ac89f0df60de8ef7441.jpg', 0, '2022-04-10 09:02:40', '2022-04-10 09:02:40');
INSERT INTO `product_img` VALUES ('81476b9da2d4492da8eaecc6b9e3b04b', '9c079f06f67148acbb0940f77018f0bd', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/7438e7185b9e4c168511a2e0c2a67ee6.jpg', 0, '2022-04-10 09:44:10', '2022-04-10 09:44:10');
INSERT INTO `product_img` VALUES ('824081dd9d204741b2c2f5f35aa02989', 'ab073ac5e39544b6854297420208c3ff', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/3a890d8a7adb455ead8a81ccfccf117d.jpg', 1, '2022-04-10 09:02:40', '2022-04-10 09:02:40');
INSERT INTO `product_img` VALUES ('839cfb552cc24f05b7269e6226f8c9e9', '6960e5c47a694347846fce20e80814c7', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/5f6a4795b38d404b8e32f1885339705d.jpg', 0, '2022-04-10 09:46:14', '2022-04-10 09:46:14');
INSERT INTO `product_img` VALUES ('873dec77054047358d17f20329b4e455', '9c079f06f67148acbb0940f77018f0bd', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b82f39e84b114680a13db9fd8cd40c71.jpg', 0, '2022-04-10 09:44:10', '2022-04-10 09:44:10');
INSERT INTO `product_img` VALUES ('87ce58e2e7b247d9ba319bc81e6338ca', '0cd6d9aaf7474e49a03cc0b0355383f4', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-22/91ce408c8c7949c890167b3ae5552a3d.jpg', 0, '2022-04-22 08:13:36', '2022-04-22 08:13:36');
INSERT INTO `product_img` VALUES ('89df30c1874e41d0a0a6375b15a3bc39', '6960e5c47a694347846fce20e80814c7', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/5d5e3407103646ff8dfe437d6d031c33.jpg', 0, '2022-04-10 09:46:14', '2022-04-10 09:46:14');
INSERT INTO `product_img` VALUES ('8dd362c429d1487fa3d47d244b7362d1', '819abff4f09a4bd9b1b4d62c85336b52', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/37339077c0aa48d984a2b67bf92e8ce1.jpg', 0, '2022-04-10 09:41:45', '2022-04-10 09:41:45');
INSERT INTO `product_img` VALUES ('8eadbf9f0f8a4dd4b8a4f02cae31dcb2', '8bc179e518004acc9dee26296bce4734', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/afa2a68cc7de48f0957b7eb4d9c59906.jpg', 0, '2022-04-10 10:07:11', '2022-04-10 10:07:11');
INSERT INTO `product_img` VALUES ('8f540a09adde454dabc3b5cf2bbf5f81', '841ffcec23244384b3a4f6fc9203e585', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/ce83e9847602444d84688e15b6ad5dc0.jpg', 0, '2022-04-10 09:34:54', '2022-04-10 09:34:54');
INSERT INTO `product_img` VALUES ('8f8fc74a4e554f0684ef41d2ffd4f4e3', '445bfa4452e64aa49903346ab8ebf41a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/a2f792e3e875486e86160711fc3afcfa.jpg', 0, '2022-04-10 10:10:25', '2022-04-10 10:10:25');
INSERT INTO `product_img` VALUES ('8fe7b186346b4e4399d3503a5886e21e', '6960e5c47a694347846fce20e80814c7', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/4aa5c363d63c45a7b14a8a63bc982e74.jpg', 0, '2022-04-10 09:46:14', '2022-04-10 09:46:14');
INSERT INTO `product_img` VALUES ('9122256b432a499ba23acc0858317515', '0cd6d9aaf7474e49a03cc0b0355383f4', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-22/29dd22bee17a45e9bb919dbb45f1abc4.jpg', 0, '2022-04-22 08:13:36', '2022-04-22 08:13:36');
INSERT INTO `product_img` VALUES ('92fb7710042e4462b951f21a59d26546', 'd8f30ba828bf4b79b9aebee38c8ca4e6', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/c7fae260e7ec4597a564ebc7a25a6c5c.jpg', 0, '2022-04-10 09:28:45', '2022-04-10 09:28:45');
INSERT INTO `product_img` VALUES ('931f9d9ea2b8489bb90c0a0a709dcb3c', '8bc179e518004acc9dee26296bce4734', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1e7ba79026f84b4d9f3e7d57e13525d3.jpg', 1, '2022-04-10 10:07:11', '2022-04-10 10:07:11');
INSERT INTO `product_img` VALUES ('99f6a3eed0d94445ac72be713d5e363a', '8bc179e518004acc9dee26296bce4734', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/dd3cc66b8d2e491c8ee580fb47755be2.jpg', 0, '2022-04-10 10:07:11', '2022-04-10 10:07:11');
INSERT INTO `product_img` VALUES ('9a1bf5172443481cbc25b46ae0110f4a', 'aef5a49df39c424789464582e36d7a44', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b6492d6b681641158e4a2725e8c0ebd4.jpg', 0, '2022-04-10 09:56:18', '2022-04-10 09:56:18');
INSERT INTO `product_img` VALUES ('9c6c38e6e2914d41939cc226e2208bc2', 'aef5a49df39c424789464582e36d7a44', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/dda0bd5640d14310a40c1256825dc4ab.jpg', 0, '2022-04-10 09:56:18', '2022-04-10 09:56:18');
INSERT INTO `product_img` VALUES ('9c7598805d434f0ca2008b4608f540a8', 'c1d6f5e126b24d309789b2e9b06ae023', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/4432cd57b5aa495d8e01027e3270f5e9.jpg', 0, '2022-04-10 09:22:22', '2022-04-10 09:22:22');
INSERT INTO `product_img` VALUES ('a76fc309b04f4de7b5df6dfd1ac91ed8', 'd8f30ba828bf4b79b9aebee38c8ca4e6', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/221f9a1792164718b7c46d4eea8bb169.jpg', 1, '2022-04-10 09:28:45', '2022-04-10 09:28:45');
INSERT INTO `product_img` VALUES ('ac68a45bf73e4b47b387e5e05f98475d', '896f9a6ffe534b2fad0b384a0d3d5484', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/070f1e59b6b44b91b0e942333186a5a3.jpg', 1, '2022-04-11 09:29:22', '2022-04-11 09:29:22');
INSERT INTO `product_img` VALUES ('af5c60273ece4f3791c53c213da768d4', 'e9eb7726231744c88a8b072c4b8c785b', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/34ae5ac939194af5b19a57f77ea891dc.jpg', 1, '2022-04-10 09:32:02', '2022-04-10 09:32:02');
INSERT INTO `product_img` VALUES ('b0a73cd9a0414ee5be92e57e883fa1b9', 'd8f30ba828bf4b79b9aebee38c8ca4e6', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e14997d1cc334a0297b93239beb0a308.jpg', 0, '2022-04-10 09:28:45', '2022-04-10 09:28:45');
INSERT INTO `product_img` VALUES ('b2b961f57921455192690af3a89abb79', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e313573412e74c5f9f76320bf46e71d8.jpg', 0, '2022-04-10 10:14:30', '2022-04-10 10:14:30');
INSERT INTO `product_img` VALUES ('b316bc9aa5824a47a3a6cc296a9e92b9', 'd8f30ba828bf4b79b9aebee38c8ca4e6', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/f10e864015124437a257b23cc1b9d536.jpg', 0, '2022-04-10 09:28:45', '2022-04-10 09:28:45');
INSERT INTO `product_img` VALUES ('b7054d0d7c2547c1903d5978e1d41a98', 'e1e8c9b1424c41919a13840a131b547a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b8ecdbd1dc414afbb2fd115abf6b9e46.jpg', 0, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('b8862eb3103c461580311e5e1444308b', 'c128342cdd264e62ad4902a759250a7e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1d1b9540f42a4e7e97312d9e81e628ba.jpg', 0, '2022-04-10 09:48:48', '2022-04-10 09:48:48');
INSERT INTO `product_img` VALUES ('c050db20e1e34a1885d025b50f8e93c7', 'b73b4a145d5d443cbcdacea2cd2f606d', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b40792fd75aa48d2a4e64b8768c78876.jpg', 0, '2022-04-10 10:04:30', '2022-04-10 10:04:30');
INSERT INTO `product_img` VALUES ('c295675cee6343f7852dd0a8e83438b0', 'bddca0c9f7e94c96a0ecf24ea81c344e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/3855f40a2b3743c18c79eb0722d70c64.jpg', 1, '2022-04-11 09:26:42', '2022-04-11 09:26:42');
INSERT INTO `product_img` VALUES ('c329fe09f6174613b1475fbde3442e80', 'b73b4a145d5d443cbcdacea2cd2f606d', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/7f358ca1c8114804b7c4436aa379c71e.jpg', 0, '2022-04-10 10:04:30', '2022-04-10 10:04:30');
INSERT INTO `product_img` VALUES ('c3cc857293744977ab5bad6d29cab430', '0cd6d9aaf7474e49a03cc0b0355383f4', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-22/4eb501bab3034eaca07ea5369fc1f2cc.jpg', 0, '2022-04-22 08:13:36', '2022-04-22 08:13:36');
INSERT INTO `product_img` VALUES ('c48e870992444a6b9d35ea1c1f8e8c38', '164827fa79694a65815f766892185937', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/c5cdfb4344dc40d8b68deb1adf75f7b3.jpg', 0, '2022-04-10 09:39:16', '2022-04-10 09:39:16');
INSERT INTO `product_img` VALUES ('c67150cb237e4c5e917656774b60ab97', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b8ecdbd1dc414afbb2fd115abf6b9e46.jpg', 0, '2022-04-10 10:14:30', '2022-04-10 10:14:30');
INSERT INTO `product_img` VALUES ('c8598dad17814d8e94733bba76821fd0', '841ffcec23244384b3a4f6fc9203e585', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/4938230413eb457886d449ab48f6f022.jpg', 0, '2022-04-10 09:34:54', '2022-04-10 09:34:54');
INSERT INTO `product_img` VALUES ('cc81d8b040ce45ebb007f45cd8cf8c2a', '0041bfecf6b04a09bb1c36e66404d9c5', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e18d06508fae4a198fa005b9729d5823.jpg', 0, '2022-04-10 09:58:12', '2022-04-10 09:58:12');
INSERT INTO `product_img` VALUES ('cdf9b30a206b42df9dcd96e922aa0db0', 'b73b4a145d5d443cbcdacea2cd2f606d', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/32b8ee318b2a435c9e60cf0104f97898.jpg', 1, '2022-04-10 10:04:30', '2022-04-10 10:04:30');
INSERT INTO `product_img` VALUES ('d28312f5307844e7828b31752a466589', '0041bfecf6b04a09bb1c36e66404d9c5', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/da9627b146654391aecc0dfb313f0a10.jpg', 0, '2022-04-10 09:58:12', '2022-04-10 09:58:12');
INSERT INTO `product_img` VALUES ('d2d4cab3c4ed425ebb6c2146880ad908', '896f9a6ffe534b2fad0b384a0d3d5484', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/f81bcc8ea53b4a35b50e4516db1daf15.jpg', 0, '2022-04-11 09:29:22', '2022-04-11 09:29:22');
INSERT INTO `product_img` VALUES ('d73f31a2151d403d92d0830f124330ef', 'bddca0c9f7e94c96a0ecf24ea81c344e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/7b3a4d405dc348719e423a38a0ce323b.jpg', 0, '2022-04-11 09:26:42', '2022-04-11 09:26:42');
INSERT INTO `product_img` VALUES ('d9d0426407ff40a2a8d4d448de12e88f', 'ab073ac5e39544b6854297420208c3ff', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/8522dad7c37f496e9a9825a701c54447.jpg', 0, '2022-04-10 09:02:40', '2022-04-10 09:02:40');
INSERT INTO `product_img` VALUES ('dc04d2fa6126459786cc8162156346cd', '445bfa4452e64aa49903346ab8ebf41a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/b2c609c004b54d998222f64d90c7ecd3.jpg', 0, '2022-04-10 10:10:25', '2022-04-10 10:10:25');
INSERT INTO `product_img` VALUES ('dc9126845dec4f68be650a667ce643ab', 'c1d6f5e126b24d309789b2e9b06ae023', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/11e9d786488943af90d57a25cdbb1335.jpg', 0, '2022-04-10 09:22:22', '2022-04-10 09:22:22');
INSERT INTO `product_img` VALUES ('de3e326bf43e46fa91e22206cc171378', 'c859ce11ff4d4c6b8a5e6e97fd3f5a64', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/7b792d0878d84296bad3fe8c2bb9242c.jpg', 1, '2022-04-10 10:01:40', '2022-04-10 10:01:40');
INSERT INTO `product_img` VALUES ('df534df83f6647cb98fb9b9673bdc94b', '8bc179e518004acc9dee26296bce4734', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/ca76a61f442d4f9797626e1abb2d4001.jpg', 0, '2022-04-10 10:07:11', '2022-04-10 10:07:11');
INSERT INTO `product_img` VALUES ('dfc9e24e45124c3381bf88d65138b600', '841ffcec23244384b3a4f6fc9203e585', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/6de654955720488da70b526215a5e020.jpg', 1, '2022-04-10 09:34:54', '2022-04-10 09:34:54');
INSERT INTO `product_img` VALUES ('e3f5767fbc0b481e9c50047002a98dd5', '8d968645dafb46a7a12df86070cbd089', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/c10942736c474df18ef9db5fb53aaf20.jpg', 0, '2022-04-10 09:14:36', '2022-04-10 09:14:36');
INSERT INTO `product_img` VALUES ('e5e23479458b4b0c82f44f9e12c780e6', '9c079f06f67148acbb0940f77018f0bd', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/5d79ee5df17948ccbe042eaa89a2a79e.jpg', 1, '2022-04-10 09:44:10', '2022-04-10 09:44:10');
INSERT INTO `product_img` VALUES ('e8e33adc0ba14a08a307710e2dc6e968', '0041bfecf6b04a09bb1c36e66404d9c5', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/6674be74b0174e0bad34f2c850275fe7.jpg', 1, '2022-04-10 09:58:12', '2022-04-10 09:58:12');
INSERT INTO `product_img` VALUES ('eb9496d10f464c84acbe2824c89c9896', 'bddca0c9f7e94c96a0ecf24ea81c344e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/e231b3b9fd7d4539b6385743a369aeac.jpg', 0, '2022-04-11 09:26:42', '2022-04-11 09:26:42');
INSERT INTO `product_img` VALUES ('eef92f55eed9499c9e418255ac825e6d', 'e1e8c9b1424c41919a13840a131b547a', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e313573412e74c5f9f76320bf46e71d8.jpg', 0, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('ef07e01b56bd4c07bde0e0bd83e54709', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1affc6e0685d4532933fd1022b84f59a.jpg', 1, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('f15940fd1a7f4f36b7ccdb30771d4cf0', '164827fa79694a65815f766892185937', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/fa6b77659c504d68be857dd311e10577.jpg', 1, '2022-04-10 09:39:16', '2022-04-10 09:39:16');
INSERT INTO `product_img` VALUES ('f2ce5f07825a4169a182930ddaf04d70', 'c128342cdd264e62ad4902a759250a7e', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e50f75fa745648dba38b853c32da7c7c.jpg', 1, '2022-04-10 09:48:48', '2022-04-10 09:48:48');
INSERT INTO `product_img` VALUES ('f4cfbb43732047a8a4bfadaf5eed6a3b', '819abff4f09a4bd9b1b4d62c85336b52', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/2524d657634548ba9f791a166fea7103.jpg', 1, '2022-04-10 09:41:45', '2022-04-10 09:41:45');
INSERT INTO `product_img` VALUES ('faea82e1a2054668904a60ef0a1eb228', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/e313573412e74c5f9f76320bf46e71d8.jpg', 0, '2022-04-10 10:14:29', '2022-04-10 10:14:29');
INSERT INTO `product_img` VALUES ('ffcc90242c2c470aa0e0c07968391c09', '1cdd54daf0cd402abb1a4cb48cb36c7c', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-10/1338f8a29fa3484eaf02b3f1283ad555.jpg', 0, '2022-04-10 10:14:30', '2022-04-10 10:14:30');

-- ----------------------------
-- Table structure for soldrecord
-- ----------------------------
DROP TABLE IF EXISTS `soldrecord`;
CREATE TABLE `soldrecord`  (
  `out_trade_no` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `product_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subject` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `body` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `total_amount` double(10, 2) NOT NULL,
  `gmt_create` datetime NULL DEFAULT NULL,
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `solder_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `trade_status` int(1) NOT NULL,
  `gmt_payment` datetime NULL DEFAULT NULL,
  `gmt_refund` datetime NULL DEFAULT NULL,
  `gmt_close` datetime NULL DEFAULT NULL,
  `address_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`out_trade_no`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of soldrecord
-- ----------------------------
INSERT INTO `soldrecord` VALUES ('0a843c60883441a89df66f81f81d8228', 'e1e8c9b1424c41919a13840a131b547a', 'Giant Trance 3 林道 Enduro 自行车Gi', 'ant Trance 3 软尾 林道 速降 越野 AM FR 山地车\n我感觉比Reign 性价比高\n尺码：S 3 相当于M\n成色：99新\n发票 所有一切 都齐全', 7999.00, '2022-04-11 09:47:14', 'd34251f755934b37bb5b05bfcb5ecf61', '9c6da44758c14ebcb9f545234b2d6559', 1, NULL, NULL, NULL, '30f41ec54e43466dbce2c3dea32ddc39');
INSERT INTO `soldrecord` VALUES ('d0b363e6b164496b9aceef4d328872b3', 'c1d6f5e126b24d309789b2e9b06ae023', '95新苹果 ipad mini2  国行 WIFI版 16G', '【关于电池】 原装电池  电池效率86%\n【系统版本】 12.5.5 \n【关于赠品】 送充电器＋数据线\n【发货时间】 付款后24小时内发货\n【关于售后】 保修一年，支持7天内质量问题退换货。防拆标保留好，撕毁默认私自拆机，不支持退货及质保服务。', 599.00, '2022-04-22 08:29:39', 'bf0ac345eb344a5e9ed031dcac30f289', '9c6da44758c14ebcb9f545234b2d6559', 3, NULL, NULL, NULL, '0a9e542ed0ac49cb85e412d65e4ef0cd');
INSERT INTO `soldrecord` VALUES ('fab538c466ff4464950356ab3e915d63', 'e9eb7726231744c88a8b072c4b8c785b', 'OPPO A32 4G+128G 9新 OPPO二手手机', '此机器购买的日期是2021年3月6号，电池正常，收货后可享受365天维修质保服务', 679.00, '2022-04-22 07:48:36', 'bf0ac345eb344a5e9ed031dcac30f289', '9c6da44758c14ebcb9f545234b2d6559', 1, NULL, NULL, NULL, '0a9e542ed0ac49cb85e412d65e4ef0cd');

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `user_id` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `user_name` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `mobile_phone` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `sex` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `user_status` int(1) NOT NULL,
  `create_time` datetime NOT NULL,
  `role` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sign` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES ('09591ac502be4d80b0d3ac2d954832a3', 'hello', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, NULL, NULL, 0, '2022-04-11 11:55:49', '普通用户', NULL);
INSERT INTO `user_info` VALUES ('9c6da44758c14ebcb9f545234b2d6559', 'solder', 'e10adc3949ba59abbe56e057f20f883e', NULL, NULL, 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-22/948d141bc51d4b41ae77d8bab12fb3bf.jpg', NULL, 1, '2022-04-10 09:00:34', '普通用户', NULL);
INSERT INTO `user_info` VALUES ('bf0ac345eb344a5e9ed031dcac30f289', 'admin', '21232f297a57a5a743894a0e4a801fc3', NULL, NULL, 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-22/282957e4b1c541b7be5a03e52508a1f9.jpg', NULL, 1, '2022-03-04 23:11:38', '超级管理员', NULL);
INSERT INTO `user_info` VALUES ('d34251f755934b37bb5b05bfcb5ecf61', 'lgx', '123456', '123456789', '1276865354@qq.com', 'https://xiaoliang-campous.oss-cn-beijing.aliyuncs.com/campous_shop/2022-04-11/e2974b0a08624a629057b1cc9cc3f58f.jpg', NULL, 1, '2022-04-07 23:11:47', '普通用户', '仗剑走天涯');

SET FOREIGN_KEY_CHECKS = 1;

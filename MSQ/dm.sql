#设置客户端连接服务器端编码
SET NAMES UTF8;
#丢弃数据库
DROP DATABASE IF EXISTS dm;
#创建数据库
CREATE DATABASE dm CHARSET=UTF8;
#进入数据库
USE dm;
#创建数据表

# 商品类别表
CREATE TABLE dm_laptop_family(		
	fid INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(32)		# 类别名称
);
# 商品类别详情表
CREATE TABLE dm_laptop_family_list(
	flid INT PRIMARY KEY AUTO_INCREMENT,
	lfamily_id INT,			# 所属家族编号
	lproduct_id INT,		# 产品编号
	lname VARCHAR(32)		# 详细类别名称
);
# 商品表
CREATE TABLE dm_laptop(			
	lid INT PRIMARY KEY AUTO_INCREMENT,
	family_id INT,			# 所属家族编号
	list_product_id INT,		# 所属产品编号
	product_id INT,			# 产品编号
	title VARCHAR(128),		# 主标题
	subtitle VARCHAR(128),		# 副标题
	price DECIMAL(10,2),		# 价格
	promise	VARCHAR(64),		# 服务承诺
	spec VARCHAR(64),		# 规格/颜色
	name VARCHAR(32),		# 商品名称
	details VARCHAR(1024),		# 商品详细说明
	shelf_time INT,			# 上架时间
	sold_count INT,			# 已售数量
	is_onsale BOOLEAN		# 是否促销中
);
# 商品详情图表
CREATE TABLE dm_laptop_pic(		
	pid INT PRIMARY KEY AUTO_INCREMENT,
	laptop_id INT,			# 商品编号
	sm VARCHAR(128),		# 小图片路径
	md VARCHAR(128),		# 中图片路径
	lg VARCHAR(128)			# 大图片路径
);
# 用户列表
CREATE TABLE dm_user(			
	uid INT PRIMARY KEY AUTO_INCREMENT,
	dname VARCHAR(32),
	upwd VARCHAR(32),
	email VARCHAR(64),
	phone VARCHAR(16) UNIQUE,
	avatar VARCHAR(128),		# 头像图片路径
	user_name VARCHAR(32),		# 用户名,如鲁智深
	gender INT			# 性别,0-女  1-男
);
# 收货地址表
CREATE TABLE dm_receiver_address(	
	aid INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,			# 用户编号
	receiver VARCHAR(16),		# 接收人姓名
	province VARCHAR(16),		# 省
	city VARCHAR(16),		# 城市
	county VARCHAR(16),		# 县
	address	VARCHAR(128),		# 详细地址
	cellphong VARCHAR(16),		# 手机
	fixedphone VARCHAR(16),		# 固定电话
	postcode CHAR(6),		# 邮编
	tap VARCHAR(16),		# 标签名
	is_default BOOLEAN		# 是否为当前用户的默认收货地址
);
# 用户购物车表
CREATE TABLE dm_shopping_cart(		
	cid INT PRIMARY KEY AUTO_INCREMENT,
	uid INT,			# 用户编号
	product INT,			# 商品编号
	count INT			# 商品数量
);
# 用户订单表状态
CREATE TABLE dm_order(			
	aid INT PRIMARY KEY AUTO_INCREMENT,
	user_id INT,			# 用户编号
	address_id INT,			
	status INT,			# 订单状态 1-等待付款 2-等待付款 3-运输中 4-已签收 5-已取消
	order_time BIGINT,		# 下单时间
	pay_time BIGINT,		# 付款时间
	deliver_time BIGINT,		# 发货时间
	received_time BIGINT		# 签收时间
);
# 用户订单详情表
CREATE TABLE dm_order_detail(		
	did INT PRIMARY KEY AUTO_INCREMENT,	
	order_id INT,			# 订单编号
	product_id INT,			# 商品编号
	count INT			# 购买数量
);
# 轮播图表
CREATE TABLE dm_index_carousel(		
	cid INT PRIMARY KEY AUTO_INCREMENT,
	img VARCHAR(128),		# 图片路径
	title VARCHAR(64),		# 图片描述
	href VARCHAR(128)		# 图片链接
);
# 首页商品栏
CREATE TABLE dm_index_product(		
	pid INT PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(64),		# 商品标题
	details VARCHAR(128),		# 详情描述
	pic VARCHAR(128),		# 图片
	price DECIMAL(10,2),		# 商品价格
	href VARCHAR(128),
	seq_recommended TINYINT,
	seq_new_arrival TINYINT,
	seq_top_sale TINYINT
);
/*******************/
/******数据导入******/
/*******************/
/**商品类别表**/
INSERT INTO dm_laptop_family VALUES
(NULL,"蔬菜蛋品"),
(NULL,"精品肉类"),
(NULL,"放心粮油"),
(NULL,"海鲜水产"),
(NULL,"新鲜水果"),
(NULL,"冻品速食"),
(NULL,"香料调味");

/**商品类别详情表**/
INSERT INTO dm_laptop_family_list VALUES
(NULL,1,1,"叶菜类"),
(NULL,1,2,"根茎类"),
(NULL,1,3,"芽菌类"),
(NULL,1,4,"果茄瓜"),
(NULL,1,5,"葱姜蒜"),
(NULL,1,6,"蛋类"),
(NULL,1,7,"豆制品"),

(NULL,2,1,"猪肉"),
(NULL,2,2,"鸡肉"),
(NULL,2,3,"羊肉"),
(NULL,2,4,"牛肉"),
(NULL,2,5,"鸭肉"),
(NULL,2,6,"其他"),

(NULL,3,1,"花生油"),
(NULL,3,2,"玉米油"),
(NULL,3,3,"芝麻油"),
(NULL,3,4,"大豆油"),
(NULL,3,5,"调和油"),
(NULL,3,6,"菜籽油"),
(NULL,3,7,"橄榄油"),
(NULL,3,8,"茶油"),
(NULL,3,9,"麻油"),

(NULL,4,1,"鱼类"),
(NULL,4,2,"虾类"),
(NULL,4,3,"蟹类"),
(NULL,4,4,"贝类"),
(NULL,4,5,"海产干货"),
(NULL,4,6,"其他"),

(NULL,5,1,"时令鲜果"),
(NULL,5,2,"热销水果"),
(NULL,5,3,"热带水果"),
(NULL,5,4,"奇香异果"),

(NULL,6,1,"火锅丸子"),
(NULL,6,2,"速冻肉类"),
(NULL,6,3,"烘焙食品"),
(NULL,6,4,"甜品饮品"),
(NULL,6,5,"其他速食"),

(NULL,7,1,"调味品"),
(NULL,7,2,"椒类"),
(NULL,7,3,"大料类"),
(NULL,7,4,"酱类"),
(NULL,7,5,"其他");

/**商品表**/
INSERT INTO dm_laptop VALUES
(1,1,1,1,"散叶生菜","新鲜 有机生菜",10.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","批发生菜","周口合作社直供",150123456789,2000,true),
(2,1,1,2,"西蓝花","新鲜 有机花菜",11.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机花菜","天欣合作社直供",150123456789,2000,true),
(3,1,1,3,"芹菜","新鲜 有机芹菜",13.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机芹菜","天欣合作社直供",150123456789,2000,true),
(4,1,1,4,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,2000,true),

(5,1,2,1,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,3000,true),
(6,1,2,2,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,1580,true),
(7,1,2,3,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,1400,true),
(8,1,2,4,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,1880,true),

(9,1,3,1,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,2100,true),
(10,1,3,2,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,2300,true),
(11,1,3,3,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,2200,true),
(12,1,3,4,"韭菜","新鲜 有机韭菜",15.00,"*退货补运费 *48小时快速退款 *12小时发货 *放心购","500g/当天采摘","有机韭菜","天欣合作社直供",150123456789,2500,true);

/**用户信息**/
INSERT INTO dm_user VALUES
(NULL, 'dingding', '123456', 'ding@qq.com', '13501234567', 'img/avatar/default.png', '丁伟', '1'),
(NULL, 'dangdang', '123456', 'dang@qq.com', '13501234568', 'img/avatar/default.png', '林当', '1'),
(NULL, 'doudou', '123456', 'dou@qq.com', '13501234569', 'img/avatar/default.png', '窦志强', '1'),
(NULL, 'yaya', '123456', 'ya@qq.com', '13501234560', 'img/avatar/default.png', '秦小雅', '0');










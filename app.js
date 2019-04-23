//创建服务器
const express=require("express");
const server=express();
server.listen(8080);
//连接路由器
const userRouter=require("./routers/user.js");
const bodyParser=require("body-parser");
//托管静态资源
server.use(express.static("public"));
//获取数据
server.use(bodyParser.urlencoded({
	extended:false
}));
//挂载路由器
server.use("/user",userRouter);
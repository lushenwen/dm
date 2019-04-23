//创建路由器
const express=require("express");
const router=express.Router();
//导入连接池
const pool=require("../pool.js");
//创建注册路由器 post reg
router.post("/reg",(req,res)=>{
	var obj=req.body;
	for(var key in obj){
		if(!obj[key]){
			res.send(key+"不能为空");
			return;
		}
	}
	var sql="insert into dm_user set ?";
	pool.query(sql,[obj],(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			res.send("注册成功");
		}else{
			res.send("注册失败");
		}
	});
});
//创建登录路由 post login
router.post("/login",(req,res)=>{
	var obj=req.body;
	for(var key in obj){
		if(!obj[key]){
			res.send(key+"不能为空");
			return;
		}
	}
	var sql="select * from dm_user where dname=? and upwd=?";
	pool.query(sql,[obj.dname,obj.upwd],(err,result)=>{
		if(err) throw err;
		if(result.length>0){
			res.send("登录成功");
		}else{
			res.send("登录失败");
		}
	});
});
//创建用户清单管理表 get list
router.get("/list",(req,res)=>{
	var sql="select*from dm_user";
	pool.query(sql,(err,result)=>{
		if(err)throw err;
		res.send(result);
	});
});
//用户删除路由get del
router.get("/del",(req,res)=>{
	var obj=req.query;
	if(!obj.uid){
		res.send("编号不能为空");
		return;
	}
	var sql="delete from dm_user where uid=?";
	pool.query(sql,[obj.uid],(err,result)=>{
		if(err) throw err;
		if(result.affectedRows>0){
			res.send("删除成功");
		}else{
			res.send("删除失败");
		}
	});
});
//查询用户详情路由get sel
router.get("/sel",(req,res)=>{
	var obj=req.query;
	if(!obj.uid){
		res.send("编号不能为空");
		return;
	}
	var sql="select * from dm_user where uid=?";
	pool.query(sql,[obj.uid],(err,result)=>{
		if(err) throw err;
		res.send(result[0]);
	});
});
//创建修改路由 post update
router.post("/update",(req,res)=>{
	var obj=req.body;
	for (var key in obj){
		if(!obj[key]){
			res.send(key+"为空");
			return;
		}
	}
	var sql="update dm_user set dname=?,upwd=?,email=?,user_name=?,phone=?,gender=? where uid=?";
	pool.query(sql,[obj.dname,obj.upwd,obj.email,obj.user_name,obj.phone,obj.gender,obj.uid],(err,result)=>{
		if(err)throw err;
		if(result.affectedRows>0){
			res.send("修改成功");
		}else{
			res.send("修改失败");
		}
	});
})

//导出路由器
module.exports=router;
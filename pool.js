//创建连接池
const mysql=require("mysql");
const pool=mysql.createPool({
	host:"127.0.0.1",
	port:"3306",
	user:"root",
	password:"",
	database:"dm",
	connectionLimit:15
});
//导出连接池
module.exports=pool;
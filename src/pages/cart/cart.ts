import { Component } from '@angular/core';
import { IonicPage, NavController, NavParams } from 'ionic-angular';
import { HttpClient } from '@angular/common/http';
import { LoginPage } from '../login/login';

/**
 * Generated class for the CartPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-cart',
  templateUrl: 'cart.html',
})
export class CartPage {
  myList = [] //保存的是成功获取到的购物车列表
  isAllSelected = false //记录的是否选中了全选

  constructor(
    private myHttp:HttpClient,
    public navCtrl: NavController, public navParams: NavParams) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad CartPage');  
  }

  ionViewWillEnter(){
    //请求购物车列表
    var url = "http://localhost:8080/cart/list";

    this.myHttp
     .get(url,{withCredentials:true}).subscribe((result:any)=>{
       console.log(result)
       if(result.code == 300){
         this.navCtrl.push(LoginPage)
       }else if(result.code == 200){
         console.log('购物车列表获取成功',result)
        //  (:- 17:45)
         //保存result.data 到视图中显示（购物车中有数据和无数据，分为两种情况来显示）
         this.myList = result.data
         //遍历this.myList数组，给每一个对象添加一个属性isSelected来记录是否被选中
         for(var i=0;i<this.myList.length;i++){
           this.myList[i].isSelected=false
         }

       }
     })
  }
  
  // 当全选的复选框被操作的时候，来执行该方法
  operateAll(){
    //将购物车每一个商品的isSelected修改为全选的复选框的是否选中
    for(var i=0;i<this.myList.length;i++){
      this.myList[i].isSelected = this.isAllSelected
    }
  }
  // 操作了购物车列表的某一个商品的复选框，要执行的方法
  operateSingle(){
    // 遍历购物车的每一个商品，做一个逻辑与运算，将最终的结果 赋值给this.isAllSelected
    var result = true
    for(var i=0;i<this.myList.length;i++){
      result = 
       result&&this.myList[i].isSelected
    }
    this.isAllSelected = result
  }

  // 计算被选中的商品总价格
  calcAll(){
    var totalPrice = 0
    for(var i=0;i<this.myList.length;i++){
      if(this.myList[i].isSelected){
        //单价乘以数量
        totalPrice += (this.myList[i].price*this.myList[i].count)
      }
    }
    return totalPrice
  }

}

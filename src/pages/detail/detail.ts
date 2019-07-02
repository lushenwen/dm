import { Component, ViewChild } from '@angular/core';
import { ToastController,IonicPage, NavController, NavParams, Slides} from 'ionic-angular';
import {HttpClient} from '@angular/common/http'
import { NotFoundPage } from '../not-found/not-found';
import { CartPage } from '../cart/cart';
import { LoginPage } from '../login/login';

/**
 * Generated class for the DetailPage page.
 *
 * See https://ionicframework.com/docs/components/#navigation for more info on
 * Ionic pages and navigation.
 */

@IonicPage()
@Component({
  selector: 'page-detail',
  templateUrl: 'detail.html',
})
export class DetailPage {
  @ViewChild(Slides)
  slides:Slides
  id = 0
  myList = []//picList
  myPrice = 0 //price
  myTitle = "" //title
  mySubTitle = "" //subtitle

  constructor(
    private toastCtrl:ToastController,
    private myHttp:HttpClient,
    public navCtrl: NavController, public navParams: NavParams) {
  }

  ionViewDidLoad() {
    console.log('ionViewDidLoad DetailPage');
    //接收路由跳转时通过id所传来的值
    this.id = this.navParams.get('id')
    console.log("收到的值是"+this.id)
    // 请求id对应的详情数据
    var url = " http://localhost:8080/product/detail?lid="+this.id

    this.myHttp.get(url)
      .subscribe((result:any)=>{
        console.log(result)
        //result.details.price/picList/title/subtitle
        this.myPrice = result.details.price;
        this.myList = result.details.picList;
        this.myTitle = result.details.title;
        this.mySubTitle = result.details.subtitle;
      })
    // 保存
    // 显示
  }

  jump404(){
    this.navCtrl.push(NotFoundPage)
  }

  jumpCart(){
    this.navCtrl.push(CartPage)
  }

  addToCart(){
    var url = "http://localhost:8080/cart/add?buyCount=1&lid="+this.id

    this.myHttp.get(url,{withCredentials:true})
      .subscribe((result:any)=>{
        console.log(result)
        var msg = ""
        if(result.code == 300){
          msg = "您未登录"
          //跳转到login
          this.navCtrl.push(LoginPage)
        }else if(result.code == 200){
          msg = "添加到购物车成功"
        }
        //显示一个toast ToastController
        var myToast = this.toastCtrl.create({
          message:msg,
          duration:2000
        })
        myToast.present()
      })
  }
  ionViewDidEnter(){
    if(this.myList.length>1){
      this.slides.startAutoplay();
    }
  }
  ionViewDidLeave(){
    if(this.myList.length>1){
      this.slides.stopAutoplay();
    }
  }

}

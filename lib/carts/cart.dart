
import 'package:flutter/cupertino.dart';
import 'package:food/carts/cart_product.dart';

class Cart extends ChangeNotifier{
  List<CartProduct> cartProduct = [];
  dynamic total = 0;

  add(CartProduct cartPro){
    this.cartProduct.add(cartPro);
    total += cartPro.counter * cartPro.product.price;
    notifyListeners();
  }

  getLength(){
    return this.cartProduct.length;
    
  }

  List<CartProduct> getList(){
    return this.cartProduct;
  }

  has(CartProduct pro){
    int status = 0;
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id){
        status = 1;
      }
    });

    if(status == 1){
      return true;
    }

    return false;
  }

  int getCount(CartProduct pro){
    int counter = 0;
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id){
        counter = element.counter;
      }
    });
    return counter;
  }

  updateProduct(CartProduct pro,int count){
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id){
        
        total -= element.counter * element.product.price;
        total += count * pro.product.price;
        element.counter = count;
      }
    });
    notifyListeners();
  }

  deleteProduct(CartProduct pro){
    this.cartProduct.forEach((element) {
      if(element.product.id == pro.product.id){
        total -= element.counter * element.product.price;
        this.cartProduct.remove(element);
        notifyListeners();
      }
    });
    
  }

  void delete(){
    this.cartProduct.clear();
    notifyListeners();
  }
}
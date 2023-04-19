function check_box_all_buy(){
	var checkbox_stay_checked = 'input[name="checked_goods_stay"]:checked';
	var stayboxs = document.querySelectorAll(checkbox_stay_checked);
	var checkboxStayArray = Array.from(stayboxs);
	
	var selectedStayValues = [];
	  checkboxStayArray.forEach(function(checkbox) {
		  selectedStayValues.push(checkbox.value);
	  });
	  
  	var checkbox_air_checked = 'input[name="checked_goods_air"]:checked';
	var airboxs = document.querySelectorAll(checkbox_air_checked);
	var checkboxAirArray = Array.from(airboxs);
	
	var selectedAirValues = [];
	  checkboxAirArray.forEach(function(checkbox) {
		  selectedAirValues.push(checkbox.value);
	  });
	  
	  
	  console.log(selectedStayValues);
	  console.log(selectedAirValues);
	  
 	var form = document.getElementById("myForm");
	var stayInput = form.querySelector('input[name="stay_values"]');
	var airInput = form.querySelector('input[name="air_values"]');
	stayInput.value = selectedStayValues.join(',');
	airInput.value = selectedAirValues.join(',');
	  
	// form 데이터 전송
	form.submit();
}

function delete_cart_goodsStay(cart_stay_id){
	var cart_stay_id=Number(cart_stay_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_stay_id";
	i_cart.value=cart_stay_id;
	alert("장바구니에서 상품을 삭제합니다.");
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="http://localhost:8080/helloworld/removeCartGoods.do";
    formObj.submit();
}

function delete_cart_goodsAir(cart_air_id){
	var cart_air_id=Number(cart_air_id);
	var formObj=document.createElement("form");
	var i_cart = document.createElement("input");
	i_cart.name="cart_air_id";
	i_cart.value=cart_air_id;
	alert("장바구니에서 상품을 삭제합니다.");
	
	formObj.appendChild(i_cart);
    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="http://localhost:8080/helloworld/removeCartGoodsAir.do";
    formObj.submit();
}

function fn_order_all_cart_goodsAir(){
	// for 항공상품
	var order_goods_qtyAir;
	var order_goods_idAir;
	var objFormAir=document.frm_order_all_cartAir;
	
	var cart_goods_qtyAir=objFormAir.cart_goods_qtyAir;	//
//	var h_order_each_goods_qtyAir=objFormAir.h_order_each_goods_qtyAir;	//
	var checked_goods_air=objFormAir.checked_goods_air;	//
	var lengthAir=checked_goods_air.length;	//
	
	//alert(length);
	if(lengthAir>1){
		for(var i=0; i<lengthAir;i++){
			if(checked_goods_air[i].checked==true){
				order_goods_idAir=checked_goods_air[i].value;
				order_goods_qtyAir=cart_goods_qtyAir[i].value;
				cart_goods_qtyAir[i].value="";
				cart_goods_qtyAir[i].value=order_goods_idAir+":"+order_goods_qtyAir;
				//alert(select_goods_qty[i].value);
				console.log(cart_goods_qtyAir[i].value);
			}
		}	
	}else{
		order_goods_idAir=checked_goods_air.value;
		order_goods_qtyAir=cart_goods_qtyAir.value;
		cart_goods_qtyAir.value=order_goods_idAir+":"+order_goods_qtyAir;
		//alert(select_goods_qty.value);
	}
		
 	objFormAir.method="post";
 	objFormAir.action="http://localhost:8080/helloworld/order/orderAllCartGoodsAir.do";
	objFormAir.submit();
}
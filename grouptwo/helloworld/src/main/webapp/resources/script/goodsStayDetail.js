function clip(){
	var url = '';
	var textarea = document.createElement("textarea");
	document.body.appendChild(textarea);
	url = window.document.location.href;
	textarea.value = url;
	textarea.select();
	document.execCommand("copy");
	document.body.removeChild(textarea);
	alert("URL이 복사되었습니다.");
}
function addCartList() {
	alert("addCartList동작됨");
	var stay_order_qty_people = document.getElementById("stay_order_qty_people");
	var _goods_stay_id = document.getElementById("goods_stay_id");
	$.ajax({
		type : "post",
		async : false, //false인 경우 동기식으로 처리한다.
		url : "${contextPath}/cart/addGoodsStayInCart.do",
		data : {
			goods_stay_id:_goods_stay_id
			,stay_order_qty_people:stay_order_qty_people
			//cart_goods_qty:order_goods_qty //////////////장바구니
			//cart_goods_qty:cart_goods_qty
		},
		success : function(data, textStatus) {
			//alert(data);
			$('#message').append(data);
			if(data.trim()=='add_success'){
				imagePopup('open', '.layer01');	
			}else if(data.trim()=='already_existed'){
				alert("이미 카트에 등록된 상품입니다.");	
			}
		},
		error : function(data, textStatus) {
			alert("에러가 발생했습니다."+data);
		},
		complete : function(data, textStatus) {
			//alert("작업을완료 했습니다");
		}
	}); //end ajax	
}

function imagePopup(type) {
	if (type == 'open') {
		// 팝업창을 연다.
		jQuery('#layer').attr('style', 'visibility:visible');

		// 페이지를 가리기위한 레이어 영역의 높이를 페이지 전체의 높이와 같게 한다.
		jQuery('#layer').height(jQuery(document).height());
	}
	else if (type == 'close') {
		// 팝업창을 닫는다.
		jQuery('#layer').attr('style', 'visibility:hidden');
	}
}
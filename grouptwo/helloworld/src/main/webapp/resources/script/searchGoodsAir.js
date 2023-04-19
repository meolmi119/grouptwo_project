/*searchGoodsAir -> kakaoMapApiTry*/
// =========================== 전역변수 ==================================== // 
var depAirportId; // 출발지역 공항 id
var depAirportName; // 출발지역 공항 이름
var depDate; // 출발날짜

var arrAirportId; // 도착지역 공항 id
var arrAirportName; // 도착지역 공항 이름
var arrDate; // 왕복 날짜

// qty를 위한 변수
var bigNumR; // 성인
var midNumR; // 소아
var smallNumR; // 유아
var qtyFlag = 0;	// 초기 설정을 위한 플래그

var cookies = document.cookie.split(';');	// const 선언
let radioValue;	// 라디오 값(편도-왕복-다구간)	// let 선언
//cookies.forEach(cookie => {
//  const [name, value] = cookie.trim().split('=');
//  if (name === 'radioValue') {
//    radioValue = value;
//  }
//});
// 라디오가 클릭되었을 때, 어떤 상태인지 바로 알 수 있게하는 전역변수 
let radioCurrentStatus;	// let 선언

// 마커를 담을 배열
var markers = [];

// 공항 리스트 하희
var positions = [
    {	// NAARKSI 인천
		title: '인천/김포(SEL)', 	
		content: '<div>인천/김포 공항(SEL)</div>', 
		airportId: 'NAARKSI',
		latlng: new kakao.maps.LatLng( 37.558918372261786, 126.80285201904442 ),
		phone: '1661-2626', 
		airport_address: '서울 강서구 하늘길 112', 
		airport_zip: '(우) 07505',
		name: '인천'
	},
    {	// NAARKPC 제주
		title: '제주(CJU)', 		
		content: '<div>제주 공항(CJU)</div>', 
		airportId: 'NAARKPC',
		latlng: new kakao.maps.LatLng( 33.50706806850284, 126.49275184799609 ),
		phone: '1661-2626', 
		airport_address: '제주특별자치도 제주시 공항로 2', 
		airport_zip: '(우) 63115',
		name: '제주'
	},		
    {	// NAARKPK 김해
		title: '부산(김해)(PUS)', 	
		content: '<div>부산(김해) 공항(PUS)</div>', 
		airportId: 'NAARKPK',
		latlng: new kakao.maps.LatLng( 35.17319624041468, 128.94671987490145 ),
		phone: '1661-2626', 
		airport_address: '부산 강서구 공항진입로 108', 
		airport_zip: '(우) 46718',
		name: '김해'
	},
    {	// NAARKSS 김포
		title: '김포(GMP)', 		
		content: '<div>김포 공항(GMP)</div>', 
		airportId: 'NAARKSS',
		latlng: new kakao.maps.LatLng( 37.565733791386506, 126.80087815753335 ),
		phone: '1661-2626', 
		airport_address: '서울 강서구 하늘길 38', 
		airport_zip: '(우) 07505' ,
		name: '김포'
	},
    {	// NAARKSI 인천
		title: '인천(ICN)', 		
		content: '<div>인천 공항(ICN)</div>', 
		airportId: 'NAARKSI',
		latlng: new kakao.maps.LatLng( 37.449439322531624, 126.45039513915563 ) ,
		phone: '1577-2600', 
		airport_address: '인천 중구 공항로 272', 
		airport_zip: '(우) 22382',
		name: '인천'
	},
	{	// NAARKJJ 광주
		title: '광주(KWJ)', 		
		content: '<div>광주 공항(KWJ)</div>', 
		airportId: 'NAARKJJ',
		latlng: new kakao.maps.LatLng( 35.140173951307816, 126.81095610670138 ) ,
		phone: '1661-2626', 
		airport_address: '광주 광산구 상무대로 420-25', 
		airport_zip: '(우) 62425',
		name: '광주'
	},		
    {	// NAARKJB 무안
		title: '무안(MWX)', 		
		content: '<div>무안 공항(MWX)</div>', 
		airportId: 'NAARKJB',
		latlng: new kakao.maps.LatLng( 34.993691403773056, 126.3875291649234 ) ,
		phone: '1661-2626', 
		airport_address: '전남 무안군 망운면 공항로 970-260', 
		airport_zip: '(우) 58533',
		name: '무안'
	},	
    {	// NAARKJK 군산
		title: '군산(KUV)', 		
		content: '<div>군산 공항(KUV)</div>', 
		airportId: 'NAARKJK',
		latlng: new kakao.maps.LatLng( 35.92600295873855, 126.6154465669029 ) ,
		phone: '063-469-8312', 
		airport_address: '전북 군산시 옥서면 산동길 2', 
		airport_zip: '(우) 54168',
		name: '군산'
	},
    {	// NAARKTN 대구
		title: '대구(TAE)', 		
		content: '<div>대구 공항(TAE)</div>', 
		airportId: 'NAARKTN',
		latlng: new kakao.maps.LatLng( 35.89983898191976, 128.63782060626164 ) ,
		phone: '1661-2626', 
		airport_address: '대구 동구 공항로 221', 
		airport_zip: '(우) 41052',
		name: '대구'
	},	
    { // NAARKPS 사천
		title: '진주(사천)(HIN)', 	
		content: '<div>진주(사천) 공항(HIN)</div>', 
		airportId: 'NAARKPS',
		latlng: new kakao.maps.LatLng( 35.09222308702687, 128.08657440067603 ) ,
		phone: '1661-2626', 
		airport_address: '경남 사천시 사천읍 사천대로 1971', 
		airport_zip: '(우) 52516',
		name: '사천'
	},	
    {	// NAARKJY 여수
		title: '여수(RSU)', 		
		content: '<div>여수 공항(RSU)</div>', 
		airportId: 'NAARKJY',
		latlng: new kakao.maps.LatLng( 34.83996304680755, 127.61393194988244 ) ,
		phone: '1661-2626', 
		airport_address: '전남 여수시 율촌면 여순로 386', 
		airport_zip: '(우) 59606',
		name: '여수'
	},	
    {	// NAARKPU 울산
		title: '울산(USN)', 		
		content: '<div>울산 공항(USN)</div>', 
		airportId: 'NAARKPU',
		latlng: new kakao.maps.LatLng( 35.59284428869046, 129.35589228139094 ) ,
		phone: '1661-2626', 
		airport_address: '울산 북구 산업로 1103', 
		airport_zip: '(우) 44238',
		name: '울산'
	},	
    {	// NAARKNW 원주
		title: '원주(WJU)', 		
		content: '<div>원주 공항(WJU)</div>', 
		airportId: 'NAARKNW',
		latlng: new kakao.maps.LatLng( 37.45920155470414, 127.97711594014137 ) ,
		phone: '1661-2626', 
		airport_address: '강원 횡성군 횡성읍 횡성로 38', 
		airport_zip: '(우) 25239',
		name: '원주'
	},	
    {	// NAARKTU 청주
		title: '청주(CJJ)', 		
		content: '<div>청주 공항(CJJ)</div>', 
		airportId: 'NAARKTU',
		latlng: new kakao.maps.LatLng( 36.722017062739944, 127.49585057728035 ) ,
		phone: '1661-2626', 
		airport_address: '충북 청주시 청원구 내수읍 오창대로 980', 
		airport_zip: '(우) 28142',
		name: '청주'
	},
    {	// NAARKTH 포항
		title: '포항경주(KPO)', 	
		content: '<div>포항/경주 공항(KPO)</div>',
		airportId: 'NAARKTH',
		latlng: new kakao.maps.LatLng( 35.983403671987844, 129.43499096161057 ) ,
		phone: '1661-2626', 
		airport_address: '경북 포항시 남구 동해면 일월로 18', 
		airport_zip: '(우) 37926',
		name: '포항'
	},
    {	// NAARKNY 양양
		title: '양양(YNY)', 		
		content: '<div>양양 공항(YNY)</div>', 
		airportId: 'NAARKNY',
		latlng: new kakao.maps.LatLng( 38.058742361188266, 128.66287055926526 ) ,
		phone: '1661-2626', 
		airport_address: '강원 양양군 손양면 공항로 201', 
		airport_zip: '(우) 25042',
		name: '양양'
	}
],
selectedMarker = null; // 클릭한 마커를 담을 변수;

// 위치테스트 하희
var test01 = [];

// 출발지역 Map~	/* 참고 : https://apis.map.kakao.com/web/sample/addMapCenterChangedEvent/*/
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng( 36.43580957464387, 127.78115329251636 ), // 지도의 중심좌표
        level: 14 // 지도의 확대 레벨
    };  
var map = new kakao.maps.Map(mapContainer, mapOption); 	// 지도를 생성
var mapTypeControl = new kakao.maps.MapTypeControl();	// 일반 지도와 스카이뷰로 지도 타입을 전환할 수 있는 지도타입 컨트롤을 생성
// 지도에 컨트롤을 추가해야 지도위에 표시
map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);	// kakao.maps.ControlPosition은 컨트롤이 표시될 위치 정의 (TOPRIGHT: 오른쪽 위)
// 지도 확대 축소를 제어할 수 있는 줌 컨트롤을 생성
var zoomControl = new kakao.maps.ZoomControl();
map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
// jsp에서 호출하는 함수
function relayout() {    
	var mapContainer = document.getElementById('map_hidden1');
    mapContainer.style.width = '500px';
    mapContainer.style.height = '350px';
    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
    map.relayout();
}
// ~출발지역 Map 설정

// 도착지역 Map~
var mapContainer3 = document.getElementById('map3'), // 지도를 표시할 div 
    mapOption3 = {
        center: new kakao.maps.LatLng( 36.03580957464387, 127.78115329251636 ), // 지도의 중심좌표
        level: 14 // 지도의 확대 레벨
    };  
var map3 = new kakao.maps.Map(mapContainer3, mapOption3); 
var mapTypeControl3 = new kakao.maps.MapTypeControl();
map3.addControl(mapTypeControl3, kakao.maps.ControlPosition.TOPRIGHT);
var zoomControl3 = new kakao.maps.ZoomControl();
map3.addControl(zoomControl3, kakao.maps.ControlPosition.RIGHT);
function relayout3() {    // jsp에서 호출하는 함수
	var mapContainer3 = document.getElementById('map_hidden3');
    mapContainer3.style.width = '500px';
    mapContainer3.style.height = '350px';
    map3.relayout();
}
// ~도착지역 Map 설정

// 마커 이미지의 이미지 주소
var imageSrcSelected = "https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png"; 
//var imageSizeSelected = new kakao.maps.Size(24, 35);   // 마커 이미지의 이미지 크기 입니다
//var markerImageSelected = new kakao.maps.MarkerImage(imageSrcSelected, imageSizeSelected); 	// 마커 이미지를 생성합니다
var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png'; // 마커 이미지 url, 스프라이트 이미지를 씁니다
//var imageSrc = 'http://localhost:8080/helloworld/resources/image/markerss.png';

// 인포윈도우를 표시하는 클로저를 만드는 함수입니다 
function makeOverListener(map, marker, infowindow) {
    return function() {
        infowindow.open(map, marker);
    };
}
// 인포윈도우를 닫는 클로저를 만드는 함수입니다 
function makeOutListener(infowindow) {
    return function() {
        infowindow.close();
    };
}

/* 맵 팝업 시 지도나오게 하기 */
document.addEventListener(`DOMContentLoaded`, () => {
	displayAirports(positions);

	const pop2_button = document.querySelector('#pop2_button')
	const pop2 = document.querySelector('#pop2');
	
	const pop3_button = document.querySelector('#pop3_button')
	const pop3 = document.querySelector('#pop3');
	
	pop2_button.addEventListener(`click`, () => {
		pop2.style.height = '750px';
		document.getElementById("pop2div").style.display ='inline-block';
		document.getElementById("map_hidden1").style.display ='inline-block';
		document.getElementById("menu_wrap").style.display ='inline-block';
	    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
	    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
	    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
		map.relayout();
		// 지도 중심을 이동 시킵니다 (청주 공항이 기준점(중심좌표))
		var moveLatLon = new kakao.maps.LatLng(36.03580957464387, 127.78115329251636);
		
		map.setCenter(moveLatLon);
		map.relayout();
	})
	
	pop3_button.addEventListener(`click`, () => {
		pop3.style.height = '750px';
		document.getElementById("pop3div").style.display ='inline-block';
		document.getElementById("map_hidden3").style.display ='inline-block';
		document.getElementById("menu_wrap3").style.display ='inline-block';
		var moveLatLon3 = new kakao.maps.LatLng(36.03580957464387, 127.78115329251636);
		map3.setCenter(moveLatLon3);
		map3.relayout();
		map3.setCenter(moveLatLon3);
	})
})

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions =  {
            spriteSize : new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin : new kakao.maps.Point(0, (idx*46)+10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
            marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage 
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for ( var i = 0; i < markers.length; i++ ) {
        markers[i].setMap(null);
    }   
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수 : pagination
//function displayPagination(pagination) {
//    var paginationEl = document.getElementById('pagination'),
//        fragment = document.createDocumentFragment(),
//        i; 
//
//    // 기존에 추가된 페이지번호를 삭제합니다
//    while (paginationEl.hasChildNodes()) {
//        paginationEl.removeChild (paginationEl.lastChild);
//    }
//
//    for (i=1; i<=pagination.last; i++) {
//        var el = document.createElement('a');
//        el.href = "#";
//        el.innerHTML = i;
//
//        if (i===pagination.current) {
//            el.className = 'on';
//        } else {
//            el.onclick = (function(i) {
//                return function() {
//                    pagination.gotoPage(i);
//                }
//            })(i);
//        }
//
//        fragment.appendChild(el);
//    }
//    paginationEl.appendChild(fragment);
//}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

// 검색 결과 목록과 마커를 표출하는 함수
function displayAirports(places) {
    var listEl = document.getElementById('placesList'), 
    listEl3 = document.getElementById('placesList3'),
    menuEl = document.getElementById('menu_wrap'),
    menuEl3 = document.getElementById('menu_wrap3'),
    fragment = document.createDocumentFragment(), 
    fragment3 = document.createDocumentFragment(), 
    bounds = new kakao.maps.LatLngBounds(), 
    listStr = '';
    
    // 검색 결과 목록에 추가된 항목들 제거
    removeAllChildNods(listEl);
    removeAllChildNods(listEl3);

    // 지도에 표시되고 있는 마커 제거
    removeMarker();
    
    for ( var i=0; i<places.length; i++ ) {
        var itemEl = getListAirportItem(i, places[i]); // 검색 결과 항목 Element를 생성
		
		var imageSize = new kakao.maps.Size(36, 37),
		 	imgOptions =  {
		        spriteSize : new kakao.maps.Size(36, 691), 			// 스프라이트 이미지의 크기
		        spriteOrigin : new kakao.maps.Point(0, ((i)*46)+10), 	// 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		        offset: new kakao.maps.Point(13, 37) 				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
		    },
		    markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
		        marker = new kakao.maps.Marker({
		        	map: map,
					position: places[i].latlng, // 마커의 위치
					title : places[i].title,
		        	image: markerImage 
		    });

        var itemEl3 = getListAirportItemArr(i, places[i]); // 검색 결과 항목 Element를 생성
		var imageSize3 = new kakao.maps.Size(36, 37),
		 	imgOptions3 =  {
		        spriteSize : new kakao.maps.Size(36, 691), 			// 스프라이트 이미지의 크기
		        spriteOrigin : new kakao.maps.Point(0, ((i)*46)+10), 	// 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
		        offset: new kakao.maps.Point(13, 37) 				// 마커 좌표에 일치시킬 이미지 내에서의 좌표
		    },
		    markerImage3 = new kakao.maps.MarkerImage(imageSrc, imageSize3, imgOptions3),
		        marker3 = new kakao.maps.Marker({
		        	map: map3,
					position: places[i].latlng, // 마커의 위치
					title : places[i].title,
		        	image: markerImage3 
		    });

		// 마커에 표시할 인포윈도우를 생성합
	    var infowindow = new kakao.maps.InfoWindow({
	        content: places[i].content // 인포윈도우에 표시할 내용
	    });
		// 마커에 mouseover 이벤트와 mouseout 이벤트를 등록
	    // 이벤트 리스너로는 클로저를 만들어 등록
	    // for문에서 클로저를 만들어 주지 않으면 마지막 마커에만 이벤트가 등록
	    kakao.maps.event.addListener(marker, 'mouseover', makeOverListener(map, marker, infowindow));
	    kakao.maps.event.addListener(marker, 'mouseout', makeOutListener(infowindow));

		kakao.maps.event.addListener(marker3, 'mouseover', makeOverListener(map3, marker3, infowindow));
	    kakao.maps.event.addListener(marker3, 'mouseout', makeOutListener(infowindow));

        fragment.appendChild(itemEl);
        fragment3.appendChild(itemEl3);
    }

    // 검색결과 항목들을 검색결과 목록 Element에 추가
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;
    listEl3.appendChild(fragment3);
    menuEl3.scrollTop = 0;
}

// 검색결과 항목을 Element로 반환하는 함수
function getListAirportItem(index, places) {
	var airportId = places.airportId;
	var airportName = places.title;
	var airportRealName = places.name;
	
    var el = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.content + '</h5>';
    itemStr += '    <span>' +  places.airport_address  + '</span>'; 
    itemStr += '	<input id="placeslistInput" type="button" onclick="mapEachClick(\'' + airportId + '\', \'' + airportName + '\', \'' + airportRealName + '\');" class="subm fadeoutair" value="선택";>' + '</div>';

	el.innerHTML = itemStr;
    el.className = 'item';
	test01[index+1] = places.place_name;
    return el;
}

// 검색결과 항목을 Element로 반환하는 함수
function getListAirportItemArr(index, places) {
	var airportId3 = places.airportId;
	var airportName3 = places.title;
	var airportRealName3 = places.name;
	
    var el3 = document.createElement('li'),
    itemStr = '<span class="markerbg marker_' + (index+1) + '"></span>' +
                '<div class="info">' +
                '   <h5>' + places.content + '</h5>';
    itemStr += '    <span>' +  places.airport_address  + '</span>'; 
    itemStr += '	<input id="placeslistInput3" type="button" onclick="mapEachClick3(\'' + airportId3 + '\', \'' + airportName3 + '\', \'' + airportRealName3 + '\');" class="subm fadeoutair" value="선택";>' + '</div>';

	el3.innerHTML = itemStr;
    el3.className = 'item';
	test01[index+1] = places.place_name;
    return el3;
}

function getDataForSearchAir(airportDepId, airportDepName, airportArrId, airportArrName, depDate){
	$.ajax({
 		type : "post",
 		async : false, // true였음 //false인 경우 동기식으로 처리한다.
 		url : "http://localhost:8080/helloworld/getDataForSearchAir.do",
 		data: {
 			airportDepId: airportDepId,
			airportDepName: airportDepName,
 			airportArrId: airportArrId,
			airportArrName: airportArrName,
			depDate: depDate
	  	},
 		success : function(data, textStatus) {
			alert("출발지역 \"" + airportDepName +"\", 도착지역 \""+ airportArrName+"\"로 항공편을 검색합니다.\n데이터 로딩 중이니 잠시만 기다려 주세요. ");
 		},
 		error : function(data, textStatus) {
 			alert("getDataForSearchAir 에러가 발생했습니다. "+textStatus);
			console.log("airportDepId 유무 : " + airportDepId);
			console.log("airportDepName 유무 : " + airportDepName);
 			console.log("airportArrId 유무 : " + airportArrId);
			console.log("airportArrName 유무 : " + airportArrName);
			console.log("depDate 유무 : " + depDate);
 		},
 		complete : function(data, textStatus) {
 			//alert("작업을완료 했습니다");
 		}
 	 }); //end ajax
}

// 왕복/다구간을 위한 추가 데이터 얻기
function getDataForSearchAirRnM(arrDate){
    $.ajax({
 		type : "post",
 		async : false, // true였음 // false인 경우 동기식으로 처리한다.
 		url : "http://localhost:8080/helloworld/getDataForSearchAirRnM.do",
 		data: {
 			arrDate: arrDate
	  	},
 		success : function(data, textStatus) {
			//alert("돌아오는 날짜는 \"" + arrDate +"\" 입니다. ");
			console.log("돌아오는 날짜는 \"" + arrDate +"\" 입니다. ");
 		},
 		error : function(data, textStatus) {
 			alert("getDataForSearchAirRnM 왕복/다구간 함수 에러가 발생했습니다. "+textStatus);
			console.log("arrDate 유무 : " + arrDate);
 		},
 		complete : function(data, textStatus) {
 			//alert("작업을완료 했습니다");
 		}
 	 }); //end ajax
}

// 페이지 새로고침 후 이전 값을 가져와 매개변수 초기화
document.addEventListener(`DOMContentLoaded`, () => {
	  if (document.cookie) {
	    const cookies = document.cookie.split(';');
	    cookies.forEach(cookie => {
	      const [name, value] = cookie.split('=');
	      if (name.trim() === 'depAirportId') {
	        depAirportId = value.trim();
	      } else if (name.trim() === 'depAirportName') {
	        depAirportName = value.trim();
//	      } else if (name.trim() === 'depAirportRName') {
//	        airportDepRName = value.trim();
	      }
		  if (name.trim() === 'arrAirportId') {
	        arrAirportId = value.trim();
	      } else if (name.trim() === 'arrAirportName') {
	        arrAirportName = value.trim();
//	      } else if (name.trim() === 'arrAirportRName') {
//	        airportArrRName = value.trim();
	      }
		  if (name.trim() === 'depDate') {
			depDate = value.trim();
		  }
		  if (name.trim() === 'arrDate') {
			arrDate = value.trim();
		  }	
		  if (name.trim() === 'bigNum') {
	        bigNumR = value.trim();
	      } else if (name.trim() === 'midNum') {
	        midNumR = value.trim();
	      } else if (name.trim() === 'smallNum') {
	        smallNumR = value.trim();
	      }
	    });
	  }
});

// 선택한 항공의 Id를 리턴하는 함수
function mapEachClick(airportDepId, airportDepName, airportDepRName) {
	// 쿠키에 값 저장
    document.cookie = `depAirportId=${airportDepId}`;
    document.cookie = `depAirportName=${airportDepName}`;
	console.log("쿠키 저장 값 : " + getCookie('depAirportId'));
	console.log("쿠키 저장 값 : " + getCookie('depAirportName'));
//    document.cookie = `depAirportRName=${airportDepRName}`;
	// 전역변수에 값 넣기
	depAirportId = airportDepId;
	depAirportName = airportDepRName;
	//alert("mapEachClick" + depAirportId+depAirportName);
	const p_departAirport = document.querySelector('#p_departAirport');
	p_departAirport.textContent = airportDepName;
	alert("선택하신 항공은 " + airportDepName + "(" + airportDepId + ") 입니다. ");
	$(".pop2").fadeOut(300);
	return airportDepId;
}
function mapEachClick3(airportArrId, airportArrName, airportArrRName) {
	// 쿠키에 값 저장
    document.cookie = `arrAirportId=${airportArrId}`;
    document.cookie = `arrAirportName=${airportArrName}`;
	console.log("쿠키 저장 값 : " + getCookie('arrAirportId'));
	console.log("쿠키 저장 값 : " + getCookie('arrAirportName'));
    //document.cookie = `arrAirportRName=${airportArrRName}`;
	// 전역변수에 값 넣기
	arrAirportId = airportArrId;
	arrAirportName = airportArrRName;
	//alert("mapEachClick3" + arrAirportId+arrAirportName);
	const p_arriveAirport = document.querySelector('#p_arriveAirport');
	p_arriveAirport.textContent = airportArrName;
	alert("선택하신 항공은 " + airportArrName + "(" + airportArrId + ") 입니다. ");
	$(".pop3").fadeOut(300);
	return airportArrId;
}

/*왕복 다구간 편도 */
document.addEventListener(`DOMContentLoaded`, () => {
	const radios = document.querySelectorAll('[name=airda]')
	const airda01 = document.querySelector('#airda01');
	const airda02 = document.querySelector('#airda02');
	const airda03 = document.querySelector('#airda03');
	// 도착날짜
	const endDate = document.getElementById("endDate");
	const p_endDate = document.getElementById("p_endDate");
	// 다구간
	const roundTrip = document.getElementById("roundTrip");
	const reStartDate = document.getElementById("reStartDate");
	const p_reStartDate = document.getElementById("p_reStartDate");
	
	//	const cookies = document.cookie.split(';');
	// 	let radioValue;
	cookies.forEach(cookie => {
	    const [name, value] = cookie.trim().split('=');
	    if (name === 'radioValue') {
	      radioValue = value;
	    }
	  });

	radios.forEach((radio) => {
		radio.addEventListener('change', (event) => {
			const current = event.currentTarget
			if(current.checked) {
				if(current.value == "왕복") {
					airda01.style.cssText = "background-color: #0E256D;	border: 1px solid #9FCBF6; color: #9FCBF6;";
//					airda02.style.cssText = "background-color: #9FCBF6; border: 1px solid #0E256D; color: #0E256D;";
					airda03.style.cssText = "background-color: #9FCBF6;	border: 1px solid #0E256D; color: #0E256D;";
					/*도착날짜*/
					endDate.style.display ='inline-block';
					p_endDate.style.display ='inline-block';
					/* 다구간 */
					roundTrip.style.display ='none';
					reStartDate.style.display ='none';
					p_reStartDate.style.display ='none';
					radioCurrentStatus = "왕복";
					console.log("radioCurrentStatus 현재 상태 : " + radioCurrentStatus);
				}
				if(current.value == "다구간") {
					airda02.style.cssText = "background-color: #0E256D;	border: 1px solid #9FCBF6; color: #9FCBF6;";
					airda01.style.cssText = "background-color: #9FCBF6;	border: 1px solid #0E256D; color: #0E256D;";
					airda03.style.cssText = "background-color: #9FCBF6;	border: 1px solid #0E256D; color: #0E256D;";
					/*도착날짜*/
					endDate.style.display ='none';
					p_endDate.style.display ='none';
					/* 다구간 */
					roundTrip.style.display ='inline-block';
					reStartDate.style.display ='inline-block';
					p_reStartDate.style.display ='inline-block';
					radioCurrentStatus = "다구간";
					console.log("radioCurrentStatus 현재 상태 : " + radioCurrentStatus);
				}
				if(current.value == "편도") {
					airda03.style.cssText = "background-color: #0E256D;	border: 1px solid #9FCBF6; color: #9FCBF6;";
					airda01.style.cssText = "background-color: #9FCBF6;	border: 1px solid #0E256D; color: #0E256D;";
//					airda02.style.cssText = "background-color: #9FCBF6;	border: 1px solid #0E256D; color: #0E256D;";
					/*도착날짜*/
					endDate.style.display ='none';
					p_endDate.style.display ='none';
					/* 다구간 */
					roundTrip.style.display ='none';
					reStartDate.style.display ='none';
					p_reStartDate.style.display ='none';
					radioCurrentStatus = "편도";
					console.log("radioCurrentStatus 현재 상태 : " + radioCurrentStatus);
				}
				document.cookie = `radioValue=${current.value}`;
			}
		});
	});
	if (radioValue) {
	    const radioToCheck = document.querySelector(`[value=${radioValue}]`);
	    if (radioToCheck) {
	      radioToCheck.checked = true;
	      radioToCheck.dispatchEvent(new Event('change'));
	    }
	  }
});

document.addEventListener(`DOMContentLoaded`, () => {
	const radiodiv21 = document.getElementById("radiodiv21");
	const radiodiv22 = document.getElementById("radiodiv22");
	const radiodiv23 = document.getElementById("radiodiv23");
	const first_announ = document.querySelector('.first_announ');	// 검색 전 p 태그 안내
	const firstNotice = document.getElementById('firstNotice');		// 검색 전 안내를 위한 div
	const selectAirTable = document.getElementById('selectAirTable');	// 왕복/다구간 시 선택하여 결제할 수 있도록 하는 선택창
	
	if(radioValue == "왕복") {
		radiodiv21.style.display ='inline-block';
		radiodiv22.style.display ='none';
		radiodiv23.style.display ='none';
		// 검색하기 전 안내 없애기
	    firstNotice.style.display ='none';
	    first_announ.style.display ='none';
		selectAirTable.style.display = 'inline-block';
		//alert("라디오안 왕복");
	} else if(radioValue == "다구간") {
		radiodiv21.style.display ='none';
		radiodiv22.style.display ='inline-block';
		radiodiv23.style.display ='none';
		// 검색하기 전 안내 없애기
	    firstNotice.style.display ='none';
	    first_announ.style.display ='none';
		selectAirTable.style.display = 'inline-block';
		//alert("라디오안 다구간");
	} else if(radioValue == "편도") {
		radiodiv21.style.display ='none';
		radiodiv22.style.display ='none';
		radiodiv23.style.display ='inline-block';
		// 검색하기 전 안내 없애기
	    firstNotice.style.display ='none';
	    first_announ.style.display ='none';
		selectAirTable.style.display = 'none';
		//alert("라디오안 편도");
	}
})

/* 검색하기 편도-왕복-다구간 선택 */
document.addEventListener(`DOMContentLoaded`, () => {
	const in_search = document.querySelector('#in_search');	// 검색하기 버튼
	const radioButtons = document.getElementsByName("airda");	// 라디오 버튼
	const p_departAirport = document.querySelector('#p_departAirport');	// 출발지역
	const p_arriveAirport = document.querySelector('#p_arriveAirport');	// 도착지역
	const startDate = document.querySelector('#p_startDate');	// 출발날짜
	const endDate2 = document.querySelector('#p_endDate2');	// 돌아오는 날짜(도착날짜)
	
	// 라디오 버튼 클릭 시 쿠키에 선택된 값을 저장합니다.
	for (const radioButton of radioButtons) {
	  radioButton.addEventListener('click', (event) => {
	    const selectedValue = event.target.value;
	    document.cookie = `airda=${selectedValue}`;
	  });
	}

    // 페이지 로드 시 쿠키에 저장된 값을 확인하여 선택된 상태로 지정
    const selectedValue = getCookie('airda');	// 쿠키 - 라디오
    if (selectedValue) {
      for (const radioButton of radioButtons) {
        if (radioButton.value === selectedValue) {
          radioButton.checked = true;
          break;
        }
      }
    }
	depAirportId = getCookie('depAirportId');	// 쿠키
	depAirportName = getCookie('depAirportName');	// 쿠키
	arrAirportId = getCookie('arrAirportId');	// 쿠키
	arrAirportName = getCookie('arrAirportName');	// 쿠키
	depDate = getCookie('depDate');	// 쿠키
	arrDate = getCookie('arrDate');	// 쿠키
	
	// 검색하기 버튼 클릭
    in_search.addEventListener('click', () => {
	    // 라디오 버튼이 선택되었는지 확인
	    let isSelected = false;
	    for (const radioButton of radioButtons) {
	      if (radioButton.checked) {
	        isSelected = true;
	        break;
	      }
    }
	
    // 선택되지 않았을 경우 alert 창, 선택되었다면 창 이동
    if (!isSelected) {
      alert('편도-왕복-다구간 중 하나를 선택해주세요.');
    } else {
		// 출발지역이 선택되었는지 확인
	    if (p_departAirport.innerHTML === '' || p_departAirport.textContent === '') {
	      alert('출발지역을 선택해주세요.');
		  console.log('출발지역 : ' + p_departAirport.innerHTML);
	      return;
	    }
		// 도착지역이 선택되었는지 확인
		else if (p_arriveAirport.innerHTML === '' || p_arriveAirport.textContent === '') {
	      alert('도착지역을 선택해주세요.');
		  console.log('도착지역 : ' + p_arriveAirport.innerHTML);
	      return;
	    } 
		// 출발날짜가 선택되었는지 확인
		else if (startDate.innerHTML === '' || startDate.textContent === '' || startDate.innerHTML === '&nbsp;' || startDate.textContent === '&nbsp;') {
	      alert('출발날짜를 선택해주세요.');
		  console.log('출발날짜 : ' + startDate.textContent);
			return;
		}
		else {
			if(radioCurrentStatus == "편도") {
			  // 쿠키에 값 저장
			  document.cookie = `depDate=${depDate}`;
			  depDate = startDate.textContent;
				getDataForSearchAir(depAirportId, depAirportName, arrAirportId, arrAirportName, depDate);
			  console.log('최종 출발지역 : ' + depAirportId + ", " + depAirportName);
			  console.log('최종 도착지역 : ' + arrAirportId + ", " + arrAirportName);
			  console.log('최종 출발날짜 : ' + depDate);
			  
			  setTimeout(function() {
			    window.location.href = 'http://localhost:8080/helloworld/airapiTago.do';
			  }, 300); // 0.3초 지연
			} else {
				if (endDate2.innerHTML === '' || endDate2.textContent === '' || endDate2.innerHTML === '&nbsp;' || endDate2.textContent === '&nbsp;') {
			          alert('돌아오는 날짜를 선택해주세요.');
				      console.log('돌아오는 날짜 : ' + endDate2.textContent);
					  return;
				} else {
					  // 쿠키에 값 저장
					  document.cookie = `depDate=${depDate}`;
					  document.cookie = `arrDate=${arrDate}`;
					  depDate = startDate.textContent;
					  arrDate = endDate2.textContent;
			
					  setTimeout(function() {
					    getDataForSearchAir(depAirportId, depAirportName, arrAirportId, arrAirportName, depDate);
					  }, 500); // 0.5초 지연	
			
					  setTimeout(function() {
					    getDataForSearchAirRnM(arrDate);
					  }, 800); // 0.8초 지연
					  
					  console.log('2.최종 출발지역 : ' + depAirportId + ", " + depAirportName);
					  console.log('2.최종 도착지역 : ' + arrAirportId + ", " + arrAirportName);
					  console.log('2.최종 출발날짜 : ' + depDate);
					  console.log('2.최종 출발날짜2 : ' + arrDate);
					
					  setTimeout(function() {
					    window.location.href = 'http://localhost:8080/helloworld/airapiTago.do';
					  }, 1300); // 1초 지연
			
					  setTimeout(function() {
					    window.location.href = 'http://localhost:8080/helloworld/airapiTagoRnM.do';
					  }, 1500); // 1.2초 지연
				}
			}
		}
    }
  });
});

// 편도 다구간 왕복 라디오버튼 상태 쿠키에 저장
function getCookie(name) {
  const cookieString = document.cookie;
  const cookies = cookieString.split(';');
  for (const cookie of cookies) {
    const [cookieName, cookieValue] = cookie.trim().split('=');
    if (cookieName === name) {
      return cookieValue;
    }
  }
  return '';
}

// ===================================결제하기========================================
function fn_order_each_goods(airData){
	//const rowData = [flightName, airlineName, departureTime, arrivalTime, departureAirport, arrivalAirport, economyCharge];
	var total_price,final_total_price;
	var qty = parseInt(bigNumR) + parseInt(midNumR);
	console.log("총 결제 인원 : " + qty);
	
	var formObj=document.createElement("form");
	var i_flightName = document.createElement("input"); 
    var i_airlineName = document.createElement("input");
    var i_departureTime = document.createElement("input");
    var i_arrivalTime = document.createElement("input");
    var i_departureAirport = document.createElement("input");
    var i_arrivalAirport = document.createElement("input");
    var i_price = document.createElement("input");
    var i_qty = document.createElement("input");
    
    i_flightName.name = "flightName";
    i_airlineName.name = "airlineName";
    i_departureTime.name = "departureTime";
    i_arrivalTime.name = "arrivalTime";
    i_departureAirport.name = "departureAirport";
    i_arrivalAirport.name = "arrivalAirport";
    i_price.name = "price";
    i_qty.name = "qty";
  	  
    i_flightName.value = airData[0];
    i_airlineName.value = airData[1];
    i_departureTime.value = airData[2];
    i_arrivalTime.value = airData[3];
    i_departureAirport.value = airData[4];
    i_arrivalAirport.value = airData[5];
    i_price.value = airData[6];
    i_qty.value = qty;
    
    formObj.appendChild(i_flightName);
    formObj.appendChild(i_airlineName);
    formObj.appendChild(i_departureTime);
    formObj.appendChild(i_arrivalTime);
    formObj.appendChild(i_departureAirport);
    formObj.appendChild(i_arrivalAirport);
    formObj.appendChild(i_price);
    formObj.appendChild(i_qty);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="http://localhost:8080/helloworld/order/orderEachGoodsAir.do";
    formObj.submit();
}	
// 결제하기 버튼 클릭 시 데이터 저장
function getDataForEachPaymentAir(rowData) {
	var qty = parseInt(bigNumR) + parseInt(midNumR);
  	console.log("qty는 : " + qty);
	$.ajax({
 		type : "post",
 		async : false, // true였음 //false인 경우 동기식으로 처리한다.
 		url : "http://localhost:8080/helloworld/order/getDataForEachPaymentAir.do",
 		data: {
 			/*rowData: rowData,*/
			flightName: rowData[0],
			airlineName: rowData[1],
 			departureTime: rowData[2],
			arrivalTime: rowData[3],
			departureAirport: rowData[4],
			arrivalAirport: rowData[5],
			economyCharge: rowData[6],
			qty: qty
	  	},
 		success : function(data, textStatus) {

 		},
 		error : function(data, textStatus) {
 			alert("getDataForEachPaymentAir 에러가 발생했습니다. "+textStatus);
			console.log("flightName 유무 : " + rowData[0]);
			console.log("airlineName 유무 : " + rowData[1]);
 			console.log("departureTime 유무 : " + rowData[2]);
			console.log("arrivalTime 유무 : " + rowData[3]);
			console.log("departureAirport 유무 : " + rowData[4]);
			console.log("arrivalAirport 유무 : " + rowData[5]);
			console.log("economyCharge 유무 : " + rowData[6]);
			console.log("qty 유무 : " + qty);
 		},
 		complete : function(data, textStatus) {
 			//alert("작업을완료 했습니다");
 		}
  }); //end ajax
}
// 결제하기 버튼 클릭 시 실행되는 함수
function onAirPayButtonClick(event) {
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	
	if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
  const targetButton = event.target;
  const targetRow = targetButton.closest("tr"); // 클릭한 버튼이 속한 <tr> 엘리먼트를 찾음
  
  // <td> 엘리먼트들을 선택하여 값을 가져옴
  const flightName = targetRow.querySelector("td:nth-child(1)").textContent;
  const airlineName = targetRow.querySelector("td:nth-child(2)").textContent;
  const departureTime = targetRow.querySelector("td:nth-child(3)").textContent;
  const arrivalTime = targetRow.querySelector("td:nth-child(4)").textContent;
  const departureAirport = targetRow.querySelector("td:nth-child(5)").textContent;
  const arrivalAirport = targetRow.querySelector("td:nth-child(6)").textContent;
  const economyCharge = targetRow.querySelector("td:nth-child(7)").textContent;
  
  // 가져온 값을 배열에 저장
  const rowData = [flightName, airlineName, departureTime, arrivalTime, departureAirport, arrivalAirport, economyCharge];
  getDataForEachPaymentAir(rowData);
  
  fn_order_each_goods(rowData);
  
  /*const newRow = document.createElement("tr");	// 새로운 <tr> 엘리먼트를 생성하고 데이터를 추가
  for (let i = 0; i < rowData.length; i++) {
    const newData = document.createElement("td");
    newData.textContent = rowData[i];
    newRow.appendChild(newData);
  }
  const tableBody = document.querySelector("#selectedData");	// 새로운 <tr> 엘리먼트를 추가할 <tbody> 엘리먼트를 선택하고 추가
  tableBody.appendChild(newRow);*/
}
function fn_order_goods(airData1, airData2){
	var total_price,final_total_price;
	var qty = parseInt(bigNumR) + parseInt(midNumR);
	if (isNaN(qty)) {
	    console.log("총 결제 인원 : " + 1);
	    qty = 1;
	  }
	console.log("총 결제 인원 : " + qty);
	
	var formObj=document.createElement("form");
	
	var i_flightName1 = document.createElement("input"); 
    var i_airlineName1 = document.createElement("input");
    var i_departureTime1 = document.createElement("input");
    var i_arrivalTime1 = document.createElement("input");
    var i_departureAirport1 = document.createElement("input");
    var i_arrivalAirport1 = document.createElement("input");
    var i_price1 = document.createElement("input");
    var i_qty = document.createElement("input");
    
	var i_flightName2 = document.createElement("input"); 
    var i_airlineName2 = document.createElement("input");
    var i_departureTime2 = document.createElement("input");
    var i_arrivalTime2 = document.createElement("input");
    var i_departureAirport2 = document.createElement("input");
    var i_arrivalAirport2 = document.createElement("input");
    var i_price2 = document.createElement("input");

    i_flightName1.name = "flightName1";
    i_airlineName1.name = "airlineName1";
    i_departureTime1.name = "departureTime1";
    i_arrivalTime1.name = "arrivalTime1";
    i_departureAirport1.name = "departureAirport1";
    i_arrivalAirport1.name = "arrivalAirport1";
    i_price1.name = "price1";
    i_qty.name = "qty";
 	
	i_flightName2.name = "flightName2";
    i_airlineName2.name = "airlineName2";
    i_departureTime2.name = "departureTime2";
    i_arrivalTime2.name = "arrivalTime2";
    i_departureAirport2.name = "departureAirport2";
    i_arrivalAirport2.name = "arrivalAirport2";
    i_price2.name = "price2";
  	  
    i_flightName1.value = airData1[0];
    i_airlineName1.value = airData1[1];
    i_departureTime1.value = airData1[2];
    i_arrivalTime1.value = airData1[3];
    i_departureAirport1.value = airData1[4];
    i_arrivalAirport1.value = airData1[5];
    i_price1.value = airData1[6];
    i_qty.value = qty;

	i_flightName2.value = airData2[0];
    i_airlineName2.value = airData2[1];
    i_departureTime2.value = airData2[2];
    i_arrivalTime2.value = airData2[3];
    i_departureAirport2.value = airData2[4];
    i_arrivalAirport2.value = airData2[5];
    i_price2.value = airData2[6];
    
    formObj.appendChild(i_flightName1);
    formObj.appendChild(i_airlineName1);
    formObj.appendChild(i_departureTime1);
    formObj.appendChild(i_arrivalTime1);
    formObj.appendChild(i_departureAirport1);
    formObj.appendChild(i_arrivalAirport1);
    formObj.appendChild(i_price1);
    formObj.appendChild(i_qty);
	
	formObj.appendChild(i_flightName2);
    formObj.appendChild(i_airlineName2);
    formObj.appendChild(i_departureTime2);
    formObj.appendChild(i_arrivalTime2);
    formObj.appendChild(i_departureAirport2);
    formObj.appendChild(i_arrivalAirport2);
    formObj.appendChild(i_price2);

    document.body.appendChild(formObj); 
    formObj.method="post";
    formObj.action="http://localhost:8080/helloworld/order/orderGoodsAir.do";
    formObj.submit();
}
// 결제하기 버튼 클릭 시 실행되는 함수 for 왕복/다구간
function onAirPayButtonRnMClick() {
	var _isLogOn=document.getElementById("isLogOn");
	var isLogOn=_isLogOn.value;
	
	if(isLogOn=="false" || isLogOn=='' ){
		alert("로그인 후 주문이 가능합니다!!!");
	} 
	
  const selectAirTableGo = document.querySelector("#selectAirTableGo");
  const selectAirTableBack = document.querySelector("#selectAirTableBack");

  const flightName1 = selectAirTableGo.querySelector("td:nth-child(2)").textContent; 	// 항공편명
  const airlineName1 = selectAirTableGo.querySelector("td:nth-child(3)").textContent;
  const departureTime1 = selectAirTableGo.querySelector("td:nth-child(4)").textContent;
  const arrivalTime1 = selectAirTableGo.querySelector("td:nth-child(5)").textContent;
  const departureAirport1 = selectAirTableGo.querySelector("td:nth-child(6)").textContent;
  const arrivalAirport1 = selectAirTableGo.querySelector("td:nth-child(7)").textContent;
  const economyCharge1 = selectAirTableGo.querySelector("td:nth-child(8)").textContent;

  // <td> 엘리먼트들을 선택하여 값을 가져옴
  const flightName2 = selectAirTableBack.querySelector("td:nth-child(2)").textContent;
  const airlineName2 = selectAirTableBack.querySelector("td:nth-child(3)").textContent;
  const departureTime2 = selectAirTableBack.querySelector("td:nth-child(4)").textContent;
  const arrivalTime2 = selectAirTableBack.querySelector("td:nth-child(5)").textContent;
  const departureAirport2 = selectAirTableBack.querySelector("td:nth-child(6)").textContent;
  const arrivalAirport2 = selectAirTableBack.querySelector("td:nth-child(7)").textContent;
  const economyCharge2 = selectAirTableBack.querySelector("td:nth-child(8)").textContent;
  
  // 가져온 값을 배열에 저장
  const rowData1 = [flightName1, airlineName1, departureTime1, arrivalTime1, departureAirport1, arrivalAirport1, economyCharge1];
  const rowData2 = [flightName2, airlineName2, departureTime2, arrivalTime2, departureAirport2, arrivalAirport2, economyCharge2];

  fn_order_goods(rowData1, rowData2);
}
// 왕복/다구간 시 항공편 선택하면 정보 가져오는 함수
function onAirPayRoundGetData() {
  const targetButton = event.target;
  const targetRow = targetButton.closest("tr"); // 클릭한 버튼이 속한 <tr> 엘리먼트를 찾음
  
  // <td> 엘리먼트들을 선택하여 값을 가져옴
  const flightName = targetRow.querySelector("td:nth-child(1)").textContent;
  const airlineName = targetRow.querySelector("td:nth-child(2)").textContent;
  const departureTime = targetRow.querySelector("td:nth-child(3)").textContent;
  const arrivalTime = targetRow.querySelector("td:nth-child(4)").textContent;
  const departureAirport = targetRow.querySelector("td:nth-child(5)").textContent;
  const arrivalAirport = targetRow.querySelector("td:nth-child(6)").textContent;
  const economyCharge = targetRow.querySelector("td:nth-child(7)").textContent;
  
  const rowData = [flightName, airlineName, departureTime, arrivalTime, departureAirport, arrivalAirport, economyCharge];
  
  return rowData;
}
// 왕복/다구간 시 항공편 선택하기 함수
function onAirPayRound(event) {
  const airData = onAirPayRoundGetData();
  const selectAirTableGo = document.querySelector("#selectAirTableGo");

  selectAirTableGo.querySelector("td:nth-child(2)").textContent =airData[0]; 	// 항공편명
  selectAirTableGo.querySelector("td:nth-child(3)").textContent =airData[1]; 	// 항공사명
  selectAirTableGo.querySelector("td:nth-child(4)").innerHTML = airData[2].slice(0, 11) + "<br>" + airData[2].slice(11);	// 출발시간
  selectAirTableGo.querySelector("td:nth-child(5)").innerHTML = airData[3].slice(0, 11) + "<br>" + airData[3].slice(11);	// 도착시간
  selectAirTableGo.querySelector("td:nth-child(6)").textContent =airData[4]; 	// 출발공항
  selectAirTableGo.querySelector("td:nth-child(7)").textContent =airData[5]; 	// 도착공항
  const ChargeText = airData[6];
  const Charge = ChargeText.slice(0, ChargeText.indexOf("(")).trim() + "<br>" + ChargeText.slice(ChargeText.indexOf("("));
  selectAirTableGo.querySelector("td:nth-child(8)").innerHTML =Charge;
}
// 왕복/다구간 시 항공편 선택하기 함수
function onAirPayRound2(event) {
  const airData = onAirPayRoundGetData();
  const selectAirTableBack = document.querySelector("#selectAirTableBack");

  selectAirTableBack.querySelector("td:nth-child(2)").textContent =airData[0]; 	// 항공편명
  selectAirTableBack.querySelector("td:nth-child(3)").textContent =airData[1]; 	// 항공사명
  selectAirTableBack.querySelector("td:nth-child(4)").innerHTML = airData[2].slice(0, 11) + "<br>" + airData[2].slice(11);	// 출발시간
  selectAirTableBack.querySelector("td:nth-child(5)").innerHTML = airData[3].slice(0, 11) + "<br>" + airData[3].slice(11);	// 도착시간
  selectAirTableBack.querySelector("td:nth-child(6)").textContent =airData[4]; 	// 출발공항
  selectAirTableBack.querySelector("td:nth-child(7)").textContent =airData[5]; 	// 도착공항
  const ChargeText = airData[6];
  const Charge = ChargeText.slice(0, ChargeText.indexOf("(")).trim() + "<br>" + ChargeText.slice(ChargeText.indexOf("("));
  selectAirTableBack.querySelector("td:nth-child(8)").innerHTML =Charge;
}
// 왕복/다구간 시 항공편 선택한 후, 선택한 항공편 삭제하기 함수
function onAirPayRoundDelete() {
	var deleteBtnGo = document.getElementById("deleteBtnGo");
	var deleteBtnBack = document.getElementById("deleteBtnBack");

	deleteBtnGo.addEventListener("click", function(event) {
	  var tdList = event.target.parentNode.parentNode.parentNode.getElementsByTagName("td");
	  for (var i = 1; i < tdList.length -2; i++) {
	    tdList[i].textContent = "";
	  }
	});
	
	deleteBtnBack.addEventListener("click", function(event) {
	  var tdList = event.target.parentNode.parentNode.parentNode.getElementsByTagName("td");
	  for (var i = 1; i < tdList.length -2; i++) {
	    tdList[i].textContent = "";
	  }
	});
}
/*첫번째(인원수, 좌석등급) 팝업*/
document.addEventListener(`DOMContentLoaded`, () => {
	let bigNum = 1
	let midNum = 0
	let smallNum = 0
	let optionValue=""
	
	const popBigPlus = document.querySelector('#popBigPlus')
	const popBigNum = document.querySelector('#popBigNum')
	const popBigMinus = document.querySelector('#popBigMinus')
	
	const popMidPlus = document.querySelector('#popMidPlus')
	const popMidNum = document.querySelector('#popMidNum')
	const popMidMinus = document.querySelector('#popMidMinus')
	
	const popSmallPlus = document.querySelector('#popSmallPlus')
	const popSmallNum = document.querySelector('#popSmallNum')
	const popSmallMinus = document.querySelector('#popSmallMinus')
	
	const slct = document.querySelector('#slct')
	
	const popConfirm = document.querySelector('#popConfirm')
	const p_count = document.querySelector('#p_count')
	const p_level = document.querySelector('#p_level')
	
	popBigPlus.addEventListener(`click`, () => {
		if((bigNum + midNum + smallNum) >= 9) {
			alert("9명 이하로 설정이 가능합니다.")
		} else {
			bigNum++
			popBigNum.textContent = bigNum
		}
	})
	popBigMinus.addEventListener(`click`, () => {
		if(bigNum<=1) {
			alert("유/소아 단독예약 희망시 고객센터로 문의하세요");
		} else {
			if(smallNum == bigNum) {
				bigNum--
				popBigNum.textContent = bigNum
				smallNum--
				popSmallNum.textContent = smallNum
			} else {
				bigNum--
				popBigNum.textContent = bigNum
			}
		}
	})
	
	popMidPlus.addEventListener(`click`, () => {
		if((bigNum + midNum + smallNum) >= 9) {
			alert("9명 이하로 설정이 가능합니다.")
		} else {
			midNum++
			popMidNum.textContent = midNum
		}
	})
	popMidMinus.addEventListener(`click`, () => {
		if(midNum<=0) {
			
		} else {
			midNum--
			popMidNum.textContent = midNum
		}
	})
	
	popSmallPlus.addEventListener(`click`, () => {
		if((bigNum + midNum + smallNum) >= 9) {
			alert("9명 이하로 설정이 가능합니다.")
		} else {
			if(smallNum >= bigNum) {
				alert("유아는 좌석이 따로 배정되지 않으므로, 성인보다 많이 탑승할 수 없습니다.");
			} else {
				smallNum++
				popSmallNum.textContent = smallNum
			}
		}
	})
	popSmallMinus.addEventListener(`click`, () => {
		if(smallNum<=0) {
			
		} else {
			smallNum--
			popSmallNum.textContent = smallNum
		}
	})
	
	slct.addEventListener(`click`, () => {
		optionValue = slct.value
		//alert(optionValue)
	})
	
	popConfirm.addEventListener(`click`, () => {
		if(optionValue=="좌석 전체" || optionValue=="") {
			p_level.textContent = `좌석전체`;
		} else {
			p_level.textContent = `좌석등급 : `+optionValue;
		}
		
		p_count.textContent = `성인 `+bigNum+`명`;
		if(!(midNum==0)) {
			p_count.textContent += `, 소아 `+midNum+`명`;
		}
		if(!(smallNum==0)) {
			p_count.textContent += `, 유아 `+smallNum+`명`;
		}
		
	    document.cookie = `bigNum=${bigNum}`;
	    document.cookie = `midNum=${midNum}`;
	    document.cookie = `smallNum=${smallNum}`;
	})
})

document.addEventListener(`DOMContentLoaded`, () => {
	const p_count = document.querySelector('#p_count')
	
	if ( bigNumR !== undefined ) { /*&& midNumR !== undefined && smallNumR !== undefined*/
	    const sum = parseInt(bigNumR) + parseInt(midNumR); /*+ parseInt(smallNumR);*/
		p_count.textContent = `성인 `+bigNumR+`명`;
		if( !(midNumR==0) && (midNumR !== undefined) ) {
			p_count.textContent += `, 소아 `+midNumR+`명`;
		}
		if( !(smallNumR==0) && (smallNumR !== undefined) ) {
			p_count.textContent += `, 유아 `+smallNumR+`명`;
		}
		 p_count.textContent += `\n=> 총 결제인원 : `+sum+`명`;
	  } else {
		bigNumR = 1;
	}
})

/*아동 및 유아 예약 안내*/
document.addEventListener(`DOMContentLoaded`, () => {
	const unCheckBtn = document.querySelector('#unCheckBtn');
	const checkBtn = document.querySelector('#checkBtn');
	//const menubar01 = document.querySelector('#menubar01');
	
	document.getElementById("unCheckBtn").style.display ='none';
	document.getElementById("menubar01").style.display ='none';
	
	checkBtn.addEventListener(`click`, () => {
		document.getElementById("unCheckBtn").style.display ='inline';
		document.getElementById("menubar01").style.display ='inline-block';
		document.getElementById("checkBtn").style.display ='none';
	})
	unCheckBtn.addEventListener(`click`, () => {
		document.getElementById("checkBtn").style.display ='inline';
		document.getElementById("menubar01").style.display ='none';
		document.getElementById("unCheckBtn").style.display ='none';
	})
})

//링크복사
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

 src="https://code.jquery.com/jquery-3.6.0.min.js"
/* jQuery */
/* 팝업 창 인원수 */
$(document).ready(function () {
  $("#pop_button").click(function () {
    $(".pop").fadeIn(300);
    //positionPopup();
  });

  $(".pop > span").click(function () {
    $(".pop").fadeOut(300);
  });
  $("#popConfirm").click(function () {
    $(".pop").fadeOut(300);
  });
  
  $(document).mouseup(function (e){
    if($(".pop").has(e.target).length === 0){
		$(".pop").hide();
	}
  });
  $(document).keydown(function(e){
	//keyCode 구 브라우저, which 현재 브라우저
    var code = e.keyCode || e.which;
 
    if (code == 27) { // 27은 ESC 키번호
        $('.pop').hide();
    }
  });
});

/* 팝업 창 지도 출발 */
$(document).ready(function () {
  $("#pop2_button").click(function () {
    $(".pop2").fadeIn(300);
    //positionPopup();
  });

  $(".pop2 > span").click(function () {
    $(".pop2").fadeOut(300);
  });
  $("#pop2Confirm").click(function () {
    $(".pop2").fadeOut(300);
  });
  $("#placeslistInput").click(function () {
    $(".pop2").fadeOut(300);
  });
  $(document).mouseup(function (e){
    if($(".pop2").has(e.target).length === 0){
		$(".pop2").hide();
	}
  });

  $(document).keydown(function(e){
	//keyCode 구 브라우저, which 현재 브라우저
    var code = e.keyCode || e.which;
 
    if (code == 27) { // 27은 ESC 키번호
        $('.pop2').hide();
    }
  });
});

$(document).ready(function () {
  $("#placeslistInput").click(function () {
    $(".pop2").fadeOut(300);
  });
});
					
/* 팝업 창 지도 도착 */
$(document).ready(function () {
    $("#pop3_button").click(function () {
      $(".pop3").fadeIn(300);
      //positionPopup();
    });

	$(".pop3 > span").click(function () {
	    $(".pop3").fadeOut(300);
	  });
	$("#pop3Confirm").click(function () {
	    $(".pop3").fadeOut(300);
	  });
	
	$(document).mouseup(function (e){
	    if($(".pop3").has(e.target).length === 0){
			$(".pop3").hide();
		}
	  });
  	
	$(document).keydown(function(e){
		//keyCode 구 브라우저, which 현재 브라우저
	    var code = e.keyCode || e.which;
	 
	    if (code == 27) { // 27은 ESC 키번호
	        $('.pop3').hide();
	    }
	});
});

/*재선 오빠 date*/
$(document).ready(function () {
     $.datepicker.setDefaults($.datepicker.regional['ko']); 
     $( "#startDate" ).datepicker({
          changeMonth: true, 
          changeYear: true,
          nextText: '다음 달',
          prevText: '이전 달', 
          dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
          dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
          monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          dateFormat: "yymmdd",
          minDate: 0,
          maxDate: 90,	// 선택할수있는 최소날짜, ( 0 : 오늘 이후 날짜 선택 불가)
          onClose: function( selectedDate ) {    
				if(selectedDate != '연도-월-일') {
					console.log("startDate가 변경됨 : " + selectedDate);
					$('#p_startDate').text(selectedDate);
				}
               //시작일(startDate) datepicker가 닫힐때
               //종료일(endDate)의 선택할수있는 최소 날짜(minDate)를 선택한 시작일로 지정
              $("#endDate").datepicker( "option", "minDate", selectedDate );
          }    

     });
     $( "#endDate" ).datepicker({
          changeMonth: true, 
          changeYear: true,
          nextText: '다음 달',
          prevText: '이전 달', 
          dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
          dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
          monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          dateFormat: "yymmdd",
          minDate: 1,
          maxDate: 300,	// 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
          onClose: function( selectedDate ) {  
			  if(selectedDate != '연도-월-일') {
					console.log("endDate가 변경됨 : " + selectedDate);
					$('#p_endDate2').text(selectedDate);
				}  
              // 종료일(endDate) datepicker가 닫힐때
              // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
              $("#startDate").datepicker( "option", "maxDate", selectedDate );
          }    
     });   
	$( "#reStartDate" ).datepicker({
          changeMonth: true, 
          changeYear: true,
          nextText: '다음 달',
          prevText: '이전 달', 
          dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
          dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'], 
          monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          monthNames: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월'],
          dateFormat: "yymmdd",
          minDate: 1,
          maxDate: 300,	// 선택할수있는 최대날짜, ( 0 : 오늘 이후 날짜 선택 불가)
          onClose: function( selectedDate ) {    
              // 종료일(endDate) datepicker가 닫힐때
              // 시작일(startDate)의 선택할수있는 최대 날짜(maxDate)를 선택한 시작일로 지정
              $("#startDate").datepicker( "option", "maxDate", selectedDate );
          }    
     });   
});
/*function myFetch(url, param, handler) {

	fetch(url, {
		method:'POST',
		headers: {
			"Content-Type" : "application/json; charset=UTF-8",
			},        
		body: JSON.stringify(param),
	})
	.then((response) => response.json())
	.then((data) => {
		if(data.status) {
			if (handler != null) {
				handler(data); // 응답데이터로 처리할 로직을 handler 함수에 정의
			}
		}
	})
}*/

/* fetch 함수 */
function myFetch(url, option,  handler) {

	fetch(url, option)
	.then((response) => response.json())
	.then((data) => {
		if(data.status) {
			if (handler != null) {
				handler(data); // 응답데이터로 처리할 로직을 handler 함수에 정의
			}
		}
	})
}

/* 메뉴 관리 모달창 */
const menuModal = $("#menuModal");

/* 메뉴 관리 모달창 > select option 목록 이벤트 핸들러 */
$(".openMenuController").on("click" , () => {
	const menuSelectListBody = $("#tbody");
	const menuItem = $("#menu-item");
	const url = "/admin/menulist/N/N"; // 등록여부: N, 카테고리: N 인 모든 목록 조회
	
	myFetch(url,{method: "GET"}, data => {
		console.log(data);
		// 상품 리스트 테이블에 가져온 상품 목록을 하나씩 추가
		const menuListData = data.menuList; 
		menuListData.forEach((menu) => {
			menuItemClone = menuItem.clone();
			menuItemClone.find(".category").text(menu.MENU_CATEGORY);
			menuItemClone.find(".menuName").text(menu.ITEM_NAME);
			menuItemClone.find(".menuPrice").text(menu.SELLING_PRICE);
			menuItemClone.find(".menuId").text(menu.ITEM_ID);
			menuItemClone.show();
			menuSelectListBody.append(menuItemClone);
		})
		
		menuModal.addClass('on');
	} )
	
})

/* 메뉴 관리 모달창 > select option 목록 이벤트 핸들러 */
 $('.form-select').on('change', () => {
    let selectedValue =  $('.form-select').find(":selected").val();
    console.log('선택한 값: ' + selectedValue);
    
	const menuSelectListBody = $("#tbody");
	const menuItem = $("#menu-item");
	const url = "/admin/menulist/N/" + selectedValue;
	menuSelectListBody.empty();
	
	myFetch(url,{method: "GET"}, data => {
		console.log(data);
		const menuListData = data.menuList;
		menuListData.forEach((menu) =>{
			menuItemClone = menuItem.clone();
			menuItemClone.find(".category").text(menu.MENU_CATEGORY);
			menuItemClone.find(".menuName").text(menu.ITEM_NAME);
			menuItemClone.find(".menuPrice").text(menu.SELLING_PRICE);
			menuItemClone.find(".menuId").text(menu.ITEM_ID);
			menuItemClone.show();
			menuSelectListBody.append(menuItemClone);
		})
		
		menuModal.addClass('on');
	} )
    
  });

/* 메뉴 관리 모달창 닫기 */
$('#closeModalBtn').on('click', () => {
	console.log("닫힘");
    // 모달 창이 닫힐 때 id="selectedItem"의 값을 초기화
    $('.form-select').val('N');
    
    // 이미지의 src를 초기화
    $('#inputGroupFile02').val('');
    $('#preview').attr('src', '');
    $('#preview').css('display', 'none');
	 
	 menuModal.removeClass('on');  
});

/* 메뉴 등록 (menu_checked : N => Y) */
$("#addMenuBnt").on("click", () => {
	// 체크된 tr의 menuId 클래스명을 가진 요소의 텍스트 값을 저장할 배열을 만듭니다.
	let checkedMenuIds = [];
	
	// 'menuChecked' 클래스명을 가진 체크박스 중에서 체크된 항목을 찾습니다.
	$('.menuChecked #checkedBox:checked').each(function() {
	    // 각 체크된 항목의 부모 <tr>에서 menuId 클래스명을 가진 요소의 텍스트 값을 가져와서 배열에 추가합니다.
	    let menuIdText = $(this).closest('tr').find('.menuId').text();
	    checkedMenuIds.push(menuIdText);
	});
	
	
	if(checkedMenuIds.length == 0) {
		alert("등록하실 메뉴를 선택해주세요.")
	} else if(checkedMenuIds.length > 1) {
		alert("메뉴는 한 개만 선택해주세요.")
	} else {
		
	// 체크된 항목의 menuId 값을 확인합니다.
	$('#selectedItem').val(checkedMenuIds[0]);
	console.log($('#selectedItem').val());
		
		const formData = new FormData($("#menuForm")[0]);
		const url = "/admin/addMenu";
		
		fetch(url, {
			method:'POST',
			body: formData
		})
		.then((response) => response.json())
		.then((data) => {
			if(data.status) {
				
				alert(data.message); 
				console.log(data.menu);
				
				// 메뉴 등록 후 반환받은 정보를 menuList 그리드에 추가
				const cardDate = data.menu;
				const menuList = $('.menuList');
				const cardItem = $('#cardItem').clone();
				cardItem.find('img').attr('src', '/image/download/' + cardDate.IMG_ID);
				cardItem.find('.fw-bolder.menuName').text(cardDate.ITEM_NAME);
				cardItem.find('.fw-bolder.menuPrice').text(cardDate.SELLING_PRICE);
				cardItem.find('#deleteMenuBnt').attr('menuId', cardDate.ITEM_ID);
				cardItem.show();
				
				menuList.append(cardItem);
				menuModal.removeClass('on'); 

			}
		})
	}
})

/* 메뉴 삭제 (menu_checked : Y => N) */
function deleteMenu(element) {
	if(confirm("메뉴를 삭제하시겠습니까?")){
		let menuId = element.getAttribute('menuId');
    
    	let url = "/admin/deleteMenu/" + menuId; // menuId = item테이블의 item_id
    
		myFetch(url, {mothod: "GET"}, data => {
			if(data.status) {
				alert(data.message);
				
				// 메뉴판에서 해당 메뉴 삭제하는 코드 추가
			    element.closest('.col.mb-5').remove();
			}
		})
	}
}

/* 첨부파일 이벤트 핸들러 */
$(document).on("change", ".form-control", function(){
    let selectedFile = this.files[0];
    let preView = $("#preview")[0]; // jQuery 객체를 JavaScript DOM 요소로 변환

    if (selectedFile) {
        let reader = new FileReader();
        reader.onload = function(e) {
            preView.src = e.target.result;
            preView.style.display = "block";
        }
        reader.readAsDataURL(selectedFile);
    } else {
        alert("이미지 파일을 선택하세요");
        $(this).val(""); // 파일 입력 내용 지우기
        preView.src = ""; // 미리보기 이미지 제거
    }
});


/*대시보드 */
/****** 시간대별 이용자 수 (로그인 시간 기준) ******/
const getHourlyUsersUrl = "/admin/getHourlyUsers";
myFetch(getHourlyUsersUrl, {method: "GET"}, response => {
	const hourlyUsersData = response.data;


const areaChartLabels = [];
let hour = 0;
for(i=0; i<24; i++) {
	areaChartLabels.push(hour + "시");
	hour++;
}

createAreaChart($('#areaChart1'), areaChartLabels , hourlyUsersData.year.users);
createAreaChart($('#areaChart2'), areaChartLabels , hourlyUsersData.month.users);
createAreaChart($('#areaChart3'), areaChartLabels , hourlyUsersData.day.users);
})

//--------------
//- AREA CHART -
//--------------

function createAreaChart(chart, labels, data) {

	var areaChartCanvas = chart.get(0).getContext("2d");
		
	var areaChartData = {
	  labels: labels,
	  datasets: [
	    {
	      label: "Hourly Users",
	      backgroundColor: "rgba(60,141,188,0.9)",
	      borderColor: "rgba(60,141,188,0.8)",
	      pointRadius: false,
	      pointColor: "#3b8bba",
	      pointStrokeColor: "rgba(60,141,188,1)",
	      pointHighlightFill: "#fff",
	      pointHighlightStroke: "rgba(60,141,188,1)",
	      data: data,
	    },
	  ],
	};
	
	var areaChartOptions = {
	  maintainAspectRatio: false,
	  responsive: true,
	  legend: {
	    display: false,
	  },
	  scales: {
	    xAxes: [
	      {
	        gridLines: {
	          display: false,
	        },
	      },
	    ],
	    yAxes: [
	      {
	        gridLines: {
	          display: false,
	        },
	      },
	    ],
	  },
};

// This will get the first returned node in the jQuery collection.
new Chart(areaChartCanvas, {
  type: "line",
  data: areaChartData,
  options: areaChartOptions,
});
	
	
}

/****** 전일, 금일 이용자 수 (월별 매출) ******/
const getUserCountUrl = "/admin/getUserCount";

const lastdayUsers = $('.lastdayUsers');
const todayUsers = $('.todayUsers');


myFetch(getUserCountUrl, {method: "GET"}, response =>{
		const lastDayUserCnt = response.data.lastday;
		const todayUserCnt = response.data.today;
		
		console.log(lastDayUserCnt + " " +todayUserCnt);
		
		
		
		lastdayUsers.text(lastDayUserCnt);
		todayUsers.text(todayUserCnt);
})
	
	
/****** 파이차트 (많이 팔린 메뉴 - 연, 월, 일) ******/
const pieChartUrl = "/admin/chartPieData";

myFetch(pieChartUrl, {method: "GET"}, response => {
	const pieChartData = response.data;
	console.log("pieCartData" + pieChartData);
	createPieChart($("#pieChart1"),pieChartData.year.top6Menu, pieChartData.year.top6Sales); // 연
	createPieChart($("#pieChart2"),pieChartData.month.top6Menu, pieChartData.month.top6Sales); // 월
	createPieChart($("#pieChart3"),pieChartData.day.top6Menu, pieChartData.day.top6Sales); // 일
		
})


function createPieChart(chart, labels, data) {
	
	if(labels == null) {
		chart.closest('.tab-pane').removeClass('on');
		$('.tab-pane.nonData').addClass('on');
	} else {
		// -------------
    // - PIE CHART -
    // -------------
    // Get context with jQuery - using jQuery's .get() method.

    var donutData = {
      /*labels: ["신라면", "참깨라면", "콜라", "사이다", "소떡소떡", "짜파게티"],*/
      labels: labels,
      datasets: [
        {
          /*data: [700, 500, 400, 600, 300, 100],*/
          data: data,
          backgroundColor: [
            "#f56954",
            "#00a65a",
            "#f39c12",
            "#00c0ef",
            "#3c8dbc",
            "#d2d6de",
          ],
        },
      ],
    };
    var donutOptions = {
      maintainAspectRatio: false,
      responsive: true,
    };

    var pieChartCanvas = chart.get(0).getContext("2d");
    var pieData = donutData;
    var pieOptions = {
      maintainAspectRatio: false,
      responsive: true,
    };

    // Create pie or douhnut chart
    // You can switch between pie and douhnut using the method below.

    new Chart(pieChartCanvas, {
      type: "pie",
      data: pieData,
      options: pieOptions,
    });
	}
}


/****** 스택 바 차트 (월별 매출), 라인 차트 (월별 이용자수) ******/
const url = "/admin/chartData";
const labels = [];

const today = new Date();
const thisMonth = today.getMonth(); // 0부터 시작 
const lastMonthSalse = $('.lastMonthSalse');
const thisMonthSalse = $('.thisMonthSalse');


myFetch(url, {method: "GET"}, response =>{
	const menuData = response.data.menu;
	const pcData = response.data.pc;
	const total = response.data.total;
	const users = response.data.users;
	
	/*console.log("지난달 매출" +  menuData);
	console.log("이번달 매출" +  pcData);
	console.log("지난달 매출" +  total[thisMonth -1]);
	console.log("이번달 매출" +  total[thisMonth]);*/
	lastMonthSalse.text(Number(total[thisMonth -1]).toLocaleString('ko-KR') + "원");
	thisMonthSalse.text(Number(total[thisMonth]).toLocaleString('ko-KR') + "원");

    //---------------------
    //- STACKED BAR CHART -
    //---------------------

    var stackedChartData = {
      labels: [
        "Jan", "Feb", "Mar","Apr", "May", "Jun"
        , "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
      ],

      datasets: [
        {
          label: "음식 판매",
          backgroundColor: "rgba(60,141,188,0.9)",
          borderColor: "rgba(60,141,188,0.8)",
          pointRadius: false,
          pointColor: "#3b8bba",
          pointStrokeColor: "rgba(60,141,188,1)",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(60,141,188,1)",
          /* data: [28, 48, 40, 19, 24, 27, 30, 20, 15, 23, 31, 35], */
          data: menuData,
        },
        {
          label: "PC방 이용",
          backgroundColor: "rgba(210, 214, 222, 1)",
          borderColor: "rgba(210, 214, 222, 1)",
          pointRadius: false,
          pointColor: "rgba(210, 214, 222, 1)",
          pointStrokeColor: "#c1c7d1",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(220,220,220,1)",
          /* data: [65, 59, 80, 81, 56, 55, 40, 90, 60, 57, 76, 83], */
          data: pcData,
        },
      ],
    };

    var barChartData = $.extend(true, {}, stackedChartData);
    var temp0 = stackedChartData.datasets[0];
    var temp1 = stackedChartData.datasets[1];
    barChartData.datasets[0] = temp1;
    barChartData.datasets[1] = temp0;

    var stackedBarChartCanvas = $("#stackedBarChart")
      .get(0)
      .getContext("2d");
    var stackedBarChartData = $.extend(true, {}, barChartData);

    var stackedBarChartOptions = {
      responsive: true,
      maintainAspectRatio: false,
      scales: {
        xAxes: [
          {
            stacked: true,
          },
        ],
        yAxes: [
          {
            stacked: true,
          },
        ],
      },
    };

    new Chart(stackedBarChartCanvas, {
      type: "bar",
      data: stackedBarChartData,
      options: stackedBarChartOptions,
    });
    
    

    //-------------
    //- LINE CHART -
    //--------------

    var lineChartData = {
      labels: [
        "Jan", "Feb", "Mar","Apr", "May", "Jun"
        , "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
      ],

      datasets: [
        {
          label: "이용자수",
          backgroundColor: "rgba(60,141,188,0.9)",
          borderColor: "rgba(60,141,188,0.8)",
          pointRadius: false,
          pointColor: "#3b8bba",
          pointStrokeColor: "rgba(60,141,188,1)",
          pointHighlightFill: "#fff",
          pointHighlightStroke: "rgba(60,141,188,1)",
          /*data: [
            28, 48, 40, 19, 24, 27, 30, 20, 15, 23, 31, 35, 28, 48, 40, 19,
            24, 27, 30, 20, 15, 23, 31, 35,
          ],*/
          data: users,
        },
      ],
    };

    var lineChartDataOptions = {
      maintainAspectRatio: false,
      responsive: true,
      legend: {
        display: false,
      },
      scales: {
        xAxes: [
          {
            gridLines: {
              display: false,
            },
          },
        ],
        yAxes: [
          {
            gridLines: {
              display: false,
            },
          },
        ],
      },
    };

    var lineChartCanvas = $("#lineChart").get(0).getContext("2d");
    var lineChartOptions = $.extend(true, {}, lineChartDataOptions);
    var lineChartData = $.extend(true, {}, lineChartData);
    lineChartData.datasets[0].fill = false;
    lineChartOptions.datasetFill = false;

    new Chart(lineChartCanvas, {
      type: "line",
      data: lineChartData,
      options: lineChartOptions,
    });
}) 

	

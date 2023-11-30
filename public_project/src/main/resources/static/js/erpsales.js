//엑셀 다운로드
$(document).ready(function() {
    $('#excelDownload').on("click", function() {
        var form = $("#salesExcel");
		
		form.target="_blank";
        // 폼 서브밋
       	form.submit();
    });
});


//테이블 공백 생성
function addEmptyRowsToTable(tableId) {
    var rowCount = $(tableId + ' tr').length;
    var remainingRows = 10 - rowCount;

    if (remainingRows > 0) {
        for (var i = 0; i < remainingRows; i++) {
            $(tableId).append('<tr>' +
                '<td>&nbsp;</td>' +
                '<td>&nbsp;</td>' +
                '<td>&nbsp;</td>' +
                '<td>&nbsp;</td>' +
                '<td>&nbsp;</td>' +
                '<td>&nbsp;</td>' +
                '<td>&nbsp;</td>' +
                '<td>&nbsp;</td>' +
                '</tr>');
        }
    }
}

$(document).ready(function () {
    addEmptyRowsToTable('#paymTbody');
    addEmptyRowsToTable('#orderTbody');
});

//주문내역 합계 구하기
document.addEventListener("DOMContentLoaded", function() {
    orderTotals();
});

function orderTotals(){
	let totalStock = 0;
	let totalPrice = 0;
	
	const rows = document.querySelectorAll("#orderTbody tr");
	rows.forEach(function (row){
		const stockElement = row.querySelector(".order-data");
		const stock = stockElement ? parseInt(stockElement.dataset.order) : 0;
		
		const priceElement = row.querySelector("td:nth-child(6)");
		const priceString = priceElement ? priceElement.innerText.trim().replace("₩", "").replace(",", "") : '-';
		const price = priceString !== "-" ? parseFloat(priceString) : 0;
		
		totalStock += isNaN(stock) ? 0 : stock;
		totalPrice += isNaN(price) ? 0 : price;
	});
	
	  const totaTotalQuantity = document.getElementById("TotalQuantity");
	  if(totaTotalQuantity){
	  	totaTotalQuantity.innerText = totalStock.toLocaleString() + ' EA';
	  }
	  
	  const formOrderTotalPrice = document.getElementById("formOrderTotalPrice");
	  if(formOrderTotalPrice){
	  	formOrderTotalPrice.innerText = totalPrice.toLocaleString();
	  }
}

//매출내역 합계 구하기
document.addEventListener("DOMContentLoaded", function() {
    salesTotals();
});

function salesTotals() {
    let totalPrice = 0;
    let totalNetProfit = 0;

    const rows = document.querySelectorAll("#paymTbody tr");
    rows.forEach(function (row) {
		const priceElement = row.querySelector("td:nth-child(7)");
        const priceString = priceElement ? priceElement.innerText.trim().replace("₩", "").replace(",", "") : '-';
        const price = priceString !== "-" ? parseFloat(priceString) : 0;

		const netProfitElement = row.querySelector("td:nth-child(8)");
        const netProfitString = netProfitElement ? netProfitElement.innerText.trim().replace("₩", "").replace(",", "") : '-';
        const netProfit = netProfitString !== "-" ? parseFloat(netProfitString) : 0;

        totalPrice += isNaN(price) ? 0 : price;
        totalNetProfit += isNaN(netProfit) ? 0 : netProfit;
    });

    const fromSalesTotalPrice = document.getElementById("salesTotalPrice");
    if(fromSalesTotalPrice){
    	fromSalesTotalPrice.innerText = '₩' + totalPrice.toLocaleString();
    }

    const fromSalesTotalNetProfit = document.getElementById("formNetProfitTotalPrices");
    if(fromSalesTotalNetProfit){
    	fromSalesTotalNetProfit.innerText = totalNetProfit.toLocaleString();
    }
}

//새로고침 버튼 클릭시
//주문내역
function refreshOrderPage(){
	document.getElementById('startDate2').value = '';
    document.getElementById('endDate2').value = '';
    document.querySelector('.orderCodes').value = '';
    document.querySelector('.orderSelect').selectedIndex = 0; 
    document.querySelector('input[name="orderOption"][value="all"]').checked = true;

	//location.reload();
}
//매출내역
function refreshSalesPage(){
	document.getElementById('startDate').value = '';
    document.getElementById('endDate').value = '';
    document.querySelector('.paymName').value = '';
    document.querySelector('.orderCode').value = '';
    document.querySelector('.userName').value = '';

	//location.reload();
}

// 주문내역 상세 보기
function orderDetail(orderId) {
    const orderData = {
        orderId: orderId
    };
    $.ajax({
        type: 'POST',
        url: '/erp/orderView',
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(orderData),
        success: function(data) {
			
			$('#orderDetailTbody').empty();
				
				$.each(data.orderView, function(index, detail) {
                    var row = '<tr>' +
                        '<td>' + detail['index'] + '</td>' +
                        '<td>' + detail['orderId'] + '</td>' +
                        '<td>' + detail['orderDate'] + '</td>' +
                        '<td>' + detail['uname'] + '</td>' +
                        '<td>' + detail['itemName'] + '</td>' +
                        '<td>' + detail['quantity'] + '</td>' +
                        '<td>₩' + new Intl.NumberFormat().format(detail['paymentPrice']) + '</td>' +
                        '<td>₩' + new Intl.NumberFormat().format(detail['price']) + '</td>' +
                        '</tr>';
                    $('#orderDetailTbody').append(row);
                });
                
                $('.detail').css('display', 'block');
                $('.changePadding').css('padding', '0 15px');
        },
    });
}


//주문내역 조회 조건
function orderSearch(){
	
	const startDateValue = $('#startDate2').val();
	const endDateValue = $('#endDate2').val();
	const orderIdValue = $('.orderCode').val();
	const select = $('.orderSelect').val();
	const selectOrder = $('input[name="orderOption"]:checked').val();
	
	if(!startDateValue && !endDateValue && orderIdValue === '' && select === '' && selectOrder ===''){
		swal("경고!!", "조회 조건을 입력 해주세요.", 'warning');
		return;
	}
	
	LoadingWithMask('/images/loading.gif');

	const orderParam = {
		startDate: $('#startDate2').val().replace(/\//g, '-'),
		endDate: $('#endDate2').val().replace(/\//g, '-'),
		orderId: $('.orderCodes').val(),
		select: $('.orderSelect').val(),
		code: selectOrder		
	};
	
	$.ajax({
		url: '/erp/orderSearch',
		type: 'POST',
		contentType: "application/json; charset=UTF-8",
		data: JSON.stringify(orderParam),
		success: function (data){

			$('#orderTbody').empty();
			
			$.each(data.orderSearch, function(index, order){
								
			let row = '<tr>' +
				'<td>' + (order['index'] || '') + '</td>' +
		            '<td onclick="orderDetail(\'' + order['orderId'] + '\')" class="clickable-cell">' + order['orderId'] + '</td>' +
		            '<td>' + order['orderDate'] + '</td>' +
		            '<td>' + order['type'] + '</td>' +
		            '<td class="order-data" data-order="' + order['quantity'] + ' EA">' + order['quantity'] + ' EA</td>' +
		            '<td>₩' + new Intl.NumberFormat().format(order['price']) + '</td>' +
		            '<td>' + order['paymentMethod'] + '</td>' +
		            '<td style="color: ' + (order['paymentStatus'] === '판매' ? 'blue' : order['paymentStatus'] === '주문취소' ? 'red' : 'black')
		             + '">' + order['paymentStatus'] + '</td>' +
		            '</tr>';
				$('#orderTbody').append(row);
			});
			
			addEmptyRowsToTable('#orderTbody');
			
			orderTotals();
			
		 },
        error: function (error) {
            console.error('Ajax 요청 중 오류 발생: ', error);
        },
        complete: function () {
            closeLoadingWithMask();
        }
	});
}

//매출내역 조회 조건
function salesSearch(){
	
	const startDateValue = $('#startDate').val();
	const endDateValue = $('#endDate').val();
	const paymentidValue = $('#salesCode').val();
	const orderIdValue = $('.orderCode').val();
	const unmeValue = $('.userName').val();
	
	if(!startDateValue && !endDateValue && paymentidValue === '' && orderIdValue === '' && unmeValue === ''){
		swal("경고!!", "조회 조건을 입력 해주세요.", 'warning');
		return;
	}
	
	LoadingWithMask('/images/loading.gif');

	const salesParam = {
		startDate: $('#startDate').val().replace(/\//g, '-'),
		endDate: $('#endDate').val().replace(/\//g, '-'),
		paymentId: $('#salesCode').val(),
		orderId: $('.orderCode').val(),
		unme: $('.userName').val()		
	};
	
	$.ajax({
		url: '/erp/salesSearch',
		type: 'POST',
		contentType: "application/json; charset=UTF-8",
		data: JSON.stringify(salesParam),
		success: function (data){

			$('#paymTbody').empty();
			
			$.each(data.salesSearch, function(index, sales){
				let color;
				if (sales['type'] === 'PC이용'){
					color = '#87CEEB';
				} else if (sales['type'] === '메뉴주문'){
					color = '#70594d';
				}else{
					color = 'black';
				}
								
		let row = '<tr>' +
			'<td>' + (sales['index'] || '') + '</td>' +
                    '<td>' + sales['paymentId'] + '</td>' +
                    '<td>' + sales['orderId'] + '</td>' +
                    '<td>' + sales['paymentDate'] + '</td>' +
                    '<td>' + sales['uname'] + '</td>' +
                    '<td style="color: ' + color + '">' + sales['type'] + '</td>' +
                    '<td>₩' + new Intl.NumberFormat().format(sales['price']) + '</td>' +
                    '<td>₩' + new Intl.NumberFormat().format(sales['netProfit']) + '</td>' +
                    '</tr>';
			
				$('#paymTbody').append(row);
			});
			
			addEmptyRowsToTable('#paymTbody');
			
			salesTotals();
		 },
        error: function (error) {
            console.error('Ajax 요청 중 오류 발생: ', error);
        },
        complete: function () {
            closeLoadingWithMask();
        }
	});
}

//주문 내역 정렬
$(document).ready(function () {
	const originalRows = $('.orderSortable').closest('table').find('tbody:first > tr').toArray();
    $('.orderSortable').click(function () {
        const table = $(this).closest('table');
        const index = $(this).index();
        let rows;

        if ($(this).hasClass('asc')) {
            rows = table.find('tbody:first > tr').toArray().sort(comparator(index)).reverse();
            $(this).removeClass('asc').addClass('desc');
        } else if ($(this).hasClass('desc')) {
            $(this).removeClass('desc');
            $(this).addClass('reset');
            rows = originalRows;
        }else{
			$(this).addClass('asc');
			rows = table.find('tbody:first > tr').toArray().sort(comparator(index));
		}
		
		if($(this).hasClass('reset')){
			$(this).removeClass('reset');
			rows = originalRows;
		}
		
		table.find('.orderSortable').not(this).removeClass('asc desc reset');

        table.find('tbody:first').empty().append(rows);
    });

    function comparator(index) {
        return function (a, b) {
            var valA = getCellValue(a, index);
            var valB = getCellValue(b, index);

            if (index === 1 || index === 2) { // 주문전표, 건수
                return valA.localeCompare(valB);
            } else if (index === 4) { // 매출일자
                const dateA = new Date(valA);
                const dateB = new Date(valB);
                
                if(dateA.getFullYear() !== dateB.getFullYear()){
					return dateA.getFullYear() - dateB.getFullYear();
				}else if(dateA.getMonth() !== dateB.getMonth()){
					return dateA.getMonth() - dateB.getMonth();
				}else{
					return dateA.getDate() - dateB.getDate();
				}
            } else {
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB);
            }
        };
    }

    function getCellValue(row, index) {
        return $(row).children('td').eq(index).text();
    }
});

//매출 내역 정렬
$(document).ready(function () {
	const originalRows = $('.salesSortable').closest('table').find('tbody:first > tr').toArray();
	
    $('.salesSortable').click(function () {
        const table = $(this).closest('table');
        const index = $(this).index();
        let rows;

        if ($(this).hasClass('asc')) {
            rows = table.find('tbody:first > tr').toArray().sort(comparator(index)).reverse();
            $(this).removeClass('asc').addClass('desc');
        } else if ($(this).hasClass('desc')) {
            $(this).removeClass('desc');
            $(this).addClass('reset');
            rows = originalRows;
        }else{
			$(this).addClass('asc');
			rows = table.find('tbody:first > tr').toArray().sort(comparator(index));
		}
		
		if($(this).hasClass('reset')){
			$(this).removeClass('reset');
			rows = originalRows;
		}
		
		table.find('.salesSortable').not(this).removeClass('asc desc reset');
        table.find('tbody:first').empty().append(rows);
    });

    function comparator(index) {
        return function (a, b) {
            var valA = getCellValue(a, index);
            var valB = getCellValue(b, index);

            if (index === 1 || index === 2 || index === 4 ) { // 매출전표코드, 주문전표, 매출일자
                return valA.localeCompare(valB);
            } else if (index === 3) { // 매출일자
                const dateA = new Date(valA);
                const dateB = new Date(valB);
                
                if(dateA.getFullYear() !== dateB.getFullYear()){
					return dateA.getFullYear() - dateB.getFullYear();
				}else if(dateA.getMonth() !== dateB.getMonth()){
					return dateA.getMonth() - dateB.getMonth();
				}else{
					return dateA.getDate() - dateB.getDate();
				}
            } else {
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB);
            }
        };
    }

    function getCellValue(row, index) {
        return $(row).children('td').eq(index).text();
    }
});

/* 매출전표 검색 모달창 */
const erpModal = $('#erpModal');
$('#paymCodeFide').on('click', () => {
	erpModal.addClass('on');
})

$('#closeModalBtn').on('click', () => {
	resetModal();
	erpModal.removeClass('on');
})

/* 매출전표 검색 */
$('#searchSalesBnt').on('click', () => {
	const salesList = $('#tbody');
	const salesItem = $('#sales-item');
	
	const formData = {
		startDate: $('#startDate').val().replace(/\//g, '-'),
		endDate: $('#endDate').val().replace(/\//g, '-'),
		code: $('.salesType').val(),
		paymentId: $('.paymName').val(),
		orderId: $('.orderCode').val(),
		uname:$('.userName').val()		
	};
	
	const getSalesListUrl = '/erp/salesSearch';
	
	fetch(getSalesListUrl, {
		method:'POST',
		 headers: {
    'Content-Type': 'application/json',
  },
		body: JSON.stringify(formData),
	})
	.then((response) => response.json())
	.then((data) => {
		if(data) {
			salesList.empty();
			const salesListData = data.salesSearch;
			let rownum = 1;
			console.log('판매 목록 데이터:', salesListData);
			salesListData.forEach((sales) => {
				salesItemClone = salesItem.clone();
				salesItemClone.find('.rownum').text(rownum);
				salesItemClone.find('.paymentId').text(sales.paymentId);
				salesItemClone.find('.orderId').text(sales.orderId);
				salesItemClone.find('.paymentDate').text(sales.paymentDate);
				salesItemClone.find('.uname').text(sales.uname);
				salesItemClone.find('.type').text(sales.type);
				salesItemClone.find('.netProfit').text(sales.netProfit);
				salesItemClone.show();
				salesList.append(salesItemClone)
				rownum++;
			})
		} else {
			swal("Error",data.salesSearch,"error");
		}
	})
})

var previousClickedRow = null;
let salesCode = $('#modalSalesCode');
$(document).on('click', '#tbody tr', function () {
     if (previousClickedRow !==null && 
     (previousClickedRow.find('.rownum').text() == $(this).find('.rownum').text())) {
		previousClickedRow.css('background-color', '');
		 $(this).css('background-color', '');
		 previousClickedRow = null;
		 salesCode.val("");
		 
	} else {
	    // 이전에 클릭한 행의 배경색을 원래대로 복원
	    if (previousClickedRow !== null) {
	        previousClickedRow.css('background-color', '');
	    } 
	    // 새로 클릭한 행의 배경색 변경
	    $(this).css('background-color', '#e6e6fa');
	
	    // 현재 클릭한 행을 이전에 클릭한 행으로 저장
	    previousClickedRow = $(this);
	
	    // 해당 행의 paymentId 값을 가져와서 콘솔에 출력
	    var paymentId = $(this).find('.paymentId').text();
	    salesCode.val(paymentId);
		
	}

});

$('#selectSalesCodeBnt').on('click', () => {
	if($('#modalSalesCode').val() ==="" || $('#modalSalesCode').val() === null) {
		//alert("매출 전표를 선택해주세요");
		swal("경고!!", "매출 전표를 선택해주세요.","warning");
	} else {
		$('#salesCode').val($('#modalSalesCode').val());
		resetModal();
		erpModal.removeClass('on');
	}
})

function resetModal() {
    erpModal.find('#startDate').val('');
    erpModal.find('#endDate').val('');
    erpModal.find('.salesType').val('');
    erpModal.find('.paymName').val('');
    erpModal.find('.orderCode').val('');
    erpModal.find('.userName').val('');
    erpModal.find('#tbody').empty();
}



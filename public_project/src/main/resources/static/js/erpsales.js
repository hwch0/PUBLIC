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
	LoadingWithMask('/images/loading.gif');

	const selectOrder = $('input[name="orderOption"]:checked').val();

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
		            '<td>' + order['quantity'] + '</td>' +
		            '<td>₩' + new Intl.NumberFormat().format(order['price']) + '</td>' +
		            '<td>' + order['paymentMethod'] + '</td>' +
		            '<td style="color: ' + (order['paymentStatus'] === '판매' ? 'blue' : order['paymentStatus'] === '주문취소' ? 'red' : 'black')
		             + '">' + order['paymentStatus'] + '</td>' +
		            '</tr>';
				$('#orderTbody').append(row);
			});
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
	LoadingWithMask('/images/loading.gif');

	const salesParam = {
		startDate: $('#startDate').val().replace(/\//g, '-'),
		endDate: $('#endDate').val().replace(/\//g, '-'),
		paymentId: $('.paymName').val(),
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
	const originalRows = $('.orderSortable').closest('table').find('tbody > tr').toArray();
    $('.orderSortable').click(function () {
        const table = $(this).closest('table');
        const index = $(this).index();
        let rows;

        if ($(this).hasClass('asc')) {
            rows = table.find('tbody > tr').toArray().sort(comparator(index)).reverse();
            $(this).removeClass('asc').addClass('desc');
        } else if ($(this).hasClass('desc')) {
            $(this).removeClass('desc');
            $(this).addClass('reset');
            rows = originalRows;
        }else{
			$(this).addClass('asc');
			rows = table.find('tbody > tr').toArray().sort(comparator(index));
		}
		
		if($(this).hasClass('reset')){
			$(this).removeClass('reset');
			rows = originalRows;
		}
		
		table.find('.orderSortable').not(this).removeClass('asc desc reset');

        table.find('tbody').empty().append(rows);
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
	const originalRows = $('.salesSortable').closest('table').find('tbody > tr').toArray();
    $('.salesSortable').click(function () {
        const table = $(this).closest('table');
        const index = $(this).index();
        let rows;

        if ($(this).hasClass('asc')) {
            rows = table.find('tbody > tr').toArray().sort(comparator(index)).reverse();
            $(this).removeClass('asc').addClass('desc');
        } else if ($(this).hasClass('desc')) {
            $(this).removeClass('desc');
            $(this).addClass('reset');
            rows = originalRows;
        }else{
			$(this).addClass('asc');
			rows = table.find('tbody > tr').toArray().sort(comparator(index));
		}
		
		if($(this).hasClass('reset')){
			$(this).removeClass('reset');
			rows = originalRows;
		}
		
		table.find('.salesSortable').not(this).removeClass('asc desc reset');

        table.find('tbody').empty().append(rows);
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
/*
//모달창
const Modal = document.getElementById('erpModal');

console.log(Modal);

const paymFideBtn = $('#paymCodeFide');

paymFideBtn.on('click', function() {
    Modal.classList.add('on'); 
});

$(window).on('click', function(event) {
    if (event.target === Modal) {
        Modal.classList.remove('on'); 
    }
});

$('.close').on('click', function(e){
	 Modal.classList.remove('on'); 
});
*/
//주문내역 상세 보기
$(document).ready(function(){
	$('#orderCode').click(function(){
		const orderCode = $(this).text();
		//const detailInfo = getOrderDetailInfo(orderCode);
		
		$('.detail').show();
	})
})

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

            if (index === 1 || index === 2) { // 주문전표, 매출일자
                return valA.localeCompare(valB);
            } else if (index === 4) { // 건수
                return valA.localeCompare(valB);
            } else if (index === 5) { // 총 금액
                return parseFloat(valA.replace('￦', '').replace(',', '')) - parseFloat(valB.replace('￦', '').replace(',', ''));
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

            if (index === 1 || index === 2) { // 매출전표코드, 매출일자
                return valA.localeCompare(valB);
            } else if (index === 4 || index === 3) { // 회원이름, 사용시간
                return valA.localeCompare(valB);
            } else if (index === 5 || index === 6 || index === 7) { // 이용금액, 부가상품매출, 총매출
                return parseFloat(valA.replace('￦', '').replace(',', '')) - parseFloat(valB.replace('￦', '').replace(',', ''));
            } else {
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB);
            }
        };
    }

    function getCellValue(row, index) {
        return $(row).children('td').eq(index).text();
    }
});

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

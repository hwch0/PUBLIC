function itemCheck(){
	 // 선택한 조회 조건 값 가져오기
    const startDate = $("#startDate").val();
    const endDate = $("#endDate").val();
    const itemName = $(".itemName").val();
    const itemSelect = $(".itemSelect").val();
    const itemStockOption = $("input[name='itemStockOption']:checked").val();

	$.ajax({
		type: "POST",
		
	})
}


//품목 목록 정렬 
$(document).ready(function () {
   const originalRows = $('.itemSortable').closest('table').find('tbody > tr').toArray();

    $('.itemSortable').click(function () {
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
        } else {
            $(this).addClass('asc');
             rows = table.find('tbody > tr').toArray().sort(comparator(index));
        }
        
        if ($(this).hasClass('reset')) {
		    $(this).removeClass('reset');
		    rows = originalRows;
		}
        
        table.find('.itemSortable').not(this).removeClass('asc desc reset');
        
        table.find('tbody').empty().append(rows);
    });

    function comparator(index) {
        return function (a, b) {
            const valA = getCellValue(a, index);
            const valB = getCellValue(b, index);

            if (index === 1 || index === 2) { // 품목코드 또는 품목명
                return valA.localeCompare(valB);
            } else if (index === 4) { // 등록일
                return new Date(valA) - new Date(valB);
            } else if (index === 7 || index === 5 || index === 6) { // 평균단가, 현재재고, 전월재고
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


//입출고 정렬
$(document).ready(function () {
	const originalRows = $('.statusSortable').closest('table').find('tbody > tr').toArray();
    $('.statusSortable').click(function () {
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
		
		table.find('.itemSortable').not(this).removeClass('asc desc reset');

        table.find('tbody').empty().append(rows);
    });

    function comparator(index) {
        return function (a, b) {
            var valA = getCellValue(a, index);
            var valB = getCellValue(b, index);

            if (index === 1 || index === 2) { // 품목코드 또는 품목명
                return valA.localeCompare(valB);
            } else if (index === 4 || index === 3) { // 일자 또는 상세
                return valA.localeCompare(valB);
            } else if (index === 5 || index === 6 || index === 8) { // 입·출고수량, 입·출고단가, 총금액
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
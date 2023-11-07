//재고 상태 계산 및 표시
 function stockStatus(stock) {
        if (stock == null) {
            return '-';
         } else if (stock === 0) {
            return '<span class="sold-out">품절</span>';
         } else if (stock > 0 && stock <= 50) {
            return '<span class="warning">부족</span>';
         } else {
            return '<span class="good">양호</span>';
         }
    }
// 페이지가 로딩된 후 실행되는 부분
    document.addEventListener('DOMContentLoaded', function () {
        var stockCells = document.querySelectorAll('.stockStatus');
        stockCells.forEach(function (cell) {
            var stockValue = parseInt(cell.dataset.stock, 10); 
            cell.innerHTML = stockStatus(stockValue);
        });
    });

// 엑셀 다운로드
$(document).ready(function() {
    $('#Excel').on("click", function() {
        window.location.href = "/erp/download";
    })
})


//품목관리 조회조건
function searchData() {
    LoadingWithMask('/images/loading.gif');
    
    const selectedStockStatus = $('input[name="stockStatus"]:checked').val();
    
	const searchParams = {
	    startDate: $('#startDate').val().replace(/\//g, '-'),
	    endDate: $('#endDate').val().replace(/\//g, '-'),
	    itemName: $('.itemName').val(),
	    itemSelect: $('.itemSelect').val(),
	    stockStatus: selectedStockStatus
	};
        
    $.ajax({
        url: '/erp/search',
        type: 'POST',
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(searchParams),
        success: function (data) {
            console.log(searchParams);
            console.log(data.itemsearch);
            console.log(data);
            $('#itemTbody').empty();
            
            $.each(data.itemsearch, function(index, item){
				 let row = '<tr>' +
        '<td>' + (item['index'] || '') + '</td>' +
        '<td>' + item['ITEMID'] + '</td>' +
        '<td>' + item['ITEMNAME'] + '</td>' +
        '<td>' + item['TYPE'] + '</td>' +
        '<td>' + (item['STOREDATE'] == null ? '-' : item['STOREDATE']) + '</td>' +
        '<td>' + (item['STOCK'] == null ? '-' : item['STOCK']) + ' EA</td>' +        
        '<td>';

    if (item['PRICE'] != null) {
        row += new Intl.NumberFormat('ko-KR', { style: 'currency', currency: 'KRW' }).format(item['PRICE'])
    } else {
        row += '-';
    }

    row += '</td>' +
    '<td>' + stockStatus(item['STOCK']) + '</td></tr>';

    $('#itemTbody').append(row);
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

            if (index === 1 || index === 2 || index === 4) { // 품목코드, 품목명, 현재재고
                return valA.localeCompare(valB);
            } else if (index === 3) { // 입고일
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
		
		table.find('.statusSortable').not(this).removeClass('asc desc reset');

        table.find('tbody').empty().append(rows);
    });

    function comparator(index) {
        return function (a, b) {
            var valA = getCellValue(a, index);
            var valB = getCellValue(b, index);

            if (index === 1 || index === 2) { // 품목코드 또는 품목명
                return valA.localeCompare(valB);
            } else if (index === 4 ) { // 일자 또는 상세
                const dateA = new Date(valA);
                const dateB = new Date(valB);
                
                if(dateA.getFullYear() !== dateB.getFullYear()){
					return dateA.getFullYear() - dateB.getFullYear();
				}else if(dateA.getMonth() !== dateB.getMonth()){
					return dateA.getMonth() - dateB.getMonth();
				}else{
					return dateA.getDate() - dateB.getDate();
				}
            } else if (index === 5 || index === 6 || index === 7) { // 입·출고수량, 입·출고단가, 총금액
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
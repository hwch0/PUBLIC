//새로고침 버튼 클릭시
//입출고
function refreshStatusPage(){
	document.getElementById('startDate2').value = '';
    document.getElementById('endDate2').value = '';
    document.querySelector('.statusCode').value = '';
    document.querySelector('input[name="status"][value="all"]').checked = true;
    document.querySelector('.statusName').value = '';

	//location.reload();
}
//재고목록
function refreshStockPage(){
	document.getElementById('startDate').value = '';
    document.getElementById('endDate').value = '';
    document.querySelector('.itemName').value = '';
    document.querySelector('.itemSelect').selectedIndex = 0; 
    document.querySelector('input[name="stockItem"][value="1"]').checked = true;

	//location.reload();
}

//엑셀다운로드 등록 모달창
const ExcelDownloadModel = $("#ExcelDownloadModel");

$(document).ready(function() {

    const ExcelBtn = $("#excelDownloadBnt");
    const ExcelDownloadModel = $("#ExcelDownloadModel");

    ExcelBtn.on("click", function() {
        ExcelDownloadModel.addClass("on");
    });

    const closeModelBtn = $("#closeExcelDownloadlBtn");

    closeModelBtn.on("click", function() {
        ExcelDownloadModel.removeClass("on");
    });
});

//엑셀 업로드 모달창
$(document).ready(function() {

    $("#excelUploadBnt").on("click", function() {
        // 기존 모달창 닫기
        $("#statusModel").removeClass("on");
        
        // 새로운 모달창 열기
        $("#ExcelUploadModel").addClass("on");
    });

    const closeModelBtn = $("#closeExcelUploadModelBtn");

    closeModelBtn.on("click", function() {
        // 현재 열려있는 모든 모달창 닫기
        $(".modal").removeClass("on");
    });
});

//엑셀 업로드 alert창
$(document).ready(function() {

    $("#uploadBtn").on("click", function() {

        alert("엑셀 업로드 되었습니다.");

        $(".modal").removeClass("on");
    });
});

//입출고 등록 모달창
const statusModel = $("#statusModel");

$(document).ready(function() {

    const statusBtn = $("#stickBtn");
    const statusModel = $("#statusModel");

    statusBtn.on("click", function() {
        statusModel.addClass("on");
    });

    const closeModelBtn = $("#closeStatusModelBtn");

    closeModelBtn.on("click", function() {
        statusModel.removeClass("on");
    });
});

//입출고 등록버튼 alert창
$(document).ready(function() {

    $("#statusInsertBnt").on("click", function() {

        alert("등록이 완료되었습니다.");

        $(".modal").removeClass("on");
    });
});


//품목 등록 모달창
const stockModel = $("#stockModel");

$(document).ready(function() {
    const stockBtn = $("#stockBtn");
    const stockModel = $("#stockModel");

    stockBtn.on("click", function() {
        stockModel.addClass("on");
    });

    const closeModelBtn = $("#closeModelBtn");

    closeModelBtn.on("click", function() {
        stockModel.removeClass("on");
    });
});

//등록버튼 alert창
$(document).ready(function() {

    $("#insertBnt").on("click", function() {

        alert("등록이 완료되었습니다.");

        $(".modal").removeClass("on");
    });
});

//재고 상태 계산 및 표시 1
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
// 페이지가 로딩된 후 실행되는 부분 2
    document.addEventListener('DOMContentLoaded', function () {
        var stockCells = document.querySelectorAll('.stockStatus');
        stockCells.forEach(function (cell) {
            var stockValue = parseInt(cell.dataset.stock, 10); 
            cell.innerHTML = stockStatus(stockValue);
        });
    });

// 재고목록 다운로드
$(document).ready(function() {
    $('#Excel').on("click", function() {
        window.location.href = "/erp/download";
    })
})

//입출고 내역 다운
$(document).ready(function() {
    $('#ExcelDownload').on("click", function() {

        $('#ExcelDownloadModel').modal('hide');

         downloadFile("/erp/statusDownload");
    });
});

//업로드용 다운로드
$(document).ready(function() {
    $('#ExcelFormDownload').on("click", function() {
		
        $('#ExcelDownloadModel').modal('hide');

        downloadFile("/erp/excelDownload");
    });
});
function downloadFile(url) {
    // AJAX를 통해 파일 다운로드
    $.ajax({
        url: url,
        method: "GET",
        xhrFields: {
            responseType: 'blob'
        },
        success: function(data, status, xhr) {
            // 다운로드 성공 시 파일 다운로드
            var filename = "";
            var disposition = xhr.getResponseHeader('Content-Disposition');
            if (disposition && disposition.indexOf('attachment') !== -1) {
                var filenameRegex = /filename[^;=\n]*=((['"]).*?\2|[^;\n]*)/;
                var matches = filenameRegex.exec(disposition);
                if (matches != null && matches[1]) filename = matches[1].replace(/['"]/g, '');
            }

            var blob = new Blob([data], { type: xhr.getResponseHeader('Content-Type') });

            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = filename;

            document.body.appendChild(link);
            link.click();

            document.body.removeChild(link);
        }
    });
}

//입출고 조회조건
function statusSearch() {
    LoadingWithMask('/images/loading.gif');
    
    const selectedStatus = $('input[name="status"]:checked').val();
    
	const searchParam = {
	    startDate: $('#startDate2').val().replace(/\//g, '-'),
	    endDate: $('#endDate2').val().replace(/\//g, '-'),
	    code: $('.statusCode').val() || null,
	    status: selectedStatus,
	    name: $('.statusName').val() || null
	};
        
    $.ajax({
        url: '/erp/statusStatus',
        type: 'POST',
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(searchParam),
        success: function (data) {
            console.log(searchParam);
            console.log(data.itemsearch);
            console.log(data);
            $('#statusTbody').empty();
            
            $.each(data.statusSearch, function(index, status){
				 let row = '<tr>' +
        '<td>' + (status['index'] || '') + '</td>' +
        '<td>' + status['ITEM_ID'] + '</td>' +
        '<td>' + status['ITEM_NAME'] + '</td>' +
        '<td>' + status['STATUSDATE'] + '</td>' +    
        '<td style="color: ' + 
            (status['INCDEC'] === '입고' ? 'blue' : (status['INCDEC'] === '출고' ? 'red' : 'black')) + '">' +
            status['INCDEC'] + '</td>' +
        '<td>' + status['STOCK'] + '</td>' +
        '<td>₩' + new Intl.NumberFormat().format(status['PRICE']) + '</td>' +
        '<td>₩' + new Intl.NumberFormat().format(status['STOCK'] * status['PRICE']) + '</td>' +
        '</tr>';

    $('#statusTbody').append(row);
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

//품목관리 조회조건
function searchData() {
    LoadingWithMask('/images/loading.gif');
    
    const selectedStockStatus = $('input[name="stockItem"]:checked').val();
    
	const searchParams = {
	    startDate: $('#startDate').val().replace(/\//g, '-'),
	    endDate: $('#endDate').val().replace(/\//g, '-'),
	    name: $('.itemName').val(),
	    select: $('.itemSelect').val(),
	    stock: selectedStockStatus
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
            } else {
                return $.isNumeric(valA) && $.isNumeric(valB) ? valA - valB : valA.localeCompare(valB);
            }
        };
    }

    function getCellValue(row, index) {
        return $(row).children('td').eq(index).text();
    }
});

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

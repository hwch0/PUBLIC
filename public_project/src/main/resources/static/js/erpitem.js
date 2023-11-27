function statusCodeList() {
    $.ajax({
        url: '/erp/statusCode',
        contentType: "application/json; charset=UTF-8",
        type: 'GET',
        dataType: 'json',
        success: function(data){
            const selectElement = $('#statusCode');

            $.each(data, function(index, item) {

                selectElement.append('<option value="' + item.ITEMID + '">' + item.ITEMNAME + '</option>');
            });
        },
        error: function(err){
            console.error('데이터를 불러오는 도중 에러 발생: ' , err);
        }
    });
}

$(document).ready(function(){
	statusCodeList();
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
    addEmptyRowsToTable('#itemTbody');
    addEmptyRowsToTable('#statusTbody');
});

//입출고 합계 구하기
document.addEventListener("DOMContentLoaded", function() {
	statusTotals();
});

function statusTotals(){
	let totalStock = 0;
	let totalPrice = 0;
	let totalPrices = 0;
	
	const rows = document.querySelectorAll("#statusTbody tr");
	rows.forEach(function (row){
				
		const stockElement = row.querySelector(".status-stock");
		const stock = stockElement ? parseInt(stockElement.dataset.status) : 0;

		const priceElement = row.querySelector("td:nth-child(7)");
        const priceString = priceElement ? priceElement.innerText.trim().replace("₩", "").replace(",", "") : '-';
        const price = priceString !== "-" ? parseFloat(priceString) : 0;
		
		//총계 누적
		totalStock += isNaN(stock) ? 0 : stock;
		totalPrice += isNaN(price) ? 0 : price;
		totalPrices += isNaN(stock) || isNaN(price) ? 0 : stock * price;

	});
	  const totalStockElement = document.getElementById("statusTotalStock");
	  if(totalStockElement){
	  	totalStockElement.innerText = totalStock.toLocaleString() + ' EA';
	  }
	  
	   const formStatusTotalPrice = document.getElementById("form-status-TotalPrice");
	   if(formStatusTotalPrice){
	   	formStatusTotalPrice.innerText = totalPrice.toLocaleString();
	   }
	   
	   const formStatusTotalPrices = document.getElementById("form-status-TotalPrices");
	   if(formStatusTotalPrices){
	   	formStatusTotalPrices.innerText = totalPrices.toLocaleString();
	   }
}

// 입고 합계 구하기
document.addEventListener("DOMContentLoaded", function() {
	stockTotals();
});

function stockTotals(){
	let totalStock = 0;
	let totalPrice = 0;
	
	const rows = document.querySelectorAll("#itemTbody tr");
	rows.forEach(function (row){
		const stockElement = row.querySelector(".stock-data");
    	const stock = stockElement ? parseInt(stockElement.dataset.stock) : 0;
    	
        const priceElement = row.querySelector("td:nth-child(7)");
		const priceString = priceElement ? priceElement.innerText.trim().replace("₩", "").replace(",", "") : '-';
		const price = priceString !== '-' ? parseFloat(priceString) : 0;
		
		//총계 누적
		totalStock += isNaN(stock) ? 0 : stock;
		totalPrice += isNaN(price) ? 0 : price;
	});
		const totalStockElement = document.getElementById("totalStock");
		if (totalStockElement) {
		  totalStockElement.innerText = totalStock.toLocaleString() + ' EA';
		}
		
		const formattedTotalPriceElement = document.getElementById("formattedTotalPrice");
		if (formattedTotalPriceElement) {
		  formattedTotalPriceElement.innerText = totalPrice.toLocaleString();
		}
}

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
    document.querySelector('.itemSituation').selectedIndex = 0; 

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

function statusInsert(){
	
	const param = {
		itemId: statusCode.value,
    	stock: statusQuantity.value,
    	price: statusPrices.value,
    	itemTypeCode: statusType.value
	};
	
	$.ajax({
		type: "POST",
		url: "/erp/insertStatus",
		contentType: "application/json; charset=UTF-8",
		data: JSON.stringify(param),
		dataType: "json",
		success: function(json){
			alert(json.message);
			statusModel.dialog("close");
		},
	});
}

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
        '<td class="status-stock" data-status="' + status['STOCK'] + ' EA">' + status['STOCK'] + '</td>' +
        '<td>₩' + new Intl.NumberFormat().format(status['PRICE']) + '</td>' +
        '<td>₩' + new Intl.NumberFormat().format(status['STOCK'] * status['PRICE']) + '</td>' +
        '</tr>';

    $('#statusTbody').append(row);
			});
            
            addEmptyRowsToTable('#statusTbody');
            
            statusTotals();
            
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
    
	const searchParams = {
	    startDate: $('#startDate').val().replace(/\//g, '-'),
	    endDate: $('#endDate').val().replace(/\//g, '-'),
	    name: $('.itemName').val(),
	    select: $('.itemSelect').val(),
	    stock: $('.itemSituation').val()
	};
        
    $.ajax({
        url: '/erp/search',
        type: 'POST',
        contentType: "application/json; charset=UTF-8",
        data: JSON.stringify(searchParams),
        success: function (data) {
            
            $('#itemTbody').empty();
            
            $.each(data.itemsearch, function(index, item){
			 let row = '<tr>' +
		        '<td>' + (item['index'] || '') + '</td>' +
		        '<td>' + item['ITEMID'] + '</td>' +
		        '<td>' + item['ITEMNAME'] + '</td>' +
		        '<td>' + item['TYPE'] + '</td>' +
		        '<td>' + (item['STOREDATE'] == null ? '-' : item['STOREDATE']) + '</td>' +
		        '<td class="stock-data" data-stock="' + (item['STOCK'] == null ? '-' : item['STOCK']) + 
		        		' EA">' + (item['STOCK'] == null ? '-' : item['STOCK']) + ' EA</td>' +       
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
					
			 addEmptyRowsToTable('#itemTbody');
			
             stockTotals();
             
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
	const originalRows = $('.statusSortable').closest('table').find('tbody:first > tr').toArray();
    $('.statusSortable').click(function () {
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
		
		table.find('.statusSortable').not(this).removeClass('asc desc reset');

        table.find('tbody:first').empty().append(rows);
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
    const originalRows = $('.itemSortable').closest('table').find('tbody:first > tr').toArray();

    $('.itemSortable').click(function () {
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
        } else {
            $(this).addClass('asc');
            rows = table.find('tbody:first > tr').toArray().sort(comparator(index));
        }

        if ($(this).hasClass('reset')) {
          //  searchData();
            $(this).removeClass('reset');
            rows = originalRows;
        }

        table.find('.itemSortable').not(this).removeClass('asc desc reset');
        table.find('tbody:first').empty().append(rows);
    });

    function comparator(index) {
        return function (a, b) {
            const valA = getCellValue(a, index);
            const valB = getCellValue(b, index);

            if (index === 1 || index === 2 || index === 4) {
                return valA.localeCompare(valB);
            } else if (index === 3) {
                const dateA = new Date(valA);
                const dateB = new Date(valB);

                if (dateA.getFullYear() !== dateB.getFullYear()) {
                    return dateA.getFullYear() - dateB.getFullYear();
                } else if (dateA.getMonth() !== dateB.getMonth()) {
                    return dateA.getMonth() - dateB.getMonth();
                } else {
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
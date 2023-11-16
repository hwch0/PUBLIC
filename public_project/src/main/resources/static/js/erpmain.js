//날자 관련 코드
$(document).ready(() => {

	$.fn.datepicker.dates['kr'] = {
		days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
		daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
		daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
		months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	};

	const startDate = $('#startDate');
    const endDate = $('#endDate');
    const startDate2 = $('#startDate2')
    const endDate2 = $('#endDate2')
	        
    const datepickerReset = () => {
        $('.input-group.date').datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy/mm/dd",
            language: "kr"
        });
    };

    datepickerReset();
    
	     $('#startDate, #endDate').on('change', function(){
		const selectedDate1 = new Date(startDate.val());
		const selectedDate2 = new Date(endDate.val());

	        const diffInMilliseconds = Math.abs(selectedDate2 - selectedDate1);
	        const diffInDays = Math.ceil(diffInMilliseconds / (1000 * 60 * 60 * 24));
	
	        if (diffInDays > 90) {
                alert("최대 3개월을 넘어서 검색을 할 수 없습니다.");

                startDate.val('');
                endDate.val('');
                startDate2.val('');
                endDate2.val('');
                                
                 $('.input-group.date').datepicker('destroy');
                 
                 datepickerReset();
            }
        });
    });
    
//재고관리 품목 & 입·출고 
function changeItemPage() {
		$('#item').css("display", "block");
		$('#inventoryStatus').css("display", "none");
		resetInputs();
}      

function changeInventoryStatusPage() {
		$('#item').css("display", "none");
		$('#inventoryStatus').css("display", "block");
		resetInputs();
}             

//매출내역 주문내역
function changeSalesPage() {
		$('#sales').css("display", "block");
		$('#order').css("display", "none");
		$('.detail').css("display", "none");
		resetInputs();
}      

function changeOrderPage() {
		$('#sales').css("display", "none");
		$('#order').css("display", "block");
		resetInputs();
}     

//버튼 클릭 시 초기화
function resetInputs(){
	//등록일 입력 초기화
	$('#startDate').val('');
	$('#endDate').val('');
	$('#startDate2').val('');
	$('#endDate2').val('');
	
	//품목명 입력 초기화
	$('.itemName').val('');
	
	//품목 유형 선택 초기화
	$('itemSelect').val('1');
	
	//라디오 초기화
	$('input[name="stockStatus"][value="1"]').prop('checked', true);
	$('input[name="inventorystockOption"][value="1"]').prop('checked', true);
}

//로딩화면
/*
function loading(){
	LoadingWithMask('/images/loading.gif');
	setTimeout(closeLoadingWithMask, 2000);
}
*/
function LoadingWithMask(gif){
	const maskHeight = $(document).height();
	const maskWidth = window.document.body.clientWidth;
	
	const mask = "<div id='mask' style='position:absolute; z-index:9000; background-color:#000000; display:none; left:0; top:0;'></div>";
    
	const loadingImg = "<img src='" + gif + "' class='loading-image' id='loadingImg'/>";
	
	$('body').append(mask)
	
	$('#mask').css({
		'width': maskWidth,
		'height': maskHeight,
		'opacity':'0.3'
	});
	
	$('#mask').show();
	
	$('#mask').append(loadingImg);
	$('#loadingImg').show();
}

function closeLoadingWithMask(){
	$('#mask, #loadingImg').hide();
	$('#mask, #loadingImg').empty();
}

//화살표 위치
function navOn(element) {
    const navLi = $(element).parent();
    $(".main_nav li.on").removeClass("on");
    $(navLi).addClass("on");
}
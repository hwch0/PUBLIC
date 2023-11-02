//비동기 전환 화면
function loadPage(pageUrl) {

    $.ajax({
        url: pageUrl,
        type: 'GET',
        success: function (data) {
            // jQuery를 사용하여 특정 클래스를 가진 부분만 선택
            const dynamicContent = $(data).filter('.content').find('.cont_top, .cont_area');

            //console.log('Dynamic Content:', dynamicContent.html());

            // #dynamicContent에 선택된 부분을 삽입           
            $('#dynamicContent').html(dynamicContent);
                       
      		makeCalendar();
            
        },
        error: function (error) {
            console.error('Error loading page:', error);
        }
    });
}

/*var erpId = function(){
        $('.input-group.date').datepicker({
            calendarWeeks: false,
            todayHighlight: true,
            autoclose: true,
            format: "yyyy/mm/dd",
            language: "kr"
        });
    };*/

//날자 관련 
makeCalendar = () => {
	$('.input-group.date').datepicker({
        calendarWeeks: false,
        todayHighlight: true,
        autoclose: true,
        format: "yyyy/mm/dd",
        language: "kr"
    })
}
$(document).ready(() => {

	$.fn.datepicker.dates['kr'] = {
		days: ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"],
		daysShort: ["일", "월", "화", "수", "목", "금", "토", "일"],
		daysMin: ["일", "월", "화", "수", "목", "금", "토", "일"],
		months: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"],
		monthsShort: ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
	};

	makeCalendar();

});

      
       


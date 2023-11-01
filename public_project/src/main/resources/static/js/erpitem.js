//비동기 전환 화면
function loadPage(pageUrl) {
	 
	 $('#dynamicContent').html('');
	 
    $.ajax({
        url: pageUrl,
        type: 'GET',
        success: function (data) {
            // jQuery를 사용하여 특정 클래스를 가진 부분만 선택
            const dynamicContent = $(data).filter('.content').find('.cont_top, .cont_area');

            console.log('Dynamic Content:', dynamicContent.html());

            // #dynamicContent에 선택된 부분을 삽입           
            $('#dynamicContent').html(dynamicContent);
            
        },
        error: function (error) {
            console.error('Error loading page:', error);
        }
    });
}

/*function loadPage(pageUrl) {
    $.ajax({
        url: pageUrl,
        type: 'GET',
        success: function (data) {
          //특정 부분의 시작과 끝 태그 기준으로 추출
          const startTag = '<div class="content" id="dynamicContent">';
          const endTag = '</div>';
          
          const startIndex = data.indexOf(startTag);
          const endIndex = data.indexOf(endTag, startIndex + startTag.length);
          
          if(startIndex !== -1 && endIndex !== -1){
			  const dynamicContent = data.substring(startIndex, endIndex + endTag.length);

			   console.log('Dynamic Content:', dynamicContent); 			  

			  $('#dynamicContent').html(dynamicContent);			  
		  }else{
			  console.error('로드된 페이지에서 #dynamicContent인 요소를 찾을 수 없습니다.');
		  }
        },
        error: function (error) {
            console.error('Error loading page:', error);
        }
    });
}*/
/*$(document).ready(function(){
	//초기 재고품목 페이지 료시
	loadPage('erp.jsp');
	
	//네비게이션 메뉴 클릭 이벤트 처리
	$('.main.nav a').click(function (event){
		event.preventDefault(); //기본 이벤트 방지
		
		const pageUrl = $(this).attr('href');
		loadPage(pageUrl);
	});
});

//페이지 로드 함수
function loadPage(pageUrl){
	$.ajax({
		url: pageUrl,
		type:'GET',
		success: function (data){
			$('.content').html(data); //가져온 HTML .content에 삽입
		},
		error: function(error){
			console.error('Error loading page: ' , error);
		}
	});
}
*/
//목록 정렬 
$(document).ready(function () {
    $('.sortable').click(function () {
        var table = $(this).closest('table');
        var index = $(this).index();
        var rows = table.find('tbody > tr').toArray().sort(comparator(index));

        if ($(this).hasClass('asc')) {
            rows = rows.reverse();
            $(this).removeClass('asc');
            $(this).addClass('desc');
        } else {
            $(this).removeClass('desc');
            $(this).addClass('asc');
        }

        table.find('tbody').empty().append(rows);
    });

    function comparator(index) {
        return function (a, b) {
            var valA = getCellValue(a, index);
            var valB = getCellValue(b, index);

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
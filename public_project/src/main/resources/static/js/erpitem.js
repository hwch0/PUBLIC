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
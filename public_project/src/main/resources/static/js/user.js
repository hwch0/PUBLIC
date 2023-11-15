function fetchMenuList() {
    $.ajax({
        url: "/user/getMenuList",
        type: "GET",
        success: function (menuList) {
            displayMenuList(menuList);
        },
        error: function (error) {
            console.error("Error fetching menu list: " + error);
        }
    });
}

function displayMenuList(menuList) {
    var menuContainer = $(".cont-food .food ul");

    menuContainer.empty();

    for (var i = 0; i < menuList.length; i++) {
        var menu = menuList[i];

        var menuItem = '<li>' +
            '<a href="javascript:void(0);">장바구니에 담기</a>' +
            '<div class="img-wrap">' +
            '<img alt="상품이미지" src="/image/download/' + menu.imgId + '">' +
            '</div>' +
            '<div class="food-info-wrap">' +
            '<p class="food-name">' + menu.itemName + '</p>' +
            '<p class="food-price">' + menu.sellingPrice + '</p>' +
            '</div>' +
            '</li>';

        menuContainer.append(menuItem);
    }
}

$(document).ready(function () {
    fetchMenuList();
});
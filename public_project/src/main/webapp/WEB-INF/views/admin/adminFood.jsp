<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>

.card-img-top {
	height: 60%;
}
.card.h-100 {
	height: 85%!important;
}
.col.mb-5 {
	margin-bottom: -2rem!important;
}

.justify-content-center {
	justify-content:left!important; 
 }

.container.px-4.px-lg-5.mt-5 {
	overflow-y:scroll; 
	height:600px;	
}

.container.px-4.px-lg-5.mt-5::-webkit-scrollbar {
  display: none;
}

.addMenuBnt {
	height: 100%;
	width: 100%;
	border-radius:calc(.25rem - 0);
}

.menuSelectList {
   	height: 30%;
    width: 100%;
    margin: 20px 0 20px 0;

}
.menuSelectList td, th{
    font-size: 10px; /* 폰트 크기를 10px로 설정 */

}

.menuSelectList {
    font-size: 10px!important; /* 폰트 크기를 10px로 설정 */

}
/* .menuSelectList::-webkit-scrollbar { */
/*   display: none; */
/* } */
.menuSelectListBody::-webkit-scrollbar {
  display: none;
}

.menuSelectListBody {
  display: block;
  overflow: auto;
  overflow-y:scroll; 
}

/* thead는 고정된 상태로 유지합니다. */
.menuSelectListBody thead {
  position: sticky;
  top: 0;
  background-color: #fff; /* 배경색 설정 */
}



</style>

 <div class="admin_food">
 
           
  <!-- 모달 창 영역 -->
	<div id="menuModal" class="modal">
	    <div class="modal-content">
	    	<span class="close" id="closeModalBtn">&times;</span>
	    	
	    	
	    	<form name="menuForm" id="menuForm" method="multipart/form-data" style="width:100%; height:100%;">
	    		<input name="selectedItem" id="selectedItem" style="display:none;">
				<select class="form-select" aria-label="Default select example" style="width:100%">
				  <option selected value="N">메뉴 카테고리 선택</option>
				  
				 <c:forEach var="category" items="${menuCategory}">
				  <option name="menuCategory" class="menuCategory" value="${category.CODE }">${category.TYPE }</option>
				  </c:forEach>
				</select>   
				
			  <div class="menuSelectList">
				  	<table class="menuSelectListBody" style="width:100%; height:100%; table-layout: fixed;">
				  	
	  					<thead>
	  						<tr>
				  			<th style="width: 20%;">카테고리</th>
				  			<th style="width: 10%;">코드</th>
				  			<th style="width: 30%;">메뉴</th>
				  			<th style="width: 20%;">가격</th>
				  			<th style="width: 20%;">선택</th>
	  						</tr>
  						</thead>
  						
						<tbody class="menu" id="tbody">
					  		<tr id="menu-item" style="display: none;">
					  			<td class="category">음료</td>
					  			<td class="menuId">아이디</td>
					  			<td class="menuName">코카콜라</td>
					  			<td class="menuPrice">2000</td>
					  			<td class="menuChecked" name="menuChecked"><input type="checkbox" id="checkedBox" name="checkedBox"></td>
					  		</tr> 
 						</tbody>
				  	</table>
				  </div> 
					
		    	<div class="input-group mb-3">
				  <input type="file" name="menuImage" class="form-control" id="inputGroupFile02" />
				  <label class="input-group-text" for="inputGroupFile02">Upload</label>
				  <div style="width:100%; height: 115px;">
				 	 <img id="preview" src="" alt="Image Preview" style="width:auto; height: 100%; margin: 0 auto 0 auto; display: none;">
				  </div>
				</div>
			    <button class="btn btn-outline-dark mt-auto" id="addMenuBnt" type="button">메뉴등록</button>
	    	
	    	</form>
	    
	    </div>
   </div>
  
  <!-- Section-->
    <section class="py-5">
      <div class="container px-4 px-lg-5 mt-5">
        <div
          class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-4 justify-content-center menuList"
        >
        
          <!-- 메뉴 추가  -->        
          <div class="col mb-5">
	          <div class="card h-100 openMenuController" style="background-color:transparent; cursor: pointer; " 
	          onmouseover="this.style.backgroundColor='rgba(84, 84, 84, 0.3)';" onmouseout="this.style.backgroundColor='transparent';">
	          	<img src="images/plusBnt.png" style="width:20%; margin:auto;"/>
	          </div>
          </div>
          
          <c:forEach var="menu" items="${menuList}">
             <div class="col mb-5">
	          <div class="card h-100" >
	          	<img 
	          		class="card-img-top" 
	          		src="/image/download/${menu.IMG_ID}"
	          		/>
	          	<div class="card-body p-4">
	          		<div class="text-center">
	          			<h5 class="fw-bolder menuName">${menu.ITEM_NAME }</h5>
	          			<h6 class="fw-bolder menuPrice">${menu.SELLING_PRICE }</h6>
	          		</div>
	          	</div>
    	        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                <div class="text-center">
                  <a class="btn btn-outline-dark mt-auto"  href="javascript:void(0);" onclick="deleteMenu(this);" menuId="${menu.ITEM_ID}" id="deleteMenuBnt"
                    >삭제</a
                  >
                </div>
              </div>
	          	
	          </div>
          </div>
          
          
            <div class="col mb-5" id="cardItem" style="display:none;">
	          <div class="card h-100" >
	          	<img 
	          		class="card-img-top" 
	          		src=""
	          		/>
	          	<div class="card-body p-4">
	          		<div class="text-center">
	          			<h5 class="fw-bolder menuName"></h5>
	          			<h6 class="fw-bolder menuPrice"></h6>
	          		</div>
	          	</div>
    	        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                <div class="text-center">
                  <a class="btn btn-outline-dark mt-auto" href="javascript:void(0);" onclick="deleteMenu(this);" menuId="" id="deleteMenuBnt"
                    >삭제</a
                  >
                </div>
              </div>
	          	
	          </div>
          </div>
          	
          </c:forEach>
          
          
          
        </div>
      </div>
    </section>

    <!-- Bootstrap core JS-->
<!--     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script> -->
  </div>
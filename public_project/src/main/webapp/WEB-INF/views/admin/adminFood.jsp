<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<style>
.p-4 {
	padding: 0.5rem!important;
}
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
   	height: 50%;
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

.selectedMenu ul {
    list-style-type: none;
    padding: 0;
    display: flex;
}

.selectedMenu li {
    margin-right: 10px; /* Adjust as needed to add spacing between li elements */
    display: flex;
    font-size: 10px;
}
.selectedMenu input {
	width: 60%;
}



.menu-category {
   position: absolute;
   width: 60%;
   height: 40px;
   top: 130px;
   margin-right: 20%;
   margin-left: 20%;
   border-radius: 20px;
   background-color: #fff;
}

.menu-category ul {
   margin: 0 auto;
   width: 100%;
   height: 100%;
}

.menu-category li {
   float: left;
   width: 20%;
   height: 100%;
   text-align: center;
}

.menu-category li a {
   display: block;
   line-height: 40px;
   font-size: 18px;
   color: #666;
}
.menu-category li.on a {
   color:  #440977;
   font-weight: bold;
}

.menu-category.lft {
	 margin-left: 9%;
}
.menu.modal-content {
	top: 40%!important;
	left: 44%!important;
	width: 700px!important;
	height: 600px!important;
}

#root {
  width: 100%;
  /* margin: 0 auto; */
  height: 100%
  max-width: 800px;
}

.title {
  text-align: center;
}

.contents {
  display: flex;
  flex-direction: row;
  margin-top: 0px;
}
.contents .upload-box {
  width: 100%;
  margin-right: 30px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
}

.contents .upload-box .drag-file {
  position: relative;
  width: 100%;
  height: 360px;
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 3px dashed #dbdbdb;
}
.contents .upload-box .drag-file.highlight {
  border: 3px dashed red;
}
.contents .upload-box .drag-file .image {
  width: 40px;
}
.contents .upload-box .drag-file .message {
  margin-bottom: 0;
}
.contents .upload-box .drag-file .preview {
  display: none;
  position: absolute;
  left: 0;
  height: 0;
  width: 100%;
  height: 100%;
}
.contents .upload-box .file-label {
  margin-top: 0px;
  background-color: #5b975b;
  color: #fff;
  text-align: center;
  padding: 10px 0;
  width: 40%;
  border-radius: 6px;
  cursor: pointer;
}
.contents .upload-box .file {
  display: none;
}

@media (max-width: 700px) {
  .contents {
    display: flex;
    flex-direction: column;
    margin-top: 30px;
  }
  .contents .upload-box {
    width: 100%;
    box-sizing: border-box;
    margin-right: 0;
  }
  .contents .upload-box .drag-file {
    height: 150px;
  }
  .contents .files {
    width: 100%;
    box-sizing: border-box;
    margin-right: 0;
    overflow: initial;
  }
}

.menuForm {
	width:100%; 
	height:100%;
   display: flex;
   justify-content: space-between;

}


.selectedMenu.list ul {
    list-style-type: none;
    padding: 0;
}

.selectedMenu.list li {
    margin-bottom: 10px; /* Adjust as needed to add spacing between li elements */
    padding: 10px;
    border-radius: 8px;
    background-color: #f0f0f0;
}

.selectedMenu.list input {
    border: none;
    background-color: transparent;
    margin-right: 10px; /* Adjust as needed to add spacing between input elements */
}

.selectedMenu.list button {
    border: none;
    border-radius: 5px;
    background-color: #a080c0;
    color: #fff;
    cursor: pointer;
    transition: background-color 0.3s;
}

.selectedMenu.list button:hover {
    background-color: #804080;
}

</style>
<!--     <link rel="stylesheet" href="path/to/tagify.css"> -->
<!--     <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tagify/4.17.9/tagify.min.js"></script> -->
<!--     <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/tagify/4.17.9/jQuery.tagify.min.js"></script> -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@yaireo/tagify@4.3.0/dist/tagify.css">
    <script src="https://cdn.jsdelivr.net/npm/@yaireo/tagify@4.3.0/dist/tagify.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    
 <div class="admin_food">

  <!-- 모달 창 영역 -->
	<div id="menuModal" class="modal">
	    <div class="menu modal-content">
	    	<span class="close" id="closeModalBtn">&times;</span>
	        <h2>메뉴 등록</h2>
	    	<form class="menuForm" name="menuForm" id="menuForm" method="multipart/form-data">
	    		<input name="selectedItem" id="selectedItem" style="display:none;">

		    	<div class="input-group mb-3" style="width:70%">
<!-- 				  <input type="file" name="menuImage" class="form-control" id="inputGroupFile02" /> -->
<!-- 				  <label class="input-group-text" for="inputGroupFile02">Upload</label> -->
<!-- 				  <div style="width:100%; height: 115px;"> -->
<!-- 				 	 <img id="preview" src="" alt="Image Preview" style="width:auto; height: 100%; margin: 0 auto 0 auto; display: none;"> -->
<!-- 				  </div> -->
				  
				  <div id="root">
				  <div class="contents">
				    <div class="upload-box">
				      <div id="drop-file" class="drag-file">
				        <img src="https://img.icons8.com/pastel-glyph/2x/image-file.png" alt="파일 아이콘" class="image" >
				        <p class="message">드래그하여 메뉴 이미지 추가</p>
				        <img src="" alt="미리보기 이미지" class="preview">
				      </div>
				      
				      <div style="margin-top:30px; width:100%">
				      <label class="file-label" for="chooseFile">Choose File</label>
				      <input class="file" id="chooseFile" type="file" onchange="dropFile.handleFiles(this.files)" accept="image/png, image/jpeg, image/gif">
				      <label type="button" class="file-label">Delete</label>
				      </div>

				    </div>
				  </div>
				</div>
				</div>
		    	<div class="input-group mb-3" style="display: inline;">
	    		
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
					  		<tr id="menu-item" style="display: none;background-color:'';">
					  			<td class="category">음료</td>
					  			<td class="menuId">아이디</td>
					  			<td class="menuName">코카콜라</td>
					  			<td class="menuPrice">2000</td>
					  			<td class="menuChecked" name="menuChecked"><input type="checkbox" id="checkedBox" name="checkedBox"></td>
					  		</tr> 
 						</tbody>
				  	</table>
				  </div> 
				  
				  <div class="selectedMenu">
				      <ul class="selectedItem">
				         <li>상품코드 <input type="text" class="selectedItem selectedCode" disabled></li>
				         <li>상품이름 <input type="text" class="selectedItem selectedName" disabled></li>
				         <li>판매가격 <input type="text" class="selectedItem selectedPrice" ></li>
				         <li><input type="file" name="menuImage" class="form-control" id="inputGroupFile02" style="display:none;"/></li>
				         <li><button class="addMenuIntoList" type="button">추가</button></li>
				      </ul>
				   </div>
				   
   				  <div class="selectedMenu list">
				      <ul>
<!-- 				         <li class=""><input value="상품이름"><input value="상품가격"><button type="button">삭제</button></li>
				         <li><input value="상품이름"><input value="상품가격"><button type="button">삭제</button></li>
				         <li><input value="상품이름"><input value="상품가격"><button type="button">삭제</button></li> -->
				      </ul>
				   </div>
				  
					<button class="btn btn-outline-dark mt-auto" id="addMenuBnt" type="button">메뉴등록</button>
				</div>

	    	</form>
	    
	    </div>
   </div>
  
  <!-- Section-->
    <section class="py-5">
    
     
    <div class="menu-category">
      <ul>
         <li id="menu01" class="on"><a href="javascript:void(0);" onclick="showCategory(1);">All</a></li>
         <li id="menu02"><a href="javascript:void(0);" onclick="showCategory(2);">밥</a></li>
         <li id="menu03"><a href="javascript:void(0);"  onclick="showCategory(3);">라면</a></li>
         <li id="menu04"><a href="javascript:void(0);"  onclick="showCategory(4);">음료</a></li>
         <li id="menu05"><a href="javascript:void(0);"  onclick="showCategory(5);">스낵</a></li>
      </ul>
   </div>
    
    
      <div class="container px-4 px-lg-5 mt-5">
        <div
          class="row gx-4 gx-lg-5 row-cols-2 row-cols-md-3 row-cols-xl-5 justify-content-center menuList"
        >
        
          <!-- 메뉴 추가  -->        
          <div class="col mb-5">
	          <div class="card h-100 openMenuController" style="background-color:transparent; cursor: pointer; " 
	          onmouseover="this.style.backgroundColor='rgba(84, 84, 84, 0.3)';" onmouseout="this.style.backgroundColor='transparent';">
	          	<img src="images/plusBnt.png" style="width:20%; margin:auto;"/>
	          </div>
          </div>
            <div class="col mb-5" id="cardItem" style="display:none;" menuCategory="">
	          <div class="card h-100" >
	          	<img 
	          		class="card-img-top" 
	          		src=""
	          		/>
	          	<div class="card-body p-4">
	          		<div class="text-center">
	          			<h6 class="fw-bolder menuName"></h6>
	          			<h6 class="fw-bolder menuPrice"></h6>
	          		</div>
	          	</div>
    	        <div class="card-footer p-4 pt-0 border-top-0 bg-transparent">
                <div class="text-center">
                  <a class="btn btn-outline-dark mt-auto" href="javascript:void(0);" onclick="deleteMenu(this);" menuId="" imgId="" id="deleteMenuBnt"
                    >삭제</a
                  >
                </div>
              </div>
	          	
	          </div>
          </div>
          
        </div>
      </div>
    </section>

    <!-- Bootstrap core JS-->
<!--     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script> -->
  </div>
  
  <script>
  $(document).ready(function() {
      var $listLI = $("h6");
      $listLI.each(function(){
          $(this).text(parseInt($(this).attr('value')).toLocaleString() + '원');
      })
  });
  
  function DropFile(dropAreaId, fileListId) {
	  let dropArea = document.getElementById(dropAreaId);
	  let fileList = document.getElementById(fileListId);

	  function preventDefaults(e) {
	    e.preventDefault();
	    e.stopPropagation();
	  }

	  function highlight(e) {
	    preventDefaults(e);
	    dropArea.classList.add("highlight");
	  }

	  function unhighlight(e) {
	    preventDefaults(e);
	    dropArea.classList.remove("highlight");
	  }

	  function handleDrop(e) {
	    unhighlight(e);
	    let dt = e.dataTransfer;
	    let files = dt.files;
	    
	    // Update the second file input with the selected file
	    $('#inputGroupFile02')[0].files = files;

	    // Additional logic or handling if needed
	    console.log('Selected file:', files);
	    
	    handleFiles(files);

	    const fileList = document.getElementById(fileListId);
	    if (fileList) {
	      fileList.scrollTo({ top: fileList.scrollHeight });
	    }
	  }

	  function handleFiles(files) {
	    files = [...files];
	    // files.forEach(uploadFile);
	    files.forEach(previewFile);
	  }

	  function previewFile(file) {
	    console.log(file);
	    renderFile(file);
	  }

	  function renderFile(file) {
	    let reader = new FileReader();
	    reader.readAsDataURL(file);
	    reader.onloadend = function () {
	      let img = dropArea.getElementsByClassName("preview")[0];
	      img.src = reader.result;
	      img.style.display = "block";
	    };
	  }

	  dropArea.addEventListener("dragenter", highlight, false);
	  dropArea.addEventListener("dragover", highlight, false);
	  dropArea.addEventListener("dragleave", unhighlight, false);
	  dropArea.addEventListener("drop", handleDrop, false);

	  return {
	    handleFiles
	  };
	}

	const dropFile = new DropFile("drop-file", "files");
	
    $(document).ready(function() {
        $('.addMenuIntoList').on('click', function() {
            // "selectedName"과 "selectedPrice"에서 값을 가져오기
            var nameValue = $('.selectedName').val();
            var priceValue = $('.selectedPrice').val();

            // 새로운 li 요소 생성 및 Tagify 초기화
            var newLi = $('<li><input class="tag-input" value="' + nameValue + ' ' + priceValue + '원"></li>');

            // "selectedMenu list"의 ul에 새로운 li 요소 추가
            $('.selectedMenu.list ul').append(newLi);

            // Tagify 초기화
            var input = newLi.find('.tag-input')[0];
            new Tagify(input);

            // 선택적으로 입력값을 지우거나 새로운 요소를 추가한 후에 다른 작업 수행 가능
            $('.selectedName').val('');
            $('.selectedPrice').val('');
        });
    });
	

  </script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/template/HeadNav.jsp"/>
<style>
    #fileInput {
        display: none; /* 원래 파일 업로드 버튼 감추기 */
    }
    #customFileBtn {
        padding: 10px 15px;
        background-color: #3498db;
        color: #fff;
        cursor: pointer;
    }
</style>

<div class="jumbotron">
	<form action="<c:url value="/Board/Edit.kjh"/>" method="post" enctype="multipart/form-data">
	  <fieldset>
	<c:if test="${list.attachFile ne 'X'}">
	<div class="text-danger" style="text-align:right;">※파일을 수정하게 되면 기존 파일들은 삭제됩니다. 주의하세요</div>
	<div style="text-align:right; font-size:20px;"><b>등록된 파일리스트</b></div>
		<div class="file-list_orgin" style="text-align:right;">
			<c:forEach var="file" items="${fn:split(list.attachFile,',') }">
				<div>
					${file}
					<span>[ 삭제 ]</span>
				</div>
			</c:forEach>
		</div>
	</c:if>

<div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
    <span style="text-align: left; font-size:30px">게시판 수정</span>
    <div style="display: flex; gap: 10px;">
        <input type="file" id="fileInput" name="file" multiple>
        <button type="button" id="customFileBtn">파일 추가</button>
    </div>
</div>
<div style="text-align:right; font-size:20px;"><b>수정된 파일리스트</b></div>
<ul style="text-align:right;" class="file-list_update" id="fileList"></ul>
    <hr>
	    <div class="form-group">
	      <input type="text" class="form-control" id="title" name="title" value="${list.title }" placeholder="제목을 입력해 주세요">
	    </div>
	    <div class="form-group">
	      <textarea class="form-control" id="content" name="content" rows="20" placeholder="내용을 입력하세요">${list.content }</textarea>
	    </div>
	    <div style="display: flex; justify-content: flex-end;">
   	  <input type="hidden" id="orginFileList" name="orginFileList" value="${list.attachFile},"/>
   	  <input type="hidden" id="updateFileList" name="updateFileList" value=""/>
   	  <input type="hidden" id="deleteFileList" name="deleteFileList" value=""/>
	  <input type="hidden" name="no" value=${param.no} />
	    <button type="submit" class="btn btn-primary">수정</button>
	    </div>
	  </fieldset>
	</form>
</div>


   <script>
   
       document.getElementById('customFileBtn').addEventListener('click', function() {
           document.getElementById('fileInput').click();
       });

       document.getElementById('fileInput').addEventListener('change', function(event) {
       	while (fileList.firstChild) {
               fileList.removeChild(fileList.firstChild);
           }
       	
       	const files = event.target.files;
		for(var i=0; i<files.length; i++){
			var li = document.createElement("li");
			li.textContent = files[i].name;
			var a = document.createElement("a");
            a.textContent = '[ 삭제 ]';
            a.id = "deleteFile"+i ;
            a.addEventListener('click', function(e){
            	var deleteFileList = document.querySelector('#deleteFileList');
            	deleteFileList.value += e.target.parentNode.firstChild.textContent+",";
            	e.target.parentNode.remove();
            });
            li.appendChild(a);
            document.getElementById("fileList").appendChild(li);
		}
       });
       
       document.querySelector('.file-list_orgin').addEventListener('click', function(e) {
       		console.log(e.target.parentNode.firstChild.textContent.trim());
        	var updateFileList = document.querySelector('#updateFileList');
        	updateFileList.value += e.target.parentNode.firstChild.textContent.trim()+",";
        	e.target.parentNode.remove();
       });
   </script>

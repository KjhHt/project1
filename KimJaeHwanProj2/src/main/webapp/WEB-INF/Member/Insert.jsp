<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

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
	<form action="<c:url value="/Board/Insert.kjh"/>" method="post" enctype="multipart/form-data">
	  <fieldset>
<div style="display: flex; justify-content: space-between; align-items: center; width: 100%;">
    <span style="text-align: left; font-size:30px">게시판 글쓰기</span>
    <div style="display: flex; gap: 10px;">
        <input type="file" id="fileInput" name="file" multiple>
        <button type="button" id="customFileBtn">파일 추가</button>
    </div>
</div>
<ul style="text-align:right;" class="list-unstyled" id="fileList"></ul>
    <hr>
	    <div class="form-group">
	      <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력해 주세요">
	    </div>
	    <div class="form-group">
	      <textarea class="form-control" id="content" name="content" rows="20" placeholder="내용을 입력하세요"></textarea>
	    </div>
	    <div style="display: flex; justify-content: flex-end;">
	    <button type="submit" class="btn btn-primary">등록</button>
	    </div>
	  </fieldset>
	  <input type="hidden" id="deleteFileList" name="deleteFileList" value=""/>
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
	            	console.log( e.target.parentNode.firstChild.textContent );
	            	var deleteFileList = document.querySelector('#deleteFileList');
	            	console.log(deleteFileList);
	            	deleteFileList.value += e.target.parentNode.firstChild.textContent+",";
	            	console.log(deleteFileList.value);        	
	            	e.target.parentNode.remove();
	            });
	            li.appendChild(a);
	            document.getElementById("fileList").appendChild(li);
			}
        });
        
        
        
    </script>




<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/template/HeadNav.jsp"/>
<style>
	.file-list {
		display: none;
	}
        
	.CommentWriter {
	    text-size-adjust: none;
	    font-weight: 400;
	    font-family: "Apple SD Gothic Neo", "맑은 고딕", "Malgun Gothic", 돋움, dotum, sans-serif;
	    color: var(--skinTextColor);
	    font-size: 12px;
	    margin: 12px 0 29px;
	    padding: 16px 10px 10px 18px;
	    border: 2px solid #b7b7b7;
	    border-radius: 6px;
	    box-sizing: border-box;
	    background: var(--skinCommentWriterBg);
	}
	
  .profile-container {
    display: flex;
    align-items: center;
  }

  .user-info {
    margin-left: 10px;
    color: black;
    font-size: 15px;
  }

  .comment-info {
    display: flex;
    align-items: center;
    margin-top: 5px;
    color: black;
    font-size: 12px;
    margin-left: auto;
  }

</style>
	<c:url value="/images/heart.svg" var="imageUrlHeart" />
	<c:url value="/images/heart-fill.svg" var="imageUrlHeartFill" />
<div class="jumbotron" style="background-color: white;">
<div class="container mt-3">
	<h1 style="color:green;">'한국 ICT 1기'</h1>

	<h2>${record.title }</h2>
		<div class="profile-container">
		  <c:url value="/images/${record.profile }.png" var="imageUrl" />
		  <img class="img-profile rounded-circle" style="width:40px;" id="img" src="${imageUrl}">
		  <div class="user-info">
		    <span>${record.name}</span>
		    <br/>
		    <span>${record.postdate} 조회${record.visitcount}</span>
		  </div>
		  <div class="comment-info">
		<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
		  <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
		  <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2"/>
		</svg>
		    <span style="font-size:15px">&nbsp;댓글${commentCount}</span>
		  </div>
		</div>
	<hr/>
	<div class="form-group">
		<div>
			<c:if test="${record.attachFile ne 'X'}">
				<figure class="text-end">
					<blockquote class="blockquote" style="text-align: right;">
						<a href="javascript:void(0)" role="button" class="button_file"
							onclick="toggleFileList()">첨부파일 모아보기(${fileCount})</a><br>
						<div class="file-list" style="display: none;">
							<c:forEach var="file" items="${fn:split(record.attachFile,',') }">
								${file}<a href="<c:url value="/Board/Download.kjh?filename=${file}&no=${record.no}"/>" />다운로드</a>
								<br />
							</c:forEach>
						</div>
					</blockquote>
				</figure>
			</c:if>
			${record.content }
		</div>
	</div>
		<div id="likeAndCommentCount">
			<c:if test="${isLike==0}">
				<img id="heart" src="${imageUrlHeart}" alt="좋아요" />
			</c:if>
			<c:if test="${isLike==1}">
				<img id="heart" src="${imageUrlHeartFill}" alt="좋아요" />
			</c:if>
			<span>좋아요</span> <span id="likeNum">${likeRecord}</span>
			
<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
  <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
  <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2"/>
</svg>
			
			<span>댓글
				${commentCount}</span>
		</div>
		<hr />
				<div class="comment_inbox" id="buttonNode">
					<strong class="d-block mb-2" style="font-size: 17px">댓글</strong>
					<c:if test="${commentCount ne 0}">
						<c:forEach var="c" items="${resultList}">
							<c:set var="formattedDate" value="${commentDTO.commentdate.time}" />
							<fmt:formatDate value="${c.commentdate}"
								pattern="yy/MM/dd HH:mm:ss" var="formattedCommentdate" />
							<hr>
							<c:if test="${c.replaywhether eq 'Y'}">
								<div style="padding-left: 50px;" id='isComment'
									data-subcomment='${c.subcomment}'>
							</c:if>
							<c:if test="${c.replaywhether eq 'F'}">
								<div>
							</c:if>
							<div>${c.name}</div>
							<div>
								<c:if test="${c.subname ne 'X'}">
									<span style="color: blue;"><b>${c.subname}</b></span>
								</c:if>
								${c.commentcontent}
							</div>
							<span style="color: #979797;"> ${formattedCommentdate} <a
								href="#" id="replaySub" data-cno="${c.cno}"
								style="color: #979797; font-size: .875rem">&nbsp;&nbsp;답글쓰기</a>
							</span>
				</div>
				<hr>
				</c:forEach>
				</c:if>
				<div class="CommentWriter">
				<br /> 
				${name }
				<form id="commentForm"
					action="<c:url value="/Board/CommentInsert.kjh"/>" method="post">
					<textarea placeholder="댓글을 남겨보세요" rows="1" name="commentcontent"
						class="form-control"></textarea>
					<input type="hidden" name="no" value="${param.no }" />
					<div class="comment_attach mt-2 d-flex align-items-center">
						<div class="register_box ml-auto">
							<a href="#" role="button" class="btn btn-primary"
								onclick="submitCommentForm()">등록</a>
						</div>
					</div>
				</form>
				</div>
	<div>
	<a class="btn btn-primary btn-lg"
		href="<c:url value="/Board/Insert.kjh"/>" role="button">글쓰기</a> <a
		class="btn btn-primary btn-lg"
		href="<c:url value="/Board/Edit.kjh?no=${param.no}"/>" role="button">수정</a>
	<a class="btn btn-danger btn-lg" id="deleteButton" role="button">삭제</a>
	<a class="btn btn-primary btn-lg" style="float: right;"
		href="<c:url value="/Board/List.kjh"/>" role="button">목록</a>
			</div>
			</div>
		</div>



</div>
<script>

var isLike = ${isLike};
$('#heart').on('click',function(){
    if(isLike==0){//눌렀을떄
    	fetch("<c:url value="/Board/Like.kjh"/>",{
    		method:"POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ no: "${param.no}",data:"UP" })
    	})
    	.then(response => response.json())
        .then(data => {
            if (data.success) {
            	var likeNum = document.querySelector('#likeNum');
            	var intLikeNum = parseInt(likeNum.textContent,10);
            	likeNum.textContent = intLikeNum + 1;
                $(this).attr('src','${imageUrlHeartFill}');
                isLike++;
            }
            else {
                alert('오류 발생! 관리자에게 문의하세요');
            }
        })
        .catch(error => {
        	alert('오류 발생! 관리자에게 문의하세요');
            console.error("Error:", error);
        });
    }
    else if(isLike==1){//취소할떄
    	fetch("<c:url value="/Board/Like.kjh"/>",{
    		method:"POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify({ no: "${param.no}",data:"DOWN" })
    	})
    	.then(response => response.json())
        .then(data => {
            if (data.success) {
            	var likeNum = document.querySelector('#likeNum');
            	var intLikeNum = parseInt(likeNum.textContent,10);
            	likeNum.textContent = intLikeNum - 1;
                $(this).attr('src','${imageUrlHeart}');
                isLike--;
            }
            else {
                alert('오류 발생! 관리자에게 문의하세요');
            }
        })
        .catch(error => {
            console.error("Error:", error);
        });
    }
});



	var deleteButton = document.querySelector('#deleteButton');
	
	deleteButton.onclick=()=>{
		if(confirm("정말로 삭제하시겠습니까?")){
			location.replace(" <c:url value='/Board/Delete.kjh?no=${param.no}'/> ");
		}
		else{
			return;
		}
	}

    function submitCommentForm() {
        document.getElementById("commentForm").submit();
    }
	

    var buttonNode = document.getElementById("buttonNode");
    var previousForm = null;

    buttonNode.onclick = function (e) {

        if (e.target.tagName === "A" && e.target.id === 'replaySub') {
            e.preventDefault();

            if (previousForm !== null) {
                previousForm.remove();
            }
            
            var formDiv = document.createElement("div");
            formDiv.className = "CommentWriter";
            
            var newForm = document.createElement("form");
            newForm.id = "commentSubForm";
            newForm.action = "<c:url value='/Board/CommentSubInsert.kjh'/>";
            newForm.method = "post";

            var textDiv = document.createElement("div");
            textDiv.textContent = "${name}";
            newForm.appendChild(textDiv);

            var textarea = document.createElement("textarea");
            textarea.placeholder = "댓글을 남겨보세요";
            textarea.rows = "1";
            textarea.name = "commentcontent";
            textarea.className = "form-control";
            newForm.appendChild(textarea);

            var hiddenInputNo = document.createElement("input");
            hiddenInputNo.type = "hidden";
            hiddenInputNo.name = "no";
            hiddenInputNo.value = "${param.no}";
            newForm.appendChild(hiddenInputNo);
            
            var hiddenInputWhether = document.createElement("input");
            hiddenInputWhether.type = "hidden";
            hiddenInputWhether.name = "replaywhether";
            hiddenInputWhether.value = "Y";
            newForm.appendChild(hiddenInputWhether);
            
            var hiddenInputCno = document.createElement("input");
            hiddenInputCno.type = "hidden";
            hiddenInputCno.name = "cno";
            hiddenInputCno.id = "commentCno"; 
            newForm.appendChild(hiddenInputCno);
            
            var dataSubId = e.target.parentElement.parentElement.getAttribute('id');
            var parentDiv = e.target.parentElement.parentElement;
            var firstChildDiv = parentDiv.querySelector('div:first-child');
            var textContent = firstChildDiv.textContent.trim();
            
            if(dataSubId){
	            var hiddenInputCno = document.createElement("input");
	            hiddenInputCno.type = "hidden";
	            hiddenInputCno.name = "subname";
	            hiddenInputCno.id = "commentSubName"; 
	            hiddenInputCno.value = textContent; 
	            newForm.appendChild(hiddenInputCno);
            }

            var dataCno = e.target.getAttribute("data-cno");
            
            var buttonDiv = document.createElement("div");
            buttonDiv.className = "comment_attach mt-2 d-flex align-items-center";

            var registerBoxDiv = document.createElement("div");
            registerBoxDiv.className = "register_box ml-auto";

            var submitButton = document.createElement("a");
            submitButton.href = "#";
            submitButton.role = "button";
            submitButton.className = "btn btn-primary";
            submitButton.textContent = "등록";

            var cancelButton = document.createElement("a");
            cancelButton.href = "javascript:void(0);";
            cancelButton.role = "button";
            cancelButton.className = "btn btn-danger";
            cancelButton.textContent = "취소";

            registerBoxDiv.appendChild(cancelButton);
            registerBoxDiv.appendChild(submitButton);
            buttonDiv.appendChild(registerBoxDiv);
            newForm.appendChild(buttonDiv);
            formDiv.appendChild(newForm);//추가
            
            var parentSpan = e.target.parentElement;
            parentSpan.insertAdjacentElement("afterend", formDiv);
            
            var dataSubcomment = e.target.parentElement.parentElement.getAttribute('data-subcomment');
			if(dataSubcomment)
				document.getElementById("commentCno").value = dataSubcomment;
			else
				document.getElementById("commentCno").value = dataCno;
			
            previousForm = formDiv;

            cancelButton.onclick = function () {
                e.preventDefault();
                previousForm.remove();
            };
            
            submitButton.onclick = function () {
                e.preventDefault();
                document.getElementById("commentSubForm").submit();
            };
        }
    };
    
    function toggleFileList() {
        var fileList = document.querySelector('.file-list');
        if (fileList.style.display === 'none') {
            fileList.style.display = 'block';
        } else {
            fileList.style.display = 'none';
        }
    }
</script>




<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/template/HeadNav.jsp"/>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/5.0.0/normalize.min.css">
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
	<c:url value="/images/pencil-square.svg" var="pencilSquare" />
<div class="jumbotron" style="background-color: white;">
	<div class="container mt-3">
		<h1 style="color: green;">'한국 ICT 1기'</h1>
		<h2>${record.title }</h2>
		<div class="profile-container">
			<c:url value="/images/${record.profile }.png" var="imageUrl" />
			<img class="img-profile rounded-circle" style="width: 40px;" id="img"
				src="${imageUrl}">
			<div class="user-info">
				<span>${record.name}</span> <br /> 
				<fmt:formatDate value="${record.postdate}" pattern="yy/MM/dd HH:mm:ss" var="formattedpostdate" />
				<span>
				${formattedpostdate}
				조회${record.visitcount}</span>
			</div>
			<div class="comment-info">
				<svg xmlns="http://www.w3.org/2000/svg" width="22" height="22" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
				  <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
				  <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2" />
				</svg>
				<span style="font-size: 15px">&nbsp;댓글${commentCount}</span>
			</div>
		</div>
		<hr />
		<div class="form-group">
			<div style="min-height: 300px; height: auto;">
				<c:if test="${record.attachFile ne 'X'}">
					<figure class="text-end">
						<blockquote class="blockquote" style="text-align: right;">
							<a href="javascript:void(0)" role="button" class="button_file"
								onclick="toggleFileList()">첨부파일 모아보기(${fileCount})</a><br>
							<div class="file-list" style="display: none;">
								<c:forEach var="file" items="${fn:split(record.attachFile,',') }">
									${file}
									<a href="<c:url value="/Board/Download.kjh?filename=${file}&no=${record.no}"/>" />다운로드</a>
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
			  <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2" />
			  <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9.06 9.06 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.437 10.437 0 0 1-.524 2.318l-.003.011a10.722 10.722 0 0 1-.244.637c-.079.186.074.394.273.362a21.673 21.673 0 0 0 .693-.125zm.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6c0 3.193-3.004 6-7 6a8.06 8.06 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a10.97 10.97 0 0 0 .398-2" />
			</svg>

			<span>댓글 ${commentCount}</span>
		</div>
		<hr />
		<div class="comment_inbox" id="buttonNode">
			<strong class="d-block mb-2" style="font-size: 17px">댓글</strong>
				<c:forEach var="c" items="${resultList}">
				
					<c:url value="/images/${c.profile }.png" var="imageUrlc" />
					
					<c:set var="formattedDate" value="${commentDTO.commentdate.time}" />
					<fmt:formatDate value="${c.commentdate}"
						pattern="yy/MM/dd HH:mm:ss" var="formattedCommentdate" />
					<%-- 답글에 답글 --%>
					<c:if test="${c.replaywhether eq 'Y' and c.isdelete eq 'N' }">
					<hr>
					<div id="test" style="display: flex; align-items: center;">
						<div >
							<img class="img-profile rounded-circle" style="margin-left:50px; width: 40px;" id="img" src="${imageUrlc}">
						</div>
						<div style="padding-left:10px; flex-grow: 1;" id='isComment' class="isComment" data-subcomment='${c.subcomment}' data-cno='${c.cno}'>
							<div style="display: flex; justify-content: space-between; align-items: center;">
								<div>${c.name}</div>
								<div style="margin-right: 20px;">
									<a id="updateComment" href="javascript:void(0);" style="color: black; margin-right: 5px;">
										<img id="commentEdit" src="${pencilSquare}" alt="업데이트" />
									</a>
									<a id="deleteComment" href="javascript:void(0);" style="color: black;">
										<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
										  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
										  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
										</svg>
									</a>
								</div>
							</div>							
							<div>
								<c:if test="${c.subname ne 'X'}">
									<span style="color: blue;"><b>${c.subname}</b></span>
								</c:if>
								<span>${c.commentcontent}</span>
							</div>
							<span style="color: #979797;"> ${formattedCommentdate} <a
								href="#" id="replaySub" data-cno="${c.cno}"
								style="color: #979797; font-size: .875rem">&nbsp;&nbsp;답글쓰기</a>
							</span>							
						</div>
					</div>
						<hr>
					</c:if>
					<%--첫번째 답글 --%>
					<c:if test="${c.replaywhether eq 'F' and c.isdelete eq 'N'}">
						<hr>
						<div style="display: flex; align-items: center;">
						<div>
							<img class="img-profile rounded-circle" style="width: 40px;" id="img" src="${imageUrlc}">
						</div>
							<div id='isComment' data-cno='${c.cno}' style="flex-grow: 1; margin-left: 10px;" >
								<div style="display: flex; justify-content: space-between; align-items: center;">
									<div>${c.name}</div>
									<div style="margin-right: 20px;">
										<a id="updateComment" href="javascript:void(0);" style="color: black; margin-right: 5px;">
											<img id="commentEdit" src="${pencilSquare}" alt="업데이트" />
										</a>
										<a id="deleteComment" href="javascript:void(0);" style="color: black;">
											<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-trash" viewBox="0 0 16 16">
											  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
											  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
											</svg>
										</a>
									</div>
								</div>						
								<div>
									<c:if test="${c.subname ne 'X'}">
										<span style="color: blue;"><b>${c.subname}</b></span>
									</c:if>
									<span>${c.commentcontent}</span>
								</div>
								<span style="color: #979797;"> ${formattedCommentdate} <a
									href="#" id="replaySub" data-cno="${c.cno}"
									style="color: #979797; font-size: .875rem">&nbsp;&nbsp;답글쓰기</a>
								</span>								
							</div>
						</div>
						<hr>
					</c:if>
					<c:if test="${c.replaywhether eq 'F' and c.isdelete eq 'Y'}">
						<hr>
							<div>삭제된 댓글입니다.</div>
						<hr>
					</c:if>
				</c:forEach>
			<%-- 삭제된 답글 --%>

		<div class="CommentWriter">
			<div style="display: flex; justify-content: space-between;">
				<span>${name }</span>
				<span id="contentCount" style="margin-right: 10px;"></span>
			</div>
			<br /> 
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
        var scrollPos = window.scrollY;
        sessionStorage.setItem('scrollPos', scrollPos);
        
        document.getElementById("commentForm").submit();
    }
	

    var buttonNode = document.getElementById("buttonNode");
    var previousForm = null;
	var commentUpdate = null;
	var contentText = null; 
	var updateCno = null;
    buttonNode.onclick = function (e) {
        if (e.target.tagName === "A" && e.target.id === 'replaySub') {
            e.preventDefault();
            
            var scrollPos = window.scrollY;
            sessionStorage.setItem('scrollPos', scrollPos);
            
			var url;
            if(commentUpdate==null){//입력
            	url = "<c:url value='/Board/CommentSubInsert.kjh'/>";
            	textValue = "";
            }
            else{//업데이트
            	url = "<c:url value='/Board/CommentUpdate.kjh'/>";
            	textValue = contentText;
            }
            
            if (previousForm !== null) {
                previousForm.remove();
            }
            
            var formDiv = document.createElement("div");
            formDiv.className = "CommentWriter";
            
            var newForm = document.createElement("form");
            newForm.id = "commentSubForm";
            newForm.action = url;
            newForm.method = "post";

            var textDiv = document.createElement("div");
            textDiv.style.display = "flex"; 
            textDiv.style.justifyContent = "space-between"; 
            textDiv.className = "mb-2"; 
            newForm.appendChild(textDiv);

            var nameSpan = document.createElement("span");
            nameSpan.textContent = "${name}";
            textDiv.appendChild(nameSpan);
            
            var countSpan = document.createElement("span");
            countSpan.style.marginRight = "10px"; 
            countSpan.id = "contentCount";
            textDiv.appendChild(countSpan);
            
            var textarea = document.createElement("textarea");
            textarea.placeholder = "댓글을 남겨보세요";
            textarea.rows = "1";
            textarea.name = "commentcontent";
            textarea.className = "form-control";
            textarea.value = textValue;
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
            
            if(updateCno!=null){
                var hiddenUpdateCno = document.createElement("input");
                hiddenUpdateCno.type = "hidden";
                hiddenUpdateCno.name = "updateCno";
                hiddenUpdateCno.id = "updateCno"; 
                hiddenUpdateCno.value = updateCno; 
                newForm.appendChild(hiddenUpdateCno);           	
            }
            
            var dataSubClass = e.target.parentElement.parentElement.className;
            var parentDiv = e.target.parentElement.parentElement;
            var firstChildDiv = parentDiv.querySelector('div:first-child');
            var textContent = firstChildDiv.textContent.trim();
            if(dataSubClass==="isComment"){
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
                commentUpdate=null;
                contentText=null;
                updateCno=null;
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
    
    var deleteComment = document.querySelectorAll('#isComment');
    deleteComment.forEach(function(button) {
        button.addEventListener('click', function(e) {
			if(e.target.tagName==='svg' || e.target.tagName==='path'){
				if(confirm("정말로 댓글을 삭제하시겠습니까?")){
		        	e.preventDefault();
		            var isCommentDiv = e.target.closest('[id="isComment"]');
		            var dataCno = isCommentDiv.getAttribute('data-cno');
		            fetch("<c:url value="/Board/deleteComment.kjh"/>",{
		        		method:"POST",
		                headers: {
		                    "Content-Type": "application/json"
		                },
		                body: JSON.stringify({ dataCno:dataCno })
		        	})
		        	.then(response => response.json())
		       		.then(data => {
		            	if (data.success) {
		                    // 응답이 성공적으로 왔을 때, 현재 스크롤 위치를 저장
		                    var scrollPos = window.scrollY;
		                    sessionStorage.setItem('scrollPos', scrollPos);
		                    // 페이지를 다시 로드
		                    location.reload();
		            	}
		       		})
		            .catch(error => {
		            	alert('오류 발생! 관리자에게 문의하세요');
		                console.error("Error:", error);
		            });
	        	}
				else{
					//취소했으니까
					return;
				}
			}
			if(e.target.tagName==='IMG'){
			    // 'IMG' 요소의 부모 노드인 <div>를 찾음
			    var parentDiv = e.target.closest('#isComment');
			    // 내용값 가져옴
			    contentText = parentDiv.children[1].lastElementChild.textContent;
			    commentUpdate = "update";
			    updateCno = parentDiv.getAttribute('data-cno');
			    parentDiv.children[2].lastElementChild.click();
			}
        });
    });
    
    window.addEventListener('load', function() {
        var scrollPos = sessionStorage.getItem('scrollPos');
        if (scrollPos !== null) {
            // 저장된 스크롤 위치로 이동
            window.scrollTo(0, scrollPos);
            // 저장된 스크롤 위치 정보는 이제 필요 없으므로 제거
            sessionStorage.removeItem('scrollPos');
        }
    });
    
    var contentCounts = document.querySelectorAll('[name="commentcontent"]');
    contentCounts.forEach(function(contentCount) {
	    contentCount.onkeyup=(e)=>{
	    	count = 99;
	    	document.querySelector('#contentCount').textContent 
	    		= contentCount.value.length+" / "+count;
	    	if(contentCount.value.length >= count){
	    		e.preventDefault();
	    		alert('글자 수를 초과했어요!');
	    		return;
	    	}
	    };
    });
    
    document.addEventListener('keyup', function (e) {
        // 클릭된 엘리먼트가 원하는 조건을 만족하는지 확인
        if (e.target.name === 'commentcontent') {
            count = 99;
            console.log(e.target.value.length);
            // 폼 내에서 동적으로 생성된 #contentCount 찾기
            var contentCount = e.target.closest('form').querySelector('#contentCount');
            if (contentCount) {
                contentCount.textContent = e.target.value.length + ' / ' + count;
                if (e.target.value.length >= count) {
                    e.preventDefault();
                    alert('글자 수를 초과했어요!');
                    return;
                }
            }
        }
    });
</script>




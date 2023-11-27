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
</style>
<div class="jumbotron">
	<legend>상세보기</legend>

<fieldset>
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


	<div class="form-group">
		<label for="exampleInputEmail1">제목</label> <input type="text"
			class="form-control" id="title" value="${record.title }" disabled="">
	</div>
	<div class="form-group">
		<label for="exampleInputEmail1">이름</label> <input type="text"
			class="form-control" id="name" value="${record.name }" disabled="">
	</div>
	<div class="form-group">
		<label for="exampleInputEmail1">등록일</label> <input type="text"
			class="form-control" id="" value="${record.postdate}" disabled="">
	</div>
	<div class="form-group">
		<label for="exampleInputEmail1">조회수</label> <input type="text"
			class="form-control" id="" value="${record.visitcount}" disabled="">
	</div>
	<div class="form-group">
		<label for="exampleInputEmail1">댓글수</label> <input type="text"
			class="form-control" id="" value="${commentCount}" placeholder="댓글하면"
			disabled="">
	</div>

	<div class="form-group">
		<label for="exampleTextarea">내용</label>
		<textarea class="form-control" id="content" rows="3" disabled="">${record.content }</textarea>
	</div>

	<c:url value="/images/chat-dots.svg" var="imageUrlChat" />
	<c:url value="/images/heart.svg" var="imageUrlHeart" />
	<c:url value="/images/heart-fill.svg" var="imageUrlHeartFill" />
	<div class="jumbotron" style="background-color: white;">
		<div id="likeAndCommentCount">
			<c:if test="${isLike==0}">
				<img id="heart" src="${imageUrlHeart}" alt="좋아요" />
			</c:if>
			<c:if test="${isLike==1}">
				<img id="heart" src="${imageUrlHeartFill}" alt="좋아요" />
			</c:if>
			<span>좋아요</span> <span id="likeNum">${likeRecord}</span> <img
				id="chat" src="${imageUrlChat}" alt="채팅" /> <span>댓글
				${commentCount}</span>
		</div>


		<hr />
		<div class="container mt-3">

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
			</div>

		</div>
	</div>
	</div>

	<a class="btn btn-primary btn-lg"
		href="<c:url value="/Board/Insert.kjh"/>" role="button">글쓰기</a> <a
		class="btn btn-primary btn-lg"
		href="<c:url value="/Board/Edit.kjh?no=${param.no}"/>" role="button">수정</a>
	<a class="btn btn-danger btn-lg" id="deleteButton" role="button">삭제</a>
	<a class="btn btn-primary btn-lg"
		href="<c:url value="/Board/List.kjh"/>" role="button">목록</a>
</fieldset>



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




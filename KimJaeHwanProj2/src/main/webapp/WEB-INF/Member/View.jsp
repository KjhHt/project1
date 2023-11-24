<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
	  <fieldset>
	    <legend>상세보기</legend>
	    <div hidden>ㄴㅁㅇㄴㅁㅇㄴㅁㅇㄴㅁ</div>
	    <div class="form-group">
	      <label for="exampleInputEmail1">제목</label>
	      <input type="text" class="form-control" id="title" value="${record.title }" disabled="">
	    </div>
	    <div class="form-group">
	      <label for="exampleInputEmail1">이름</label>
	      <input type="text" class="form-control" id="name" value="${record.name }" disabled="">
	    </div>
	    <div class="form-group">
	      <label for="exampleInputEmail1">등록일</label>
	      <input type="text" class="form-control" id="" value="${record.postdate}" disabled="">
	    </div>
	    <div class="form-group">
	      <label for="exampleInputEmail1">조회수</label>
	      <input type="text" class="form-control" id="" value="${record.visitcount}" disabled="">
	    </div>
	    <div class="form-group">
	      <label for="exampleInputEmail1">댓글수</label>
	      <input type="text" class="form-control" id="" value="${r}" placeholder="댓글하면" disabled="">
	    </div>
	    <div class="form-group">
	      <label for="exampleTextarea">내용</label>
	      <textarea class="form-control" id="content" rows="3" disabled="">${record.content }</textarea>
	    </div>
	    
	    
<div class="jumbotron" style="background-color: white;">

	좋아요 ${likeRecord} 댓글 ${commentCount}
	<hr />
	<div class="container mt-3">
		<div class="CommentWriter">

			<div class="comment_inbox">
				<strong class="d-block mb-2" style="font-size: 17px">댓글</strong>
					<c:if test="${commentCount ne 0}">
						<c:forEach var="c" items="${resultList}">
						<c:set var="formattedDate" value="${commentDTO.commentdate.time}"/>
						<fmt:formatDate value="${c.commentdate}" pattern="yy/MM/dd HH:mm:ss" var="formattedCommentdate"/>
							<hr>
							<div ${c.replaywhether eq 'Y' ? "style='padding-left:50px;'" : "" } >
								${c.name}<br/>
								${c.commentcontent}<br/>
								<span style="color:#979797;">
									${formattedCommentdate}
									<a href="" style="color:#979797; font-size:.875rem" >&nbsp;&nbsp;답글쓰기</a>
								</span>
							</div>
							<style>
    #commentForm2 {
        display: none;
    }
</style>  <!--  gpt참고해서 주말에합시다. -->
				<form id="commentForm2" action="<c:url value="/Board/CommentInsert.kjh"/>" method="post">
					<textarea placeholder="댓글을 남겨보세요" rows="1" name="commentcontent" class="form-control"></textarea>
					<input type="hidden" name="no" value="${param.no}"/>
					<input type="hidden" name="f" value="f" />
					<div class="comment_attach mt-2 d-flex align-items-center">
						<div class="register_box ml-auto">
							<a href="#" role="button" class="btn btn-primary" onclick="submitCommentForm2()">등록</a>
						</div>
					</div>
				</form>

							<hr>
						</c:forEach>
					</c:if>
				<br /> 
				김재환
			<form id="commentForm" action="<c:url value="/Board/CommentInsert.kjh"/>" method="post">
				<textarea placeholder="댓글을 남겨보세요" rows="1" name="commentcontent" class="form-control"></textarea>
				<input type="hidden" name="no" value="${param.no }"/>
			<div class="comment_attach mt-2 d-flex align-items-center">
				<div class="register_box ml-auto">
					<a href="#" role="button" class="btn btn-primary" onclick="submitCommentForm()">등록</a>
				</div>
			</div>
			</form>
			</div>

		</div>
	</div>
</div>
	    
	    <a class="btn btn-primary btn-lg"
			href="<c:url value="/Board/Insert.kjh"/>" role="button">글쓰기</a>
	    <a class="btn btn-primary btn-lg"
			href="<c:url value="/Board/Edit.kjh?no=${param.no}"/>" role="button">수정</a>
	    <a class="btn btn-danger btn-lg" id="deleteButton" role="button">삭제</a>
	    <a class="btn btn-primary btn-lg"
			href="<c:url value="/Board/List.kjh"/>" role="button">목록</a>
	  </fieldset>

	
	
</div>
<script>
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
	
    function submitCommentForm2() {
        document.getElementById("commentForm2").submit();
    }

</script>




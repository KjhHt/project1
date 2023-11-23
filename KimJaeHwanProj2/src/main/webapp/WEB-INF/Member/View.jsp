<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
	<!-- 나중에 -->
	<form action="" method="post">
	</form>
	  <fieldset>
	    <legend>상세보기</legend>
	    
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
						<c:forEach var="c" items="${commentList}">
							<hr>
							${c.name}
							${c.commentdate}<br/>
							${c.commentcontent}
							<hr>
						</c:forEach>
					</c:if>
				<br /> 
				김재환
				<textarea placeholder="댓글을 남겨보세요" rows="1" class="form-control"></textarea>
			</div>
			<div class="comment_attach mt-2 d-flex align-items-center">
				<label for="attach3" class="button_file m-0 mr-2"> <input
					id="attach3" type="file" title="사진첨부" accept="image/*, image/heic"
					class="d-none">
				</label>
				<div class="register_box ml-auto">
					<a href="#" role="button" class="btn btn-primary">등록</a>
				</div>
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


</script>




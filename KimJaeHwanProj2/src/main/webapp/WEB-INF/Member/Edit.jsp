<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">

	<form action="<c:url value="/Board/Edit.kjh"/>" method="post">
	  <fieldset>
	    <legend>수정</legend>
	    <input type="hidden" name="no" value=${param.no}/>
	    <div class="form-group">
	      <label for="exampleInputEmail1">제목</label>
	      <input type="text" class="form-control" id="title" name="title" value="${list.title }" placeholder="제목을 입력하세요">
	    </div>
   	    <div class="form-group">
	      <label for="">첨부파일</label>
	      <input type="file" class="form-control" id="file" name="file" multiple>
	    </div>
	<c:if test="${list.attachFile ne 'X'}">
		<div class="file-list">
			<c:forEach var="file" items="${fn:split(list.attachFile,',') }">
				<div>${file}</div>
				<br />
			</c:forEach>
		</div>
	</c:if>
	    <div class="form-group">
	      <label for="exampleTextarea">내용</label>
	      <textarea class="form-control" id="content" name="content" rows="5">${list.content }</textarea>
	    </div>
	    <button type="submit" class="btn btn-primary">수정</button>
	  </fieldset>
	</form>
	
	
</div>
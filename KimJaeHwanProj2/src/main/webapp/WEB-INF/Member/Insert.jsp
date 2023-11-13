<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">

	<form action="<c:url value="/Board/Insert.kjh"/>" method="post">
	  <fieldset>
	    <legend>입력</legend>
	    
	    <div class="form-group">
	      <label for="exampleInputEmail1">제목</label>
	      <input type="text" class="form-control" id="title" name="title" placeholder="제목을 입력하세요">
	    </div>
	    <div class="form-group">
	      <label for="exampleTextarea">내용</label>
	      <textarea class="form-control" id="content" name="content" rows="3"></textarea>
	    </div>
	    <button type="submit" class="btn btn-primary">등록</button>
	  </fieldset>
	</form>
	
	
</div>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<jsp:include page="/template/HeadNav.jsp" />
<style>
.pl {
	width: 100px;
	border: 1px solid #C4C4C4;
	box-sizing: border-box;
	border-radius: 10px;
	padding: 12px 13px;
	font-family: 'Roboto';
	font-style: normal;
	font-weight: 400;
	font-size: 14px;
	line-height: 16px;
}

.pl:focus {
	border: 1px solid black;
	box-sizing: border-box;
	border-radius: 10px;
	border-radius: 10px;
}
</style>

<div class="jumbotron">
	<div class="d-flex justify-content-between align-items-center">
		<a class="btn btn-primary btn-lg"
			href="<c:url value="/Board/Insert.kjh"/>" role="button">글등록</a>
		<div>
			<select class="pl" id="pageSize" >
				<option value="5" ${sessionScope.pageSize eq 5 ? 'selected':""}>5개씩</option>
				<option value="10" ${sessionScope.pageSize eq 10 ? 'selected':""} >10개씩</option>
				<option value="15" ${sessionScope.pageSize eq 15 ? 'selected':""}>15개씩</option>
				<option value="20" ${sessionScope.pageSize eq 20 ? 'selected':""}>20개씩</option>
				<option value="30" ${sessionScope.pageSize eq 30 ? 'selected':""}>30개씩</option>
				<option value="40" ${sessionScope.pageSize eq 40 ? 'selected':""}>40개씩</option>
				<option value="50" ${sessionScope.pageSize eq 50 ? 'selected':""}>50개씩</option>
			</select>
		</div>
	</div>
	<hr class="my-4">


	<table class="table table-hover">
		<thead>
			<tr style="text-align: center">
				<th scope="col" colspan="2">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">조회</th>
				<th scope="col">좋아요(미구현)</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="list" items="${list}">
				<tr>
					<th scope="row" style="text-align: center">${list.no}</th>
					<td><a href="<c:url value="/Board/View.kjh?no=${list.no}"/>">${list.title}</a></td>
					<td style="text-align: center">${list.username}</td>
					<td style="text-align: center">${list.postdate}</td>
					<td style="text-align: center">${list.visitcount}</td>
					<td style="text-align: center">0</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	${paging}
<form method="post">
	<div style="display: flex; align-items: center;">
	    
	    <select class="pl" name="postDate" style="width:142px; height:35px; line-height:35px; padding:0px 13px; margin-right:3px;">
	        <option value="">전체기간</option>
	        <option value="day">1일</option>
	        <option value="week">1주</option>
	        <option value="oneMonth">1개월</option>
	        <option value="sixMonth">6개월</option>
	        <option value="year">1년</option>
	    </select>
	    
	    <select class="pl" name="searchColumn" style="width:142px; height:35px; line-height:35px; padding:0px 13px;">
	        <option value="title">제목만</option>
	        <option value="username">글작성자</option>
	        <option>댓글내용</option>
	        <option>댓글작성자</option>
	    </select>
	    <div  style="width: 256px; margin-left: 10px; display: flex; align-items: center;">
	        <input type="text" name="searchWord" class="form-control" placeholder="검색어를 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
	        <button style="width:76px; height:36px; padding:0px;" class="btn btn-success" type="submit" id="button-addon2">검색</button>
	    </div>
	</div>
</form>

</div>


<script>


</script>
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
				<option value="5" ${sessionScope.pageSize eq 5 ? 'selected':''} >5개씩</option>
				<option value="10" ${sessionScope.pageSize eq 10 ? 'selected':''}>10개씩</option>
				<option value="15" ${sessionScope.pageSize eq 15 ? 'selected':''}>15개씩</option>
				<option value="20" ${sessionScope.pageSize eq 25 ? 'selected':''}>20개씩</option>
				<option value="30" ${sessionScope.pageSize eq 30 ? 'selected':''}>30개씩</option>
				<option value="40" ${sessionScope.pageSize eq 40 ? 'selected':''}>40개씩</option>
				<option value="50" ${sessionScope.pageSize eq 50 ? 'selected':''}>50개씩</option>
			</select>
		</div>
	</div>
	<hr class="my-4">

	<table class="table table-hover" >
		<thead>
			<tr style="text-align: center">
				<th scope="col" colspan="2">제목</th>
				<th scope="col">작성자</th>
				<th scope="col">작성일</th>
				<th scope="col">조회</th>
				<th scope="col">좋아요</th>
			</tr>
		</thead>
		<tbody id="tableData">
			<c:forEach var="list" items="${list}"  >
				<tr>
					<th scope="row" style="text-align: center">${list.no}</th>
					<td>
						<a id="viewClick" href="<c:url value="/Board/View.kjh?no=${list.no}"/>">${list.title}</a>
						<c:if test="${list.commentCount ne 0}">
							<span class="text-danger">[${list.commentCount}]</span>
						</c:if>
						<c:if test="${list.attachFile ne 'X'}">
							<span>
								<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16">
								  <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
								</svg>
							</span>
						</c:if>
					</td>
					<td style="text-align: center">${list.name}</td>
					<td style="text-align: center">${list.postdate}</td>
					<td style="text-align: center">${list.visitcount}</td>
					<td style="text-align: center">${list.likecount }</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	${paging}
<form method="get">
	<c:set var="nowPage" value="${param.nowPage==null?1:param.nowPage}"/>
	<input type="hidden" name="nowPage" value="${nowPage}"/>
	<div style="display: flex; align-items: center;">
	    <select class="pl" name="postDate" style="width:142px; height:35px; line-height:35px; padding:0px 13px; margin-right:3px;">
	        <option value="">전체기간</option>
	        <option value="day" ${param.postDate eq 'day' ? 'selected':''}>1일</option>
	        <option value="week" ${param.postDate eq 'week' ? 'selected':''}>1주</option>
	        <option value="oneMonth" ${param.postDate eq 'oneMonth' ? 'selected':''}>1개월</option>
	        <option value="sixMonth" ${param.postDate eq 'sixMonth' ? 'selected':''}>6개월</option>
	        <option value="year" ${param.postDate eq 'year' ? 'selected':''}>1년</option>
	    </select>
	    
	    <select class="pl" name="searchColumn" style="width:142px; height:35px; line-height:35px; padding:0px 13px;">
	        <option value="title" ${param.searchColumn eq 'title' ? 'selected':''}>제목만</option>
	        <option value="name" ${param.searchColumn eq 'name' ? 'selected':''}>글작성자</option>
	    </select>
	    <div  style="width: 256px; margin-left: 10px; display: flex; align-items: center;">
	        <input type="text" name="searchWord" value="${param.searchWord }" class="form-control" placeholder="검색어를 입력해주세요" aria-label="Recipient's username" aria-describedby="button-addon2">
	        <button style="width:76px; height:36px; padding:0px;" class="btn btn-success" type="submit" id="button-addon2">검색</button>
	    </div>
	</div>
</form>

</div>


<script>
	document.querySelector('#pageSize').onchange = () => {
		var pageSize = document.querySelector('#pageSize').value;
		var data = {data : pageSize};
	
		fetch("<c:url value="/Board/List.kjh"/>",{
			method:"POST",
		    headers: {
		      'Content-Type': 'application/json'
		    },
			body:JSON.stringify(data)})
		.then(response => {
			if(!response.ok){
				throw new Error('서버 전송 실패');
			}
			location.reload();
		})
		.catch(err=>console.log('서버 전송 실패 : ',err));
	}
	
	var tableData = document.querySelector('#tableData');
	tableData.onclick = function(e){
		if(e.target.id==='viewClick'){
			var parentTd = e.target.parentElement;
			var visitNum = parentTd.nextElementSibling.nextElementSibling.nextElementSibling;
			var newCount = parseInt(visitNum.textContent, 10) + 1;
			visitNum.textContent = newCount;
		}
			
	}


</script>
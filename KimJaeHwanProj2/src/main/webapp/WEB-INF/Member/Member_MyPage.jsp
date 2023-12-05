<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<link href="<c:url value='/template/css/style.css'/>" rel="stylesheet">
<jsp:include page="/template/HeadNav.jsp" />


<div class="jumbotron">
	<c:if test="${not empty username}">
	<!-- 여기에다가 프로필 -->
	<h1 class="display-4">마이페이지</h1>
	<hr class="my-4">
	<div class="container white-box">
		<div class="contents">
			<div class="profile-simple">
				<div>
					<div class="profileImgDiv">
						<c:url value="/images/${list.profile}.png" var="imageUrl" />
						<img id="img" src="${imageUrl}" width="150" height="145" alt="프로필" /> 
					</div>
					<div class="customerInfo">
						<span>${list.name}</span><span style="color: #6fbaf8">${list.gender}</span>
						<p>${list.email}</p>
						<div class="answer_select_accordion">
							<button type="button"  class="answer_select_accordion_btn arrow_down" style="display: flex;">
								<c:choose>
								    <c:when test="${list.profile eq 1}">배찌</c:when>
								    <c:when test="${list.profile eq 2}">우니</c:when>
								    <c:when test="${list.profile eq 3}">디즈니</c:when>
								    <c:when test="${list.profile eq 4}">마리드</c:when>
								    <c:when test="${list.profile eq 5}">케피</c:when>
								    <c:when test="${list.profile eq 6}">모스</c:when>
								    <c:when test="${list.profile eq 7}">에띠</c:when>
								    <c:when test="${list.profile eq 8}">다오</c:when>
									<c:otherwise>미설정</c:otherwise>
								</c:choose>
							</button>
							<ul class="answer_select_drop" style="display: none;">
								<li class="select_list"><button type="button" class="option-btn" value="0">미설정</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="1">배찌</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="2">우니</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="3">디즈니</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="4">마리드</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="5">케피</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="6">모스</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="7">에띠</button></li>
								<li class="select_list"><button type="button" class="option-btn" value="8">다오</button></li>
							</ul>
						</div>	
					</div>
				</div>
				<div class="btnDiv">
					<button class="modifyBtn">회원정보 수정</button>
				</div>
			</div>
			<div class="customerSubInfo">
				<ul>
					<li>
						<span>관심사항</span>
						<span>
							<c:if test="${fn:contains(list.inters, '정치')}">
								<button id="politics" type="button" onclick="test(event)" class="btn btn-secondary">정치</button>
							</c:if>
							<c:if test="${fn:contains(list.inters, '경제')}">
								<button id="economy" type="button" onclick="test(event)" class="btn btn-secondary">경제</button>
							</c:if>
							<c:if test="${fn:contains(list.inters, '연예')}">
								<button id="entertainment" type="button" onclick="test(event)" class="btn btn-secondary">연예</button>
							</c:if>
						</span>
					</li>
					<li>
						<span>학력</span>
						<span>
							<c:choose>
							    <c:when test="${list.education eq 1}">초등학교</c:when>
							    <c:when test="${list.education eq 2}">중학교</c:when>
							    <c:when test="${list.education eq 2}">고등학교</c:when>
							    <c:when test="${list.education eq 2}">대학교</c:when>
								<c:otherwise>대학원</c:otherwise>
							</c:choose>
						</span>
					</li>
					<li>
						<span>등록일</span>
						<span>${list.regidate}</span>
					</li>
					<li>
						<p>자기소개</p>
						<div>
							${list.selfintroduce}
						</div>
					</li>
				</ul>
			</div>
		</div>
	</div>
	</c:if>

</div>


<script>

	var editButton = document.querySelector('.modifyBtn');
	editButton.onclick=()=>{
		location.href="<c:url value="/Board/EditMember.kjh"/>"
	}

	function test(e){
		var interId;
		if( e.target.id === 'politics' )
			interId = 'politics';
		else if( e.target.id === 'economy' )
			interId = 'economy';
		else if( e.target.id === 'entertainment' )
			interId = 'entertainment';
		else
			interId = 'error';
		window.open('<c:url value="/Board/Scrapping.kjh?interId='+interId+'"/>','Scrapping','width=800,height=800');
	}
	
	function updateProfileImage(value){
		var selectedValue = value;
		axios.post('<c:url value="/Board/ProfileUpdate.kjh"/>',
				  { data : selectedValue })
		.then(function(response){
			if(response.status === 200){
				updateProfile(selectedValue);
				location.reload();
				alert('프로필 업데이트 완료!');
			}
			else{
				alert('프로필 업데이트 실패! 관리자에게 문의하세요');
			}
		})
		.catch(err=>console.log(err))
	}
	
	function updateProfile(selectedValue){
	    var imageElement = document.getElementById('img');
	    var imageUrl;
	    switch (selectedValue) {
	      case '0':
	        imageUrl = '<c:url value="/images/0.png"/>';
	        break;
	      case '1':
	        imageUrl = '<c:url value="/images/1.png"/>';
	        break;
	      case '2':
	        imageUrl = '<c:url value="/images/2.png"/>';
	        break;
	      case '3':
	        imageUrl = '<c:url value="/images/3.png"/>';
	        break;
	      case '4':
	        imageUrl = '<c:url value="/images/4.png"/>';
	        break;
	      case '5':
	        imageUrl = '<c:url value="/images/5.png"/>';
	        break;
	      case '6':
	        imageUrl = '<c:url value="/images/6.png"/>';
	        break;
	      case '7':
	        imageUrl = '<c:url value="/images/7.png"/>';
	        break;
	      case '8':
	        imageUrl = '<c:url value="/images/8.png"/>';
	        break;
	      default:
	        imageUrl = '<c:url value="/images/error.png"/>';
	    }
	    // 이미지 업데이트
	    imageElement.src = imageUrl;
	}
	
	$('.answer_select_accordion_btn').click(function(){
		$('.answer_select_drop').stop().slideUp(400);
		$('.answer_select_accordion_btn').removeClass('arrow_up');
		if ($(this).next('.answer_select_drop').is(':hidden')){
			$(this).next('.answer_select_drop').slideDown(400);
			$(this).addClass('arrow_up');
			$(this).removeClass('arrow_down');
		} else {
			$(this).next('.answer_select_drop').slideUp(400);
			console.log("arrow");
			$(this).removeClass('arrow_up');
			$(this).addClass('arrow_down');
		}
	});

	var imgBtn = document.querySelectorAll('.option-btn');
	var imgAccordion = document.querySelector('.answer_select_accordion_btn');
	imgBtn.forEach(function(button) {
		button.addEventListener('click', function() {
			var buttonValue = button.value;
			var buttonText = button.textContent;
			if (buttonValue !== null || buttonValue.trim() !== "") {
				imgAccordion.textContent = buttonText;
				updateProfileImage(buttonValue);
				$('.answer_select_drop').slideUp(400);
				$('.select_list button').css("color", "#222");
			}
		});
	});
	
	
</script>
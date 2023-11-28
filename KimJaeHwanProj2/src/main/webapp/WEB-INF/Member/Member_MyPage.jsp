<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/template/HeadNav.jsp" />

<div class="jumbotron">
	<c:if test="${not empty username}">


	<!-- 여기에다가 프로필 -->
	
	<h1 class="display-4">마이페이지</h1>
	<hr class="my-4">
	<div class="container white-box">
		<div class="row">
			<div class="col-md-8 profile-simple">
				<div class="d-flex">
					<div class="flex-shrink-0">
						<c:url value="/images/${list.profile}.png" var="imageUrl" />
						<img id="img" src="${imageUrl}" width="150" height="145" alt="프로필" /> 

    <div class="form-group">
      <label for="updateProfileImage" class="form-label mt-4">프로필 캐릭터 이미지</label>
      <select class="form-select" id="updateProfileImage" onchange="updateProfileImage()" >
        <option value="0" ${list.profile == '0' ? 'selected' : ''}>미 설정</option>
        <option value="1" ${list.profile == '1' ? 'selected' : ''}>배찌</option>
        <option value="2" ${list.profile == '2' ? 'selected' : ''}>우니</option>
        <option value="3" ${list.profile == '3' ? 'selected' : ''}>디즈니</option>
        <option value="4" ${list.profile == '4' ? 'selected' : ''}>마리드</option>
        <option value="5" ${list.profile == '5' ? 'selected' : ''}>케피</option>
        <option value="6" ${list.profile == '6' ? 'selected' : ''}>모스</option>
        <option value="7" ${list.profile == '7' ? 'selected' : ''}>에띠</option>
        <option value="8" ${list.profile == '8' ? 'selected' : ''}>다오</option>
      </select>
    </div>			
						
					</div>
					<div class="flex-grow-1 ms-3">
						<h3>${list.name }님</h3>
						<p>${list.email }</p>
						<div>
							<i class="fa-solid fa-location-dot d-inline-block"
								style="color: #6fbaf8"></i> <span
								style="color: #6fbaf8">${list.gender }</span>
						</div>
		<a class="btn btn-success"
			href="<c:url value="/Board/EditMember.kjh"/>" role="button">회원정보수정</a>
					</div>
				</div>
			</div>
			<div class="col-md-4 border-left">
				<div class="row profile-detail">
					<div class="col-6">
						<p>관심사항</p>
					</div>
					<div class="col-6">
						<p>${list.inters }</p>
					</div>
					<div class="col-6">
						<p>학력</p>
					</div>
					<div class="col-6">
						<p>${list.education }</p>
					</div>
					<div class="col-6">
						<p>등록일</p>
					</div>
					<div class="col-6">
						<p>${list.regidate }</p>
					</div>
					<div class="col-6">
						<p>자기소개</p>
					</div>
					<div class="col-6">
						<p>${list.selfintroduce }</p>
					</div>
				</div>
			</div>
		</div>
	</div>
	</c:if>

</div>
<script>

	
	function updateProfileImage(){
		var selectedValue = document.getElementById('updateProfileImage').value;
		
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
	
	
	
	
</script>
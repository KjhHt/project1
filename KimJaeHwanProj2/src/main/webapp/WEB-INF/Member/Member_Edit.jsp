<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/template/HeadNav.jsp"/>
<style>
  .horizontal-form-group {
    display: flex;
  }

  .horizontal-form-group fieldset {
    width: 178px;
  }

  .horizontal-form-group fieldset:nth-child(3) {
    width: 178px;
  }
</style>

<div class="jumbotron" style="width:600px; margin-left:auto; margin-right:auto;">
<form action="#" method="post" id="editForm">
  <fieldset>
    <h2 class="display-4" style="text-align:center; margin-bottom:20px">회원정보 수정</h2>
    <div class="form-group">
      <label for="exampleInputEmail1">아이디(수정불가)</label>
      <input type="text" class="form-control" id="username" name="username" value="${memberDto.username}" readonly>
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="password" name="password" value="${memberDto.password}" placeholder="비밀번호" >
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="password_ck" name="password_ck" placeholder="비밀번호 확인" >
    </div>
    <div class="form-group">
      <label for="exampleInputEmail1">이름</label>
      <input type="text" class="form-control" id="name" name="name" value="${memberDto.name}" placeholder="이름">
    </div>
    <div class="form-group">
      <label for="exampleInputEmail1">이메일</label>
      <input type="text" class="form-control" id="email" name="email" value="${memberDto.email}" placeholder="이메일">
    </div>
<div class="horizontal-form-group">  
    <fieldset class="form-group">
      <legend style="font-size:22px; color:gray;">성별</legend>
      <div class="form-check">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" id="optionsRadios1" 
          	<c:if test="${memberDto.gender eq 'M'}">checked=""</c:if>
          value="M" >
          남자
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" id="optionsRadios1" 
          	<c:if test="${memberDto.gender eq 'F'}">checked=""</c:if>
          value="F" >
          여자
        </label>
      </div>
    </fieldset>
    
    <c:set var="inter" value="${memberDto.inters}"/>
    <div class="form-group">
    <fieldset class="form-group">
      <legend style="font-size:22px; color:gray;">관심사항</legend>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" name="inters" 
          	${fn:contains(memberDto.inters,'정치') ? 'checked':'' }
          value="1">
          정치
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" name="inters" 
          	${fn:contains(memberDto.inters,'경제') ? 'checked':'' }
          value="2">
          경제
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" name="inters" 
          	${fn:contains(memberDto.inters,'연예') ? 'checked':'' }
          value="3">
          연예
        </label>
      </div>
    </fieldset>
</div>
    <c:set var="education" value="${memberDto.education}"/>
    <div class="form-group">
    <select class="form-control" id="" name="education" >
        <option>학력 선택(필수)</option>
        <option value="1" ${memberDto.education eq '1' ? 'selected' : ''}>초등학교</option>
        <option value="2" ${memberDto.education eq '2' ? 'selected' : ''}>중학교</option>
        <option value="3" ${memberDto.education eq '3' ? 'selected' : ''}>고등학교</option>
        <option value="4" ${memberDto.education eq '4' ? 'selected' : ''}>대학교</option>
        <option value="5" ${memberDto.education eq '5' ? 'selected' : ''}>대학원</option>
      </select>
    </div>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">자기소개</label>
      <textarea class="form-control" id="selfintroduce" rows="10" name="selfintroduce" placeholder="자기소개를 입력하세요" >${memberDto.selfintroduce}</textarea>
    </div>

    <button type="submit" class="btn btn-primary">수정</button>
    <a id="deleteButton" href="#" class="btn btn-primary">회원탈퇴</a>
  </fieldset>
</form>
</div>

<script>
window.addEventListener("DOMContentLoaded", function() {
	
	var deleteButton = document.querySelector('#deleteButton');
	deleteButton.onclick=()=>{
		if(confirm("정말로 탈퇴하시겠습니까?")){
			location.replace(" <c:url value='/Board/DelMember.kjh'/> ");
		}
		else{
			return;
		}
	}
	
	
	var form = document.querySelector('#editForm');
	var password = document.getElementById("password");
	var password_ck = document.getElementById("password_ck");
	var selfintroduce = document.getElementById("selfintroduce");
	var name = document.getElementById("name");
	var email = document.getElementById("email");
	var isValid = {};

	password.addEventListener("blur", function() {
        var passwordValue = password.value.trim();
        var regex = /^(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#$%^&*()_-])[A-Za-z\d!@#$%^&*()_-]{8,16}$/;
        if(!regex.test(passwordValue)){
        	isValid.password = false;
        	checkPasswordMatch();
        	failMessage(password,"비밀번호는 8~16자의 영문 대/소문자, 숫자, 특수문자를 사용해 주세요.");
        }
		else{
			isValid.password = true;
			successMessage(password,"사용 가능합니다!");
		}
    });
	
	password_ck.addEventListener("blur", checkPasswordMatch);
	function checkPasswordMatch() {
        var passwordValue = password.value.trim();
        var password_ckValue = password_ck.value.trim();
        if(passwordValue !== password_ckValue){
        	failMessage(password_ck,"비밀번호가 일치하지 않습니다!");
        	isValid.password_ck = false;
        }
        else{
        	successMessage(password_ck,"비밀번호가 일치합니다!");
        	isValid.password_ck = true;
        }
    }
	
	selfintroduce.addEventListener("blur", function() {
	    var selfIntroduceValue = selfintroduce.value.trim();
	    var maxLength = 1000;
	    if (selfIntroduceValue.length > maxLength) {
	        failMessage(selfintroduce, "자기소개는 "+maxLength+"글자 이하로 작성해주세요.");
	        isValid.selfintroduce = false;
	    } else {
	    	if(selfIntroduceValue.length === 0){
    			selfintroduce.classList.remove("is-valid");
    			selfintroduce.classList.remove("is-invalid");
	    	}
	    	else{
	    		successMessage(selfintroduce, "");
	    		isValid.selfintroduce = true;
	    	}
	    }
    });
	
	
	name.addEventListener("blur", function() {
        var nameValue = name.value.trim();
        var regex = /^[가-힣]{2,4}$/;
        if(!regex.test(nameValue)){
        	isValid.name = false;
        	failMessage(name,"이름은 한글 4글자 이내로 입력해주세요!");
        }
		else{
			isValid.name = true;
			successMessage(name,"사용 가능합니다!");
		}
    });
	
	email.addEventListener("blur", function() {
        var emailValue = email.value.trim();
        var regex = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
        if(!regex.test(emailValue)){
        	isValid.email = false;
        	failMessage(email,"유효한 이메일 주소를 입력해주세요!");
        }
		else{
			isValid.email = true;
			successMessage(email,"사용 가능합니다!");
		}
    });
	
	
	function successMessage(field,message){
		var id = field.id + "msg";
		var textMessage = document.createElement("small");
		textMessage.id = id;
		textMessage.className = "text-success";
		textMessage.textContent = message;
		var existingMessage = document.getElementById(id);
		if(existingMessage){
			existingMessage.className = "text-success";
			existingMessage.textContent = message;
		}
		else{
			field.insertAdjacentElement('afterend', textMessage);				
		}
        field.classList.remove("is-invalid");
        field.classList.add("is-valid");
	}
	
	function failMessage(field,message){
		var id = field.id + "msg";
		var textMessage = document.createElement("small");
		textMessage.id = id;
		textMessage.className = "text-danger";
		textMessage.textContent = message;
		var existingMessage = document.getElementById(id);
		if(existingMessage){
			existingMessage.className = "text-danger";
			existingMessage.textContent = message;
		}
		else
			field.insertAdjacentElement('afterend', textMessage);
        field.classList.remove("is-valid");
        field.classList.add("is-invalid");
	}
	
	form.addEventListener("submit",function(event){
		if(password.value.trim()==='' || password.value===null){
			alert('비밀번호를 입력해주세요');
			password.focus();
			event.preventDefault();
			return;
		}
		if(password_ck.value.trim()==='' || password_ck.value===null){
			alert('비밀번호 확인을 입력해주세요');
			password_ck.focus();
			event.preventDefault();
			return;
		}
		//이름
		var name = document.getElementById("name");
		if(name.value.trim()==='' || name.value===null){
			alert('이름을 입력해주세요');
			name.focus();
			event.preventDefault();
			return;
		}	
		//이메일
		var email = document.getElementById("email");
		if(email.value.trim()==='' || email.value===null){
			alert('이메일을 입력해주세요');
			email.focus();
			event.preventDefault();
			return;
		}	
		var gender = document.querySelectorAll("input[name='gender']");
		var isGenderCk = Array.from(gender).some(radio => radio.checked);
		if(!isGenderCk){
			alert('성별을 선택해주세요');
			event.preventDefault();
			return;
		}
		
		var education = document.getElementById("education");
		if(education.value.trim()==='' || education.value===null){
			alert('학력사항을 선택해주세요');
			event.preventDefault();
			return;
		}
		
		var inter = document.querySelectorAll('input[name="inters"]');
		var isInterCk = Array.from(inter).some(check => check.checked);
		if(!isInterCk){
			alert('관심사항을 1개이상 선택해주세요');
			event.preventDefault();
			return;
		}
		
		if(selfintroduce.value.trim()==='' || selfintroduce.value===null){
			alert('자기소개를 입력해주세요');
			selfintroduce.focus();
			event.preventDefault();
			return;
		}				
		
        var isValidResult = Object.entries(isValid).find(([field,result])=>result === false);
        if (isValidResult) {
        	alert('일치하지 않는 항목이 있습니다.');
            event.preventDefault();  
        	document.getElementById(isValidResult[0]).focus();
            return;
        }
	});
	
});

</script>



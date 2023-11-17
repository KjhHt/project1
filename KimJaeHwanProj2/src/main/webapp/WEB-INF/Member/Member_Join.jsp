<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
<form action="#" method="post" id="joinForm">
  <fieldset>
    <legend>회원가입</legend>
    <div class="form-group">
      <label for="exampleInputEmail1">아이디</label>
      <input type="text" class="form-control" id="username" name="username" placeholder="아이디를 입력하세요">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="password" name="password" placeholder="Password">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="password_ck" name="password_ck" placeholder="Password">
    </div>
        <div class="form-group">
      <label for="exampleInputEmail1">이메일</label>
      <input type="text" class="form-control" id="email" name="email" placeholder="이메일을 입력하세요">
    </div>
    <fieldset class="form-group">
      <legend>성별</legend>
      <div class="form-check">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" id="gender1" value="M">
          남자
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" id="gender2" value="F">
 		  여자
        </label>
      </div>
    </fieldset>
    <fieldset class="form-group">
      <legend>학력</legend>
      <select class="form-control" id="education" name="education">
        <option value="" selected>선택 필수</option>
        <option value="1">초등학교</option>
        <option value="2">중학교</option>
        <option value="3">고등학교</option>
        <option value="4">대학교</option>
        <option value="5">대학원</option>
      </select>
    </fieldset>
    <div class="form-group">
    <fieldset class="form-group">
      <legend>관심사항</legend>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" id="inters1" name="inters" value="1" >
          정치
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" id="inters2" name="inters" value="2" >
          경제
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" id="inters3" name="inters" value="3" >
          연예
        </label>
      </div>
    </fieldset>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">자기소개</label>
      <textarea class="form-control" id="selfintroduce" rows="10" name="selfintroduce" placeholder="자기소개를 입력하세요"></textarea>
    </div>
    <button type="submit" class="btn btn-primary">등록</button>
  </fieldset>
</form>
</div>
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>
<script>
	window.addEventListener("DOMContentLoaded", function() {
		var form = document.querySelector('#joinForm');
		var username = document.getElementById("username");
		var password = document.getElementById("password");
		var password_ck = document.getElementById("password_ck");
		var selfintroduce = document.getElementById("selfintroduce");
		var isValid = {};
		username.addEventListener("blur", function() {
	        var usernameValue = username.value.trim();
			var regex = /^[a-z0-9_-]{5,20}$/;
			if(!regex.test(usernameValue)){
				isValid.username = false;
				failMessage(username,"아이디는 5~20자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
			}
			else{
				axios.post('<c:url value="/checkUsername.kjh"/>',{ data : usernameValue })
				.then(function(response){
					if(response.data){
						isValid.username = false;
						failMessage(username,"이미 사용 중인 아이디입니다.");
					}
					else{
						isValid.username = true;
						successMessage(username,"사용 가능합니다!");
					}
				})
			}
	    });
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
			if(username.value.trim()==='' || username.value===null){
				alert('아이디를 입력해주세요');
				username.focus();
				event.preventDefault();
				return;
			}	
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





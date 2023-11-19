<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
<form action="<c:url value="/Board/EditMember.kjh"/>" method="post">
  <fieldset>
    <legend>회원정보 수정</legend>
    <div class="form-group">
      <label for="exampleInputEmail1">아이디</label>
      <input type="text" class="form-control" id="" name="username" value="${memberDto.username}">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="" name="password" value="${memberDto.password}">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="" name="password_ck" placeholder="Password">
    </div>
    <div class="form-group">
      <label for="exampleInputEmail1">이름</label>
      <input type="text" class="form-control" id="" name="name" value="${memberDto.name}">
    </div>
    <div class="form-group">
      <label for="exampleInputEmail1">이메일</label>
      <input type="text" class="form-control" id="" name="email" value="${memberDto.email}">
    </div>
    <fieldset class="form-group">
      <legend>성별</legend>
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
    <c:set var="education" value="${memberDto.education}"/>
    <div class="form-group">
      <label for="exampleSelect2">학력</label>
      <select class="form-control" id="" name="education" >
        <option>선택 필수</option>
        <option value="1" ${memberDto.education eq '1' ? 'selected' : ''}>초등학교</option>
        <option value="2" ${memberDto.education eq '2' ? 'selected' : ''}>중학교</option>
        <option value="3" ${memberDto.education eq '3' ? 'selected' : ''}>고등학교</option>
        <option value="4" ${memberDto.education eq '4' ? 'selected' : ''}>대학교</option>
        <option value="5" ${memberDto.education eq '5' ? 'selected' : ''}>대학원</option>
      </select>
    </div>
    
    
    <c:set var="inter" value="${memberDto.inters}"/>
    <div class="form-group">
    <fieldset class="form-group">
      <legend>관심사항</legend>
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
    <div class="form-group">
      <label for="exampleTextarea">자기소개</label>
      <textarea class="form-control" id="exampleTextarea" rows="10" name="selfintroduce" >${memberDto.selfintroduce}</textarea>
    </div>

    <button type="submit" class="btn btn-primary">수정</button>
    <a href="<c:url value="/Board/DelMember.kjh"/>" class="btn btn-primary">회원탈퇴</a>
  </fieldset>
</form>
</div>
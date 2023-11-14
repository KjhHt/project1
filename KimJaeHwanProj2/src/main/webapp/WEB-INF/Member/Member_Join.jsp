<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
<form action="#" method="post">
  <fieldset>
    <legend>회원가입</legend>
    <div class="form-group">
      <label for="exampleInputEmail1">아이디</label>
      <input type="text" class="form-control" id="" name="username" placeholder="아이디를 입력하세요">
      <small id="" class="">아이디 정규표현식</small>
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="" name="password" placeholder="Password">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="" name="password_ck" placeholder="Password">
    </div>
    <fieldset class="form-group">
      <legend>성별</legend>
      <div class="form-check">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" id="optionsRadios1" value="M" checked="">
          남자
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input type="radio" class="form-check-input" name="gender" id="optionsRadios2" value="F">
 		  여자
        </label>
      </div>
    </fieldset>
    <div class="form-group">
      <label for="exampleSelect2">학력</label>
      <select class="form-control" id="" name="education">
        <option>선택 필수</option>
        <option value="1">초등학교</option>
        <option value="2">중학교</option>
        <option value="3">고등학교</option>
        <option value="4">대학교</option>
        <option value="5">대학원</option>
      </select>
    </div>
    <div class="form-group">
    <fieldset class="form-group">
      <legend>관심사항</legend>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" name="inters" value="1" >
          정치
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" name="inters" value="2" >
          경제
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" name="inters" value="3" >
          연예
        </label>
      </div>
    </fieldset>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">자기소개</label>
      <textarea class="form-control" id="exampleTextarea" rows="10" name="selfintroduce" placeholder="자기소개를 입력하세요"></textarea>
    </div>

    <button type="submit" class="btn btn-primary">등록</button>
  </fieldset>
</form>
</div>
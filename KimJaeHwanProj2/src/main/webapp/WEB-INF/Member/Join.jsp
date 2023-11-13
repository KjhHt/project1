<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/template/HeadNav.jsp"/>

<div class="jumbotron">
<form>
  <fieldset>
    <legend>회원가입</legend>
    <div class="form-group">
      <label for="exampleInputEmail1">아이디</label>
      <input type="text" class="form-control" id="" placeholder="아이디를 입력하세요">
      <small id="" class="">아이디 정규표현식</small>
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호</label>
      <input type="password" class="form-control" id="" placeholder="Password">
    </div>
    <div class="form-group">
      <label for="exampleInputPassword1">비밀번호 확인</label>
      <input type="password" class="form-control" id="" placeholder="Password">
    </div>
    <div class="form-group">
      <label for="exampleInputEmail1">나이</label>
      <input type="text" class="form-control" id="" placeholder="나이를 입력하세요">
      <small id="" class="">나이제한</small>
    </div>
    <div class="form-group">
      <label for="exampleSelect1">성별</label>
      <select class="form-control" id="">
        <option>선택 필수</option>
        <option>남자</option>
        <option>여자</option>
      </select>
    </div>
    <div class="form-group">
    <fieldset class="form-group">
      <legend>관심사항</legend>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" value="" checked="">
          정치
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" value="" checked="">
          경제
        </label>
      </div>
      <div class="form-check">
        <label class="form-check-label">
          <input class="form-check-input" type="checkbox" value="" checked="">
          연예
        </label>
      </div>
    </fieldset>
    </div>
    <div class="form-group">
      <label for="exampleTextarea">자기소개</label>
      <textarea class="form-control" id="exampleTextarea" rows="10"></textarea>
    </div>

    <button type="submit" class="btn btn-primary">등록</button>
  </fieldset>
</form>
</div>
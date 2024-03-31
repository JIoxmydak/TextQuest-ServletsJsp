<%@ page import="com.textquest.Stage" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
  <title>TextQuest</title>
  <script src="<c:url value="/static/jquery-3.6.0.min.js"/>"></script>
</head>
<body>

<c:set var="FIRST_STAGE" value="<%=Stage.FIRST%>"/>
<c:set var="SECOND_STAGE" value="<%=Stage.SECOND%>"/>
<c:set var="THIRD_STAGE" value="<%=Stage.THIRD%>"/>
<c:set var="FOURTH_STAGE" value="<%=Stage.FOURTH%>"/>

<c:if test="${stage == null}">
  <h1>Пролог</h1>
  <hr>
  <p>Ты стоишь в космическом порту и готов подняться на борт</p>
  <p>своего корабля. Разве ты не об это мечтал? Стать капитаном</p>
  <p>галактического судна с экипажем, который будет совершать</p>
  <p>подвиги под твоим командованием.</p>
  <p>Так что вперед!</p>
  <hr>
  <h1>Знакомство с экипажем</h1>
  <p>Когда ты поднялся на борт корабля, тебя поприветствовала девушка с черной палкой в руках:</p>
  <p>- Здравствуйте, командир! Я Зинаида - ваша помощницаю. Видите? Там в углу пьет кофе</p>
  <p>наш штурман - сержант Перегарный Шлейф, под штурвалом спит наш бортмеханик - Чёрный Богдан,</p>
  <p>а фотографирует его Сергей Стальная Пятка - наш навигатор.</p>
  <p>А как обращаться к вам?</p>
</c:if>

<c:if test="${stage == FIRST_STAGE}">
  <p>Ты потерял память. Принять вызов НЛО?</p>
</c:if>

<c:if test="${stage == SECOND_STAGE && defeat == false}">
  <p>Ты принял вызов. Поднимешься на мостик к капитану?</p>
</c:if>

<c:if test="${stage == SECOND_STAGE && defeat == true}">
  <p>Ты отклонил вызов. <br><b>Поражение</b></p>
</c:if>

<c:if test="${stage == THIRD_STAGE && defeat == false}">
  <p>Ты поднялся на мостик. Ты кто?</p>
</c:if>

<c:if test="${stage == THIRD_STAGE && defeat == true}">
  <p>Ты не пошел на переговоры. <br><b>Поражение</b></p>
</c:if>

<c:if test="${stage == FOURTH_STAGE && victory == true}">
  <p>Тебя вернули домой. <br><b>Победа</b></p>
</c:if>

<c:if test="${stage == FOURTH_STAGE && defeat == true}">
  <p>Твою ложь разоблачили. <br><b>Поражение</b></p>
</c:if>

<div id="options-container">
  <form id="options-form">
    <c:if test="${victory == true || defeat == true}">
      <button type="button" class="restart-button" onclick="restart()">Начать сначала</button>
    </c:if>

    <c:if test="${stage == null}">
      <input type="text" name="userName"> <button type="button" class="button" onclick="startQuest()">Представиться</button>
    </c:if>

    <c:if test="${stage == FIRST_STAGE}">
      <button type="button" class="button" onclick="selectOption('positiveAnswer1')">Принять вызов</button>
      <button type="button" class="button" onclick="selectOption('negativeAnswer1')">Отклонить вызов</button>
    </c:if>

    <c:if test="${stage == SECOND_STAGE && defeat == false}">
      <button type="button" class="button" onclick="selectOption('positiveAnswer2')">Подняться на мостик</button>
      <button type="button" class="button" onclick="selectOption('negativeAnswer2')">Отказаться подниматься на мостик</button>
    </c:if>

    <c:if test="${stage == THIRD_STAGE && defeat == false}">
      <button type="button" class="button" onclick="selectOption('positiveAnswer3')">Рассказать правду о себе</button>
      <button type="button" class="button" onclick="selectOption('negativeAnswer3')">Солгать о себе</button>
    </c:if>
  </form>
</div>

<c:if test="${stage != null}">
  <div>
    <br>
    <br>
    <br>
    <p>IP address: <%=session.getAttribute("IPaddress")%></p>
  </div>
</c:if>

<script>
  function restart() {
    $.ajax({
      url: '/restart',
      type: 'POST',
      async: false,
      success: function () {
        location.reload();
      }
    });
  }

  function selectOption(action) {
    $.ajax({
      type: 'POST',
      url: 'quest',
      data: { action: action },
      success: function() {
        location.reload();
      }
    });
  }

  function startQuest() {
    $.ajax({
      type: 'GET',
      url: 'quest',
      success: function() {
        location.reload();
      }
    });
  }
</script>

</body>
</html>
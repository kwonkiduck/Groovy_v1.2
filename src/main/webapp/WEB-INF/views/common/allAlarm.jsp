<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
  .alarmBox {
    width: 450px;
    border: 1px solid lightgray;
    border-radius: 12px;
    position: relative;
  }

  .aTag {
    display: block;
    padding: 10px;
    text-decoration: none;
    color: #333;
  }

  .readBtn {
    position: absolute;
    top: 0;
    right: 0;
  }
</style>
<div class="alarmWrapper">
  <div class="alarmContainer">

  </div>
</div>

<script>
  getList();

  var socket = null;
  $(document).ready(function() {
    connectWs();
  });

  function connectWs() {
    // 웹소켓 연결
    sock = new SockJS("<c:url value='/echo-ws'/>");
    socket = sock;

    sock.onopen = function () {
      console.log("info: connection opened");
    };

    sock.onmessage = function(event) {
      console.log(event.data);
      getList();
    }

    sock.onclose = function () {
      console.log("close");
    }

    sock.onerror = function (err) {
      console.log("ERROR: ", err);
    }
  }
document.querySelector(".alarmContainer").addEventListener("click",(e)=>{
   const target = e.target;
   if(target.classList.contains("readBtn")){
     var ntcnSn = target.previousElementSibling.getAttribute("data-seq");
     $.ajax({
       type: 'delete',
       url: '/alarm/deleteAlarm?ntcnSn=' + ntcnSn,
       success: function () {
         target.parentElement.remove();
       },
       error: function (xhr) {
         xhr.status;
       }
     });

   }
})
function getList() {
  $.ajax({
    type: 'get',
    url: '/alarm/getAllAlarm',
    dataType: 'json',
    success: function (list) {
      console.log(list);
      $(".alarmContainer").empty();
      for (let i = 0; i < list.length; i++) {
        $(".alarmContainer").append(list[i].ntcnCn);
      }
    }
  });
}
</script>


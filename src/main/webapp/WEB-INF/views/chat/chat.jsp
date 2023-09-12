<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<sec:authentication property="principal" var="CustomUser"/>

<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.4.0/sockjs.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>

<style>
    div {
        border : 1px solid black;
    }

    .rooms {
        cursor: pointer;
    }

    .myroom {
        overflow-y:auto;
        height:300px;
    }

</style>
<hr>
<h1>채팅방 개설</h1>
<div>
    <ul id="employeeList">

    </ul>
    <button type="button" id="createRoomBtn">채팅방 생성</button>
</div>

<hr>

<h1>채팅방 목록</h1>
<div id="chatRoomList">

</div>

<hr>

<h1>채팅창</h1>
<div id="chatRoom">
    <div id="msgArea">

    </div>
    <input type="text" id="msg">
    <button type="button" id="sendBtn">전송</button>
</div>

<script>

    const emplId = ${CustomUser.employeeVO.emplId};
    const emplNm = "${CustomUser.employeeVO.emplNm}";
    const msg = $("#msg");
    const chatRoomMessages = {};

    let sockJS = new SockJS("/chat");
    let client = Stomp.over(sockJS);

    let currentSubRoom;
    let currentRoomNo;

    function connectToStomp() {
        return new Promise(function(res, rej) {
            client.connect({}, function() {
                res();
            });
        });
    }

    connectToStomp().then(function() {
        $("#msg").on("keyup", function(event) {
            if (event.keyCode === 13) {
                sendMessage();
            }
        });

        $("#sendBtn").on("click", function(){
            sendMessage();
        });

        function sendMessage() {
            let message = msg.val();
            let date = new Date();

            if(message.length == 0) return;

            let chatVO = {
                chttNo : 0,
                chttRoomNo : chttRoomNo,
                chttMbrEmplId : emplId,
                chttMbrEmplNm : emplNm,
                chttCn : message,
                chttInputDate : date
            }
            client.send('/public/chat/message', {}, JSON.stringify(chatVO));

            $.ajax({
                url: "/chat/inputMessage",
                type: "post",
                data: JSON.stringify(chatVO),
                contentType: "application/json;charset:utf-8",
                success: function (result) {

                },
                error: function (request, status, error) {
                    alert("채팅 전송 실패")
                }
            })
            msg.val('');
        }

        function enterRoom(currentRoomNo) {
            $("#msgArea").html('');
            $("#msgArea").html(`<div class="myroom" id="room\${currentRoomNo}" style="border: 2px solid green"></div>`)

            $.ajax({
                url: `/chat/loadRoomMessages/\${currentRoomNo}`,
                type: "get",
                dataType: "json",
                success: function (messages) {
                    $.each(messages, function (idx, obj) {
                        if(obj.chttMbrEmplId == emplId) {
                            var code = `<div style='border: 1px solid blue' id='\${obj.chttNo}'>`;
                            code += "<div>";
                            code += `<p>\${obj.chttMbrEmplNm} : \${obj.chttCn}</p>`;
                            code += "</div></div>";
                            $(`#room\${currentRoomNo}`).append(code);
                        } else {
                            var code = `<div style='border: 1px solid red' id='\${obj.chttNo}'>`;
                            code += "<div>";
                            code += `<p>\${obj.chttMbrEmplNm} : \${obj.chttCn}</p>`;
                            code += "</div></div>";
                            $(`#room\${currentRoomNo}`).append(code);
                        }
                    });
                    scrollToBottom();
                },
                error: function (request, status, error) {
                    alert("채팅 로드 실패")
                }
            })
            msg.val('');
        }

        function scrollToBottom() {
            const scrollRoom = document.getElementById("room" + currentRoomNo);
            scrollRoom.scrollTop = scrollRoom.scrollHeight;
        }

        $("#chatRoomList").on("click", ".rooms", function() {
            let selectedRoom = $(this);
            chttRoomNo = selectedRoom.find("input").val();

            currentRoomNo = chttRoomNo;

            enterRoom(currentRoomNo);
        });

        function subscribeToChatRoom(chttRoomNo) {
            client.subscribe("/subscribe/chat/room/" + chttRoomNo, function (chat) {
                let content = JSON.parse(chat.body);

                let chttRoomNo = content.chttRoomNo;
                let chttMbrEmplId = content.chttMbrEmplId;
                let chttMbrEmplNm = content.chttMbrEmplNm;
                let chttCn = content.chttCn;
                let chttInputDate = content.chttInputDate;

                let code = "";
                if (chttMbrEmplId == emplId) {
                    code += "<div style='border: 1px solid blue'>";
                    code += "<div>";
                    code += "<p>" + chttMbrEmplNm + " : " + chttCn + "</p>";
                    code += "</div></div>";
                    $(`#room\${chttRoomNo}`).append(code);
                    scrollToBottom();
                } else {
                    code += "<div style='border: 1px solid red'>";
                    code += "<div>";
                    code += "<p>" + chttMbrEmplNm + " : " + chttCn + "</p>";
                    code += "</div></div>";
                    $(`#room\${chttRoomNo}`).append(code);
                    scrollToBottom();
                }

                updateLatestChttCn(chttRoomNo, chttCn, chttInputDate);
                updateChatRoomList(chttRoomNo, chttCn);
            });
        }

        function updateLatestChttCn(chttRoomNo, chttCn, chttInputDate) {
            for (let i = 0; i < chatRoomList.length; i++) {
                if (chatRoomList[i].chttRoomNo === chttRoomNo) {
                    chatRoomList[i].latestChttCn = chttCn;
                    chatRoomList[i].latestInputDate = chttInputDate;
                    break;
                }
            }
            renderChatRoomList();
        }

        function updateChatRoomList(chttRoomNo, latestChttCn) {
            let chatRoom = $("#chatRoomList" + chttRoomNo);
            chatRoom.find("#latestChttCn").text(latestChttCn);
        }

        var groupedEmployees = {};

        <c:forEach items="${empListForChat}" var="employee">
        var deptNm = "${employee.deptNm}";
        if (!groupedEmployees[deptNm]) {
            groupedEmployees[deptNm] = [];
        }
        groupedEmployees[deptNm].push({
            emplId: "${employee.emplId}",
            emplNm: "${employee.emplNm}",
            clsfNm: "${employee.clsfNm}"
        });
        </c:forEach>

        let ul = $("#employeeList");
        for (var deptNm in groupedEmployees) {
            let li = $("<li>").text(deptNm);
            ul.append(li);

            let ulSub = $("<ul>");
            groupedEmployees[deptNm].forEach(function(employee) {
                let liSub = $("<li>");
                let label = $("<label>");
                let input = $("<input>").attr({
                    type: "checkbox",
                    name: "selectedEmpls",
                    value: employee.emplId + "/" + employee.emplNm
                }).data("emplNm", employee.emplNm);
                label.append(input);
                label.append(document.createTextNode(employee.emplNm + " " + employee.clsfNm));
                liSub.append(label);
                ulSub.append(liSub);
            });
            li.append(ulSub);
        }

        $("#createRoomBtn").click(function () {
            let roomMemList = [];

            $("input[name='selectedEmpls']:checked").each(function () {
                let selectedEmpls = $(this).val()
                let splitResult = selectedEmpls.split("/");

                if (splitResult.length === 2) {
                    let emplId = splitResult[0];
                    let emplNm = splitResult[1];

                    let EmployeeVO = {
                        emplId: emplId,
                        emplNm: emplNm
                    };

                    roomMemList.push(EmployeeVO);
                }
            });

            $.ajax({
                url: "/chat/createRoom",
                type: "post",
                data: JSON.stringify(roomMemList),
                contentType: "application/json;charset:utf-8",
                success: function () {
                    loadRoomList();
                    alert("채팅방 개설 성공");
                },
                error: function (request, status, error) {
                    alert("채팅방 개설 실패")
                }
            });
        });

        loadRoomList();

        function loadRoomList() {
            $.ajax({
                url: "/chat/loadRooms",
                type: "get",
                dataType: "json",
                success: function (result) {
                    result.sort((a, b) => b.latestInputDate - a.latestInputDate);

                    chatRoomList = result;

                    if (currentSubRoom) {
                        currentSubRoom.unsubscribe();
                    }

                    for (let i = 0; i < chatRoomList.length; i++) {
                        const chttRoomNo = chatRoomList[i].chttRoomNo;
                        subscribeToChatRoom(chttRoomNo);
                    }

                    renderChatRoomList();
                },
                error: function (request, status, error) {
                    alert("채팅방 목록 로드 실패")
                }
            })
        }


        let chatRoomList = [];

        function renderChatRoomList() {
            $("#chatRoomList").html('');

            chatRoomList.forEach(room => room.latestInputDate = new Date(room.latestInputDate));
            chatRoomList.sort((a, b) => b.latestInputDate - a.latestInputDate);

            code = "";
            $.each(chatRoomList, function (idx, obj) {
                code += `<button class="rooms" id="chatRoom\${obj.chttRoomNo}">
            <img src="/uploads/profile/\${obj.chttRoomThumbnail}" alt="\${obj.chttRoomThumbnail}"/>
            <p>\${obj.chttRoomNm}</p>
            <p id="latestChttCn">\${obj.latestChttCn}</p>
            <input type="hidden" value="\${obj.chttRoomNo}">
            </button>`;
            });

            $("#chatRoomList").html(code);
        }

    });
</script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <style>
        #modal {
            width: 30%;
            display: none;
            flex-direction: column;
            align-items: flex-start;
            border: 1px solid red;
        }
        .modal-container{
            width: 100%;
            height: 100%;
        }
        .modal-header {
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .modal-body{
            display: flex;
            width: 100%;
        }
        .modal-footer {
            display: flex;
            justify-content: center;
        }
        .modal-footer > button {
            width: 40%;
            padding: 10px;
        }
        .modal-common {
            display: none;
        }
        .modal-common.on {
            display: block;
        }
        .modal-thum {
            height: 100px;
            border: 1px solid red;
        }
    </style>
    <h1>동호회</h1>
    <h2>그루비 사내 동호회를 소개합니다.&#x1F64C;</h2>
    <button id="proposalClb">동호회 제안하기</button>
    <div id="modal-proposal" style="display: none;">
        <h3>동호회 제안하기</h3>
        <form action="${pageContext.request.contextPath}/club/inputClub" method="post" id="proposal" >
            <table border="1">
                <tr>
                    <th>희망 동호회 종류</th>
                    <td><input type="text" name="clbKind" id="clbKind"></td>
                </tr>
                <tr>
                    <th>동호회 이름</th>
                    <td><input type="text" name="clbNm" id="clbNm"></td>
                </tr>
                <tr>
                    <th>동호회 설명</th>
                    <td>
                        <textarea name="clbDc" id="clbDc"></textarea>
                    </td>
                </tr>
                <tr>
                    <th>동호회 정원</th>
                    <td><input type="text" name="clbPsncpa" id="clbPsncpa"></td>
                </tr>
            </table>
            <button id="proposalBtn">제안하기</button>
        </form>
    </div>
    <br /><hr /><br />
    <h3>등록된 동호회 리스트 불러오기</h3>
    <div class="card-wrap">
        <c:forEach var="clubVO" items="${clubList}" varStatus="status">
            <div class="card">
                <a href="#" class="card-link" data-target="${clubVO.clbEtprCode}">
                    <div class="card-header">
                        <div class="card-thum"></div>
                    </div>
                    <div class="card-content">
                        <span class="badge">${clubVO.clbKind}</span>
                        <h2 class="club-name">${clubVO.clbNm}</h2>
                        <p class="club-dc">
                                ${clubVO.clbDc}
                        </p>
                    </div>
                </a>
            </div>
        </c:forEach>
    </div>
    <div id="modal">
        <div class="modal-container">
            <%--<div id="modal-proposal"></div>--%>
            <div id="modal-clubDetail" class="modal-common on">
                <div class="modal-header">
                    <h4 class="modal-title"></h4>
                    <button class="close">&times;</button>
                </div>
                <div class="modal-body">
                    <div class="modal-thum">

                    </div>
                    <div class="modal-content">
                        <span class="badge club-cate"></span>
                        <h2 class="club-name"></h2>
                        <p class="club-dc"></p>
                        <p class="club-charId"></p>
                    </div>
                </div>
                <div class="modal-footer">
                    <button id="chat">문의하기</button>
                    <button id="join">가입하기</button>
                    <button id="leave">탈퇴하기</button>
                </div>
            </div>
        </div>
    </div>
    <script>
        const form = document.querySelector("#proposal");
        const proposalBtn = document.querySelector("#proposalBtn");
        const modalLink = document.querySelectorAll(".card-link");
        const clubTitle = document.querySelector(".modal-title");
        const clubCate = document.querySelector("#modal .club-cate");
        const clubName = document.querySelector("#modal .club-name");
        const clubDc = document.querySelector("#modal .club-dc");
        const chatBtn = document.querySelector("#chat");
        const joinBtn = document.querySelector("#join");
        const leaveBtn = document.querySelector("#leave");
        const modal = document.querySelector("#modal");
        const textArea = document.querySelector("#clbDc");
        const clbNm = document.querySelector("#clbNm");
        let clbEtprCode;

        /* 이모지 처리   */
        function containsWindowsEmoji(text) {
            const windowsEmojiRegex = /[\uD800-\uDBFF][\uDC00-\uDFFF]/;
            return windowsEmojiRegex.test(text);
        }
        function convertImojiToUnicode(text) {
            let unicodeText = '';
            for (let i = 0; i < text.length; i++) {
                const char = text.charAt(i);
                const codePoint = text.charCodeAt(i);

                // Check if the character is an emoji (code points typically > 127)
                if (codePoint > 127) {
                    unicodeText += '\\u' + codePoint.toString(16).toUpperCase().padStart(4, '0');
                } else {
                    unicodeText += char;
                }
            }

            return unicodeText;
        }
        form.addEventListener("submit",e=>{
            e.preventDefault();
        })
        document.querySelector("#proposalClb").addEventListener("click",()=>{
            document.querySelector("#modal-proposal").style.display = "block";
        })
        proposalBtn.addEventListener("click",()=>{
            if(containsWindowsEmoji(textArea.value)||containsWindowsEmoji(clbNm.value)){
                textArea.value = convertImojiToUnicode(textArea.value);
                clbNm.value = convertImojiToUnicode(clbNm.value);
            }
            form.submit();
            return false;
        })
        const close = document.querySelectorAll(".close");
        close.forEach(item => {
            item.addEventListener("click",()=>{
                const modalCommon = document.querySelectorAll(".modal-common")
                modalCommon.forEach(item => item.classList.remove("on"))
                document.querySelector("#modal").style.display = "none";
            })
        })
        modalLink.forEach(item => {
            item.addEventListener("click",e=>{
                e.preventDefault();
                const target = e.target;
                clbEtprCode = item.getAttribute("data-target");
                $.ajax({
                    url: `/club/\${clbEtprCode}`,
                    type: "GET",
                    success: function (data) {
                        console.log(data);
                        clubTitle.innerText = data[0].clbNm;
                        clubName.innerText = data[0].clbNm;
                        clubDc.innerText = data[0].clbDc;
                        document.querySelector("#modal").style.display = "flex";
                        document.querySelector("#modal-clubDetail").classList.add("on");
                        if(data[0].joinChk == 1){
                            chatBtn.style.display = "none";
                            joinBtn.style.display = "none";
                            leaveBtn.style.display = "block";
                        }else {
                            chatBtn.style.display = "block";
                            joinBtn.style.display = "block";
                            leaveBtn.style.display = "none";
                        }
                    }
                })
            })
        })
        modal.addEventListener("click",(e)=>{
            const target = e.target;
            console.log(target);
            if(target.id == "join"){
                $.ajax({
                    url: "/club/inputClubMbr",
                    type: "POST",
                    data: JSON.stringify({clbEtprCode: clbEtprCode}),
                    contentType: 'application/json',
                    success: function (data) {
                        console.log(data);
                        chatBtn.style.display = "none";
                        joinBtn.style.display = "none";
                        leaveBtn.style.display = "block";
                    },
                    error: function (request, status, error) {
                        console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    }
                })
                return false;
            }
            if(target.id == "leave"){
                console.log(clbEtprCode);
                $.ajax({
                    url: "/club/deleteClubMbr",
                    type: "DELETE",
                    data: JSON.stringify({clbEtprCode: clbEtprCode}),
                    contentType: 'application/json',
                    success: function (data) {
                        console.log(data);
                        chatBtn.style.display = "block";
                        joinBtn.style.display = "block";
                        leaveBtn.style.display = "none";
                    },
                    error: function (request, status, error) {
                        console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    }
                })
                return false;
            }
        })
    </script>
</body>
</html>
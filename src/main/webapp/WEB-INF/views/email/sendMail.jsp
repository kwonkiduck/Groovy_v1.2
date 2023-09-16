<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <div class="contentWrap">
        <form action="#" method="post" id="mailForm">
            <table border="1" style="width: 50%">
                <tr>
                    <th>받는 사람</th>
                    <td>
                        <span id="receiveTo"></span>
                        <input type="text" name="emailToAddr" id="emailToAddr">
                        <button type="button" id="orgBtnTo">조직도</button>

                    </td>
                </tr>
                <tr>
                    <th>참조</th>
                    <td>
                        <span id="receiveCc"></span>
                        <input type="text" name="emailCcAddr" id="emailCcAddr">
                        <button type="button" id="orgBtnCc">조직도</button>
                    </td>
                </tr>
                <tr>
                    <th>제목</th>
                    <td>
                        <input type="text" name="emailFromSj" id="emailFromSj">
                    </td>
                </tr>
                <tr>
                    <th>파일첨부</th>
                    <td>
                        <input type="file" name="file" id="file" multiple>
                    </td>
                </tr>
                <tr>
                    <th>내용</th>
                    <td>
                        <textarea id="editor" name="emailFromCn" required></textarea>
                    </td>
                </tr>
            </table>
            <div class="serviceWrap">
                <div class="serviceWrap">
                    <div class="writeWrap">
                        <button type="button" id="sendBtn">보내기</button>
                        <button type="button" id="saveBtn">임시저장</button>
                        <button type="button" id="resveBtn">예약</button>
                    </div>
                </div>
            </div>
        </form>
    </div>
</sec:authorize>
<script src="${pageContext.request.contextPath}/resources/ckeditor/ckeditor.js"></script>
<script>
    let editor = CKEDITOR.replace("editor", {
        extraPlugins: 'notification'
    });

    //조직도 팝업
    let orgBtnTo = document.querySelector("#orgBtnTo");
    let orgBtnCc = document.querySelector("#orgBtnCc");

    let receiveTo = document.querySelector("#receiveTo");
    let receiveCc = document.querySelector("#receiveCc");

    let emailToAddrInput = document.querySelector("#emailToAddr");
    let emailCcAddrInput = document.querySelector("#emailCcAddr");

    const mailForm = document.querySelector("#mailForm");
    console.log(mailForm);
    getOrgChart(orgBtnTo, receiveTo);
    getOrgChart(orgBtnCc, receiveCc);

    addEmailAddrSpan(emailToAddrInput, receiveTo);
    addEmailAddrSpan(emailCcAddrInput, receiveCc);

    document.querySelector("#sendBtn").addEventListener("click", function () {
        let emplIdToArr = document.querySelectorAll("input[name=emplIdToArr]");
        let emplIdTo = [];
        emplIdToArr.forEach((emplId) => {
            emplIdTo.push(emplId.value);
        });
        let emplIdCcArr = document.querySelectorAll("input[name=emplIdCcArr]");
        let emplIdCc = [];
        emplIdCcArr.forEach((emplId) => {
            emplIdCc.push(emplId.value);
        });
        let emailToAddrArr = document.querySelectorAll("input[name=emailToAddrArr]");
        let emailToAddr = [];
        emailToAddrArr.forEach((emailAddr) => {
            emailToAddr.push(emailAddr.value);
        });
        let emailCcAddrArr = document.querySelectorAll("input[name=emailCcAddrArr]");
        let emailCcAddr = [];
        emailCcAddrArr.forEach((emailAddr) => {
            emailCcAddr.push(emailAddr.value);
        });

        let request = {
            emplIdToList: emplIdTo,
            emplIdCcList: emplIdCc,
            emailToAddrList: emailToAddr,
            emailCcAddrList: emailCcAddr,
            emailFromSj: document.querySelector("input[name=emailFromSj]").value,
            emailFromCn: CKEDITOR.instances.editor.getData(),
            emailFromAddr: "${CustomUser.employeeVO.emplEmail}",
            emailFromTmprStreAt: 'N',
            emailFromSendDate: new Date(),


        }

        if (request.emplIdToList || request.emplIdCcList || request.emailCcAddrList || request.emailToAddrList) {
            let xhr = new XMLHttpRequest();
            xhr.open("post", "/email/write", true);
            xhr.setRequestHeader("Content-Type", "application/json");
            xhr.onreadystatechange = function () {
                if (xhr.readyState == 4 && xhr.status == 200) {
                    console.log(xhr.responseText);
                }
            }
            xhr.send(JSON.stringify(request));
        }
    });

    document.addEventListener("click", function (event) {
        if (event.target && event.target.classList.contains("close-empl")) {
            let spanToRemove = event.target.closest("span");
            if (spanToRemove) {
                spanToRemove.remove(); // 해당 span 태그 삭제
            }
        }
    });

    function addEmailAddrSpan(emailAddr, receive) {
        emailAddr.addEventListener('keyup', function (event) {
            if (event.key === 'Enter') {
                const value = emailAddr.value;
                let str = "";
                if (value) {
                    let newSpan = document.createElement('span');
                    newSpan.textContent = value + " ";

                    let newButton = document.createElement("button");
                    newButton.setAttribute("type", "button");
                    newButton.setAttribute("class", "close-empl");
                    newButton.textContent = "X";

                    let newInput = document.createElement("input");
                    newInput.setAttribute("type", "hidden");
                    if (emailAddr.getAttribute("id") === "emailToAddr") {
                        newInput.setAttribute("name", "emailToAddrArr");
                    } else if (emailAddr.getAttribute("id") === "emailCcAddr") {
                        newInput.setAttribute("name", "emailCcAddrArr");
                    }
                    newInput.setAttribute("value", value);

                    receive.appendChild(newSpan);
                    newSpan.appendChild(newButton);
                    newSpan.appendChild(newInput);
                    emailAddr.value = ''; // 입력 필드를 비움
                }
            }
        });
    }

    function getOrgChart(orgBtn, receive) {
        orgBtn.addEventListener("click", () => {
            fetch("/job/jobOrgChart")
                .then((response) => response.text())
                .then((data) => {
                    let popup = window.open("", "_blank", "width=800,height=600");

                    popup.document.write(data);

                    popup.document.querySelector("#orgCheck").addEventListener("click", () => {
                        const checkboxes = popup.document.querySelectorAll("input[name=orgCheckbox]");
                        let str = ``;
                        checkboxes.forEach((checkbox) => {
                            if (checkbox.checked) {
                                const label = checkbox.closest("label");
                                const emplId = checkbox.id;
                                const emplNm = label.querySelector("span").innerText;

                                let empl = {
                                    emplId,
                                    emplNm
                                }
                                if (orgBtn.getAttribute("id") === "orgBtnTo") {
                                    str += `<span data-id=\${empl.emplId}>
                                            \${empl.emplNm}
                                            <button type="button" class="close-empl">X</button>
                                        </span>
                                            <input type="hidden" name="emplIdToArr" value="\${empl.emplId}">`;
                                } else if (orgBtn.getAttribute("id") === "orgBtnCc") {
                                    str += `<span data-id=\${empl.emplId}>
                                            \${empl.emplNm}
                                            <button type="button" class="close-empl">X</button>
                                            <input type="hidden" name="emplIdCcArr" value="\${empl.emplId}">
                                        </span>`;
                                }

                            }
                        });
                        receive.insertAdjacentHTML("afterend", str);
                    });

                    popup.document.querySelector("#orgCheck").addEventListener("click", () => {
                        popup.close();
                    });
                })
                .catch((error) => {
                    console.error("데이터 가져오기 실패:", error);
                });
        });
    }


</script>
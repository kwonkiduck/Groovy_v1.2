<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <script src="https://cdn.jsdelivr.net/npm/ag-grid-community/dist/ag-grid-community.min.js"></script>
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>
<body>
<h1>사원 관리</h1>
<h2>사원정보</h2>
<!--    사원 추가 모달   -->
<div id="empDetail">
    <form action="#" method="post" id="modifyEmpForm">
        <!-- seoju : csrf 토큰 추가-->
        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
        <%--        <input type="hidden" name="enabled" value="1"/>--%>
        <label>사원번호</label>
        <input type="text" name="emplId" id="emplId" value="${empVO.emplId}" required readonly>

        <label>비밀번호</label>
        <input type="password" name="emplPassword" value="${empVO.emplPassword}" required readonly><br/>

        <label>이름</label>
        <input type="text" name="emplNm" value="${empVO.emplNm}" required readonly><br/>

        <label>휴대폰 번호</label>
        <input type="text" name="emplTelno" value="${empVO.emplTelno}" required readonly><br/>

        <label>우편번호</label>
        <input type="text" name="emplZip" class="emplZip" value="${empVO.emplZip}" required readonly><br/>
        <button type="button" id="findZip" hidden="hidden">우편번호 찾기</button>
        <label>주소</label>
        <input type="text" name="emplAdres" class="emplAdres" value="${empVO.emplAdres}" required readonly><br/>
        <label>상세주소</label>
        <input type="text" name="emplDetailAdres" class="emplDetailAdres" value="${empVO.emplDetailAdres}" required
               readonly><br/>

        <label>생년월일</label>
        <input type="date" name="#" value="${empVO.emplBrthdy}" required readonly><br/>


        <%-- commonCodeLastAcdmcr --%>
        <label>최종학력</label>
        <input type="radio" name="commonCodeLastAcdmcr" id="empEdu1"
               value="LAST_ACDMCR010" ${empVO.commonCodeLastAcdmcr == 'LAST_ACDMCR010' ? 'checked' : ''}>
        <label for="empEdu1">고졸</label>
        <input type="radio" name="commonCodeLastAcdmcr" id="empEdu2"
               value="LAST_ACDMCR011" ${empVO.commonCodeLastAcdmcr == 'LAST_ACDMCR011' ? 'checked' : ''}>
        <label for="empEdu2">학사</label>
        <input type="radio" name="commonCodeLastAcdmcr" id="empEdu3"
               value="LAST_ACDMCR012" ${empVO.commonCodeLastAcdmcr == 'LAST_ACDMCR012' ? 'checked' : ''}>
        <label for="empEdu3">석사</label>
        <input type="radio" name="commonCodeLastAcdmcr" id="empEdu4"
               value="LAST_ACDMCR013" ${empVO.commonCodeLastAcdmcr == 'LAST_ACDMCR013' ? 'checked' : ''}>
        <label for="empEdu4">박사</label><br/>

        <%-- commonCodeClsf --%>
        <label>직급</label>
        <input type="radio" name="commonCodeClsf" id="empPos1"
               value="CLSF016" ${empVO.commonCodeClsf == 'CLSF016' ? 'checked' : ''}>
        <label for="empPos1">사원</label>
        <input type="radio" name="commonCodeClsf" id="empPos2"
               value="CLSF015" ${empVO.commonCodeClsf == 'CLSF015' ? 'checked' : ''}>
        <label for="empPos2">대리</label>
        <input type="radio" name="commonCodeClsf" id="empPos3"
               value="CLSF014" ${empVO.commonCodeClsf == 'CLSF014' ? 'checked' : ''}>
        <label for="empPos3">과장</label>
        <input type="radio" name="commonCodeClsf" id="empPos4"
               value="CLSF013" ${empVO.commonCodeClsf == 'CLSF013' ? 'checked' : ''}>
        <label for="empPos4">차장</label>
        <input type="radio" name="commonCodeClsf" id="empPos5"
               value="CLSF012" ${empVO.commonCodeClsf == 'CLSF012' ? 'checked' : ''}>
        <label for="empPos5">팀장</label>
        <input type="radio" name="commonCodeClsf" id="empPos6"
               value="CLSF011" ${empVO.commonCodeClsf == 'CLSF011' ? 'checked' : ''}>
        <label for="empPos6">부장</label>
        <input type="radio" name="commonCodeClsf" id="empPos7"
               value="CLSF010" ${empVO.commonCodeClsf == 'CLSF010' ? 'checked' : ''}>
        <label for="empPos7">대표이사</label>


        <%-- commonCodeDept --%>
        <%--        <c:if test="${data.condition=='신규도서'}">checked</c:if>--%>
        <label>부서</label>
        <select name="commonCodeDept" id="emp-department">
            <option value="DEPT010" ${empVO.commonCodeDept == 'DEPT010' ? 'selected' : ''}>인사팀</option>
            <option value="DEPT011" ${empVO.commonCodeDept == 'DEPT011' ? 'selected' : ''}>회계팀</option>
            <option value="DEPT012" ${empVO.commonCodeDept == 'DEPT012' ? 'selected' : ''}>영업팀</option>
            <option value="DEPT013" ${empVO.commonCodeDept == 'DEPT013' ? 'selected' : ''}>홍보팀</option>
            <option value="DEPT014" ${empVO.commonCodeDept == 'DEPT014' ? 'selected' : ''}>총무팀</option>
            <option value="DEPT015" ${empVO.commonCodeDept == 'DEPT015' ? 'selected' : ''}>관리직</option>
        </select><br/>

        <label>입사일</label>
        <input type="date" name="#" id="joinDate" value="${empVO.emplEncpn}" required readonly><br/>


        <label>이메일</label>
        <input type="email" name="#" id="emplEmail" value="${empVO.emplEmail}" required readonly><br/>

        <label>재직 상태 설정</label>
        <input type="radio" name="commonCodeHffcSttus" id="office"
               value="HFFC010" ${empVO.commonCodeHffcSttus == 'HFFC010' ? 'checked' : ''}>
        <label for="office">재직</label>
        <input type="radio" name="commonCodeHffcSttus" id="leave"
               value="HFFC011" ${empVO.commonCodeHffcSttus == 'HFFC011' ? 'checked' : ''}>
        <label for="leave">휴직</label>
        <input type="radio" name="commonCodeHffcSttus" id="quit"
               value="HFFC012" ${empVO.commonCodeHffcSttus == 'HFFC012' ? 'checked' : ''}>
        <label for="quit">퇴사</label>
        <br/><br/>
        <button type="button" id="btn-modify">수정</button>
        <button type="button" id="btn-save" hidden="hidden">저장</button>
        <button type="button" id="btn-list" disabled>목록</button>
    </form>

</div>


<script>
<%--    모든 요소 (사번/입사일/이메일)제외 선택하면 val("") 처리--%>
    $("#btn-save").on("click", function () {
        var formData = new FormData($("#modifyEmpForm")[0]);
        $.ajax({
            type: "POST",
            url: "/employee/modifyEmp",
            data: formData,
            contentType: false, // 필수
            processData: false, // 필수
            success: function (response) {
                console.log("서버 응답:", response);
                alert("사원 정보 수정 성공")
            },
            error: function (xhr, textStatus, error) {
                // 오류 발생 시 처리
                console.log("AJAX 오류:", error);
            }
        });
    })

    $("#btn-modify").on("click", function () {
        // 우편번호 찾기 버튼 활성화
        $("#findZip").prop("hidden", false)
        // 모든 인풋 요소 readonly 속성 제거
        let inputElements = $("#empDetail form input");

        inputElements.each(function () {
            $(this).removeAttr("readonly");
        });

        // 저장(submit)버튼 활성화
        let saveBtn = $("#btn-save").removeAttr("hidden");

        //수정 버튼 숨김
        $(this).hide();
    })

    // 다음 주소 API
    $("#findZip").on("click", function () {
        new daum.Postcode({
            oncomplete: function (data) {
                $(".emplZip").val(data.zonecode);
                $(".emplAdres").val(data.address);
                $(".emplDetailAdres").val("")
                $(".emplDetailAdres").focus();
            }
        }).open();
    })
</script>
</body>
</html>

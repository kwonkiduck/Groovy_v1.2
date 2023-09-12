<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser" />

    <style>
        table, td, tr, th {
            border: 1px solid #333;
        }
        #progress-container {
            width: 100%;
            background-color: #DDDDDD;
        }

        #progress-bar {
            width: 0;
            height: 30px;
            line-height: 30px;
            background-color: #5796F3;
            text-align: center;
        }
    </style>
    <h1>수정수정 - 8</h1>
    <h1>${CustomUser.employeeVO.emplId}</h1>
    <h1>${commuteVO}</h1>
    <div>
        <button type="button" id="goBtn">출근 <span id="attend">00:00</span></button>
    </div>
    <div>
        <button type="button" id="leaveBtn">퇴근 <span id="leave">00:00</span></button>
    </div>
    <div>
        <p>오늘 근무 시간</p>
        <p id="todayTime">00시간 00분</p>
    </div>
    <div>
        <p>이번주 총 근무 시간</p>
        <p id="weeklyTotal">00시간 00분</p>
    </div>

    <div id="progress-container">
        <div id="progress-bar"></div>
    </div>

    <div>
        <p>주간 출 • 퇴근 시간 확인</p>
        <table border="1">
            <tr>
                <th>월</th>
                <th>화</th>
                <th>수</th>
                <th>목</th>
                <th>금</th>
            </tr>
            <tr id="weeklyAttendTime"></tr>
            <tr id="weeklyLeaveTime"></tr>
        </table>
    </div>

    <div>
        <p>근태 현황</p>
        <select name="sortOptions" id="yearSelect" class="stroke"></select>
        <div id="monthDiv"></div>
    </div>

    <div class="modal">
        <div>
            <p>근태 현황</p>
            <i></i>
        </div>

        <div id="commuteTable"></div>
        <button type="button">확인</button>
    </div>


    <script>
        let dclzEmplId = `${CustomUser.employeeVO.emplId}`;
        let goBtn = document.querySelector("#goBtn");
        let leaveBtn = document.querySelector("#leaveBtn");
        let attend = document.querySelector("#attend");
        let leave = document.querySelector("#leave");
        let todayTime = document.querySelector("#todayTime");
        let weeklyTotal = document.querySelector("#weeklyTotal");
        let weeklyAttendTime = document.querySelector("#weeklyAttendTime");
        let weeklyLeaveTime = document.querySelector("#weeklyLeaveTime");
        let workMonthByYear = document.querySelector(".workMonthByYear");
        let weeklyTime = null;
        let selectedYear = null;
        let currentDate = new Date();
        let monthDiv = document.querySelector("#monthDiv");
        let attendDate = "";
        let leaveDate = "";

        refreshCommute(); //출퇴근 기록 가져오기
        getMaxWeeklyWorkTime(); //주간 근무 시간
        getWeeklyAttendTime(); //주간 출근 시간
        getWeeklyLeaveTime(); //주간 퇴근 시간
        getAllYear(); //근무 해당 연도 가져오기

        yearSelect.addEventListener("change", function () {
            selectedYear = yearSelect.options[yearSelect.selectedIndex].value;
            getAllMonth();
        });

        //출근버튼 눌렀을 때
        goBtn.addEventListener("click", function () {
            $.ajax({
                type: 'get',
                url: `/commute/getAttend/\${dclzEmplId}`,
                dataType: 'json',
                success: function (commuteVO) {
                    $.ajax({
                        type: 'post',
                        url: `/commute/insertAttend`,
                        data: commuteVO,
                        dataType: 'text',
                        success: function(rslt) {
                            refreshCommute();
                            getWeeklyAttendTime();
                        },
                        error: function (xhr) {
                            console.log(rslt);
                        }
                    });

                },
                error: function (xhr) {
                    console.log(xhr.status);
                }
            });
        });

        //퇴근버튼 눌렀을 때
        leaveBtn.addEventListener("click", function () {
            $.ajax({
                type:'put',
                url: `/commute/updateCommute/\${dclzEmplId}`,
                dataType: 'text',
                success: function (rslt) {
                    refreshCommute();
                    getMaxWeeklyWorkTime();
                    getWeeklyLeaveTime();
                    clearInterval(intervalId);
                },
                error: function (xhr) {
                    console.log(xhr.status);
                }
            });
        });

        let intervalId = null;
        function refreshCommute() {
            $.ajax({
                type: 'get',
                url: `/commute/getCommute/\${dclzEmplId}`,
                dataType: 'json',
                success: function (rslt) {
                    if (rslt.dclzAttendTm != null) {
                        goBtn.setAttribute("disabled", "true");
                        attendDate = parseDate(rslt.dclzAttendTm);
                        let attendTime = formatTime(attendDate);
                        attend.innerText = attendTime;
                        updateWorkTime();
                        if (rslt.dclzLvffcTm == "2000-01-01 00:00:00") { //출근만 찍혀 있을 때
                            intervalId = setInterval(updateWorkTime, 10000); //실시간 업데이트
                        } else { //출퇴근 다 찍혀있을 때
                            leaveDate = parseDate(rslt.dclzLvffcTm);
                            let leaveTime = formatTime(leaveDate);
                            leave.innerHTML = leaveTime;
                            leaveBtn.setAttribute("disabled", "true");
                            dailTime = changeMinuteToTime(rslt.dclzDailWorkTime);
                            todayTime.innerText = dailTime;
                        }
                    }
                },
                error: function (xhr) {
                    console.log("CODE: ", xhr.status);
                }
            });
        }

        // 출근 시간을 Date 객체로 변환하는 함수
        function parseDate(dateString) {
            const [year, month, day, hours, minutes] = dateString.split(/[- :]/);
            return new Date(year, month - 1, day, hours, minutes);
        }

        function formatTime(time) {
            if (time) {
                let formattedTime = `\${time.getHours()}:\${(time.getMinutes() < 10 ? '0' : '')}\${time.getMinutes()}`;
                return formattedTime;
            } else {
                return "00:00";
            }
        }

        function updateWorkTime(timeDifference) {
            if (attendDate) {
                currentDate = new Date(); // 현재 시간 업데이트
                const timeDifference = currentDate - attendDate;
                const workHours = Math.floor(timeDifference / (1000 * 60 * 60));
                const workMinutes = Math.floor((timeDifference % (1000 * 60 * 60)) / (1000 * 60));
                const todayT = `\${workHours}시간 \${workMinutes}분`;
                todayTime.innerText = todayT;
            }
        }

        function changeMinuteToTime(minutes) { //분 -> HH:MI
            let hours = Math.floor(minutes / 60);
            let remainMinutes = minutes % 60;
            return `\${hours}시간 \${remainMinutes < 10 ? '0' : ''}\${remainMinutes}분`;
        }

        function getMaxWeeklyWorkTime() {
            $.ajax({
                type: 'get',
                url:`/commute/getMaxWeeklyWorkTime/\${dclzEmplId}`,
                dataType: 'text',
                success: function (rslt) {
                    weeklyTime = parseInt(rslt);
                    cWeeklyTime = changeMinuteToTime(weeklyTime);
                    weeklyTotal.innerText = cWeeklyTime;
                    start(weeklyTime);
                },
                error: function (xhr) {
                    console.log(xhr.status);
                }
            });
        }

        function getWeeklyAttendTime() {
            $.ajax({
                type: 'get',
                url: `/commute/getWeeklyAttendTime/\${dclzEmplId}`,
                dataType: 'json',
                success: function (rslt) {
                    weeklyAttendTime.innerHTML = fillTablebyDY(rslt);
                },
                error(xhr) {
                    xhr.status;
                }
            });
        };

        function getWeeklyLeaveTime() {
            $.ajax({
                type: 'get',
                url: `/commute/getWeeklyLeaveTime/\${dclzEmplId}`,
                dataType: 'json',
                success: function (rslt) {
                    weeklyLeaveTime.innerHTML = fillTablebyDY(rslt);
                },
                error(xhr) {
                    xhr.status;
                }
            });
        };

        function fillTablebyDY(rslt) {
            let code = ``;
            let dataByDay = {};
            for (let i = 0; i < rslt.length; i++) {
                let data = rslt[i].split(" ");
                let dy = data[0]; //요일
                let time = data[1]; // 시간 부분
                dataByDay[dy] = time;
            }
            let daysOfWeek = ["MON", "TUE", "WED", "THU", "FRI"];
            // 요일별로 테이블에 추가
            for (let i = 0; i < daysOfWeek.length; i++) {
                let day = daysOfWeek[i];
                let time = dataByDay[day];
                code += `<td>\${time || "-"}</td>`;
            }
            return code;
        }

        function getAllYear () {
            $.ajax({
                type: 'get',
                url: `/commute/getAllYear/\${dclzEmplId}`,
                dataType: 'json',
                success: function (rslt) {
                    let code = ``;
                    for (let i = 0; i < rslt.length; i++) {
                        code += `<option value="\${rslt[i]}">\${rslt[i]}</option>`;
                    }
                    yearSelect.innerHTML = code;
                    selectedYear = rslt[0];
                    getAllMonth();
                },
                error: function (xhr) {
                    xhr.status;
                }
            });
        }

        function getAllMonth () {
            data = {
                "year" : selectedYear,
                "dclzEmplId": dclzEmplId
            }

            $.ajax({
                type: 'get',
                url: '/commute/getAllMonth',
                data: data,
                dataType: 'json',
                success: function (rslt) {
                    let code = ``;
                    for (let i = 1; i <= 12; i++) {
                        if (rslt.includes(i < 10 ? `0\${i}` : `\${i}`)) {
                            code += `<button type="button" onclick="getCommuteByYearMonth(this)" >\${i}월</button>`;
                        } else {
                            code += `<button type="button" disabled>\${i}월</button>`;
                        }
                    }
                    monthDiv.innerHTML = code;
                },
                error: function (xhr) {
                    xhr.status;
                }
            });
        }

        function getCommuteByYearMonth(monthBtn) {
            //년도 - 월 버튼 선택시
            let month = parseInt(monthBtn.innerText);
            month = month < 10 ? `0\${month}` : month;
            data = {
                "dclzEmplId": dclzEmplId,
                "year": selectedYear,
                "month": month
            }
            $.ajax({
                type: 'get',
                url: '/commute/getCommuteByYearMonth',
                data: data,
                contentType: 'json',
                dataType: 'json',
                success: function (rslt) {
                    formatTime()
                    let commuteTable = document.querySelector("#commuteTable");
                    code = `<table border="1">
                                <tr>
                                    <th>날짜</th>
                                    <th>상태</th>
                                    <th>근무시간</th>
                                </tr>`;

                    for (let i = 0; i < rslt.length; i++) {
                        let beforeDate = new Date(rslt[i].dclzWorkDe);
                        let year = beforeDate.getFullYear();
                        let month = beforeDate.getMonth() + 1;
                        month = month<10?month=`0\${month}`: month;
                        let date = beforeDate.getDate();
                        date = date<10?date=`0\${date}`: date;
                        let afterDate = `\${year}-\${month}-\${date}`;

                        let time = changeMinuteToTime(rslt[i].dclzDailWorkTime);

                        let status = rslt[i].commonCodeLaborSttus;
                        if (status == "LABOR_STTUS010") {
                            status = "정상출근";
                        } else if(status == "LABOR_STTUS012") {
                            status = "지각";
                        } else if(status == "LABOR_STTUS015") {
                            status = "무단결근";
                        }

                        code += `<tr>
                                        <td>\${afterDate}</td>
                                        <td>\${status}</td>
                                        <td>\${time}</td>
                                </tr>`;
                    }
                    code += `</table>`;
                    commuteTable.innerHTML = code;
                },
                error: function (xhr) {
                    xhr.status;
                }
            });
        }
        //--------------------------- 주간 근무시간 움직이는 bar -----------------------
        let i = 0;
        function start(weeklybar) { //weeklybar 주간 근무시간
            if (i == 0) {
                i = 1;
                let elem = document.getElementById("progress-bar");
                let width = 0;
                let id = setInterval(frame, 30);
                let wb = weeklybar / (52 * 60) * 100;
                function frame() {
                    if (width >= wb) {
                        clearInterval(id);
                        i = 0;
                    } else {
                        width++;
                        elem.style.width = width + "%";
                        elem.innerHTML = width;
                    }
                }
            }
        }

    </script>
</sec:authorize>
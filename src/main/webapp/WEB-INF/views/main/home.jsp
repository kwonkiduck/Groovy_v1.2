<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <h2 class="font-24">안녕하세요, ${CustomUser.employeeVO.emplNm}님 <br>
        오늘 업무도 힘차게 파이팅! &#x1F64C;</h2>
    <br>
    <form>
        <button type="button" id="work" data-io="0">출근하기</button>
        <p id="workTime">00:00</p>
        <br/>
        <button type="button" id="leave" data-io="1">퇴근하기</button>
        <p id="leaveTime">00:00</p>
        <!-- 총 근무 시간 : <span id="totalWorkTime"></span> -->
    </form>

    <hr/>

    <h3>해야 할 일</h3>
    <table border="1" style="width: 50%;">
        <thead>
        <tr>
            <th>업무결과</th>
            <th>업무제목</th>
            <th>마감날짜</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>진행전</td>
            <td>마인드풀니스:현대인의 스트레스 해소 비법</td>
            <td>2023-07-30</td>
        </tr>
        <tr>
            <td>진행중</td>
            <td>마인드풀니스:현대인의 스트레스 해소 비법</td>
            <td>2023-07-30</td>
        </tr>
        <tr>
            <td>완료</td>
            <td>마인드풀니스:현대인의 스트레스 해소 비법</td>
            <td>2023-07-30</td>
        </tr>
        </tbody>
    </table>
    <br/>
    <hr/>

    <h3>공지사항</h3>
    <div id="mainNotice"></div>
    <br/>
    <hr/>

    <h3>결재함</h3>
    <table border="1" style="width: 50%;">
        <thead>
        <tr>
            <th>카테고리</th>
            <th>제목</th>
            <th>날짜</th>
        </tr>
        </thead>
        <tbody>
        <tr>
            <td>휴가</td>
            <td>마인드풀니스:현대인의 스트레스 해소 비법</td>
            <td>2023-07-30</td>
        </tr>
        <tr>
            <td>일정</td>
            <td>마인드풀니스:현대인의 스트레스 해소 비법</td>
            <td>2023-07-30</td>
        </tr>
        </tbody>
    </table>
    <br/>
    <hr/>
    <h3>오늘의 식단</h3>
    <div id="dietWrap">

    </div>

    <br/>
    <hr/>
    <h3>이번달 생일</h3>
    <div id="birthdayWrap">

    </div>
    <br/>
    <hr/>
    <h3>날씨</h3>
    <div id="weather"></div>
    <img id="weatherImg" src="">
    <form action="/main/uploadFile" method="post" enctype="multipart/form-data">
        <input type="file" name="defaultFile">
        <button type="submit">저장</button>
    </form>
    <p>파일 업로드 확인용</p>
    <img src="/uploads/test/test.png"/>


</sec:authorize>
<script>
    let dclzEmplId = `${CustomUser.employeeVO.emplId}`;

    $(document).ready(function () {

        // 공지사항 불러오기 (최신 2개)
        $.ajax({
            url: "/main/loadNotice",
            type: "get",
            success: function (data) {
                code = `<table border="1">`;

                $.each(data, function (index, item) {
                    code += `<tr>
                             <td>\${item.notiCtgryIconFileStreNm}</td>
                             <td>\${item.notiTitle}</td>
                             <td>\${item.notiDate}</td>
                             </tr>`
                })

                code += `</table>`

                $("#mainNotice").html(code);
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status)
            }
        })


        // -----------------------------------------------------------날짜 포맷팅
        let before = new Date();

        let year = before.getFullYear();
        let month = String(before.getMonth() + 1).padStart(2, '0');
        let day = String(before.getDate()).padStart(2, '0');

        const today = year + '-' + month + '-' + day;
        console.log("TODAY ", today)
        // --------------------------------------------------------------------

        const btnWork = document.querySelector("#work");
        const btnLeave = document.querySelector("#leave");
        const workTime = document.querySelector("#workTime");
        const leaveTime = document.querySelector("#leaveTime");
        let workTimeData = undefined;
        let leaveTimeData = undefined;
        let totalWorkTime = undefined;

        function formatTime(currentTime) {
            const hours = currentTime.getHours().toString().padStart(2, "0");
            const minutes = currentTime.getMinutes().toString().padStart(2, "0");
            const time = hours + ":" + minutes;
            return time;
        }

        function formatDate(date) {
            const options = {
                year: "numeric",
                month: "2-digit",
                day: "2-digit",
                weekday: "short",
            };
            return date.toLocaleString("ko-KR", options).replace(/[()]/g, '');
        }

        let recordDate = (date) => {
            const currentDate = formatDate(date);
            const regex = /(\d{4})\. (\d{2})\. (\d{2})\. (\S+)/;
            const matches = currentDate.match(regex);
            if (matches) {
                return dayOfWeek = matches[4];
            }
        }
        refreshCommute();

        //  출근버튼을 눌렀을 때
        btnWork.addEventListener("click", () => {
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
                        success: function (rslt) {
                            console.log(rslt);
                            refreshCommute();
                        },
                        error: function (xhr) {
                            console.log(xhr.status);
                        }
                    });

                },
                error: function (xhr) {
                    console.log(xhr.status);
                }
            });
        })

        /* 퇴근 버튼을 눌렀을 때 */
        btnLeave.addEventListener("click", () => {
            $.ajax({
                type: 'put',
                url: `/commute/updateCommute/\${dclzEmplId}`,
                dataType: 'text',
                success: function (rslt) {
                    refreshCommute();
                },
                error: function (xhr) {
                    console.log(xhr.status);
                }
            });
        });

        // 출근 시간을 Date 객체로 변환하는 함수
        function parseDate(dateString) {
            const [year, month, day, hours, minutes] = dateString.split(/[- :]/);
            return new Date(year, month - 1, day, hours, minutes);
        }

        function refreshCommute() {
            $.ajax({
                type: 'get',
                url: `/commute/getCommute/\${dclzEmplId}`,
                dataType: 'json',
                success: function (rslt) {
                    if (rslt.dclzAttendTm != null) {
                        btnWork.setAttribute("disabled", "true");
                        attendDate = parseDate(rslt.dclzAttendTm);
                        leaveDate = parseDate(rslt.dclzLvffcTm);
                        let attendTime = formatTime(attendDate);
                        let leaveT = formatTime(leaveDate);
                        workTime.innerText = attendTime;
                        leaveTime.innerHTML = leaveT;
                        if (rslt.dclzLvffcTm != "2000-01-01 00:00:00") { //출 퇴근 다 찍혀있을 때
                            leave.setAttribute("disabled", "true");
                        }
                    }
                },
                error: function (xhr) {
                    console.log("CODE: ", xhr.status);
                }
            });
        }

        let birthday;
        // 이번달 생일
        $.ajax({
            url: "/employee/loadBirthday",
            type: "get",
            success: function (data) {
                code = `<table>`;
                // <tr><th>사원번호</th><th>사원이름</th></tr>
                $.each(data, function (index, item) {
                    const birthday = item.emplBrthdy.split("-")[2];
                    console.log(birthday)
                    code += `<tr><td><img src="/uploads/profile/\${item.proflPhotoFileStreNm}" width="50px;"/></td>
                             <td>\${item.emplNm}</td></tr>
                             <td>\${birthday}일</td></tr>`
                })

                code += `</table>`

                $("#birthdayWrap").html(code);
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status)
            }
        })

        // 오늘의 식단
        $.ajax({
            url: `/main/\${today}`,
            type: 'GET',
            success: function (data) {
                let dietRes = `<p>\${data.dietRice}</p>
                            <p>\${data.dietSoup}</p>
                            <p>\${data.dietDish1}</p>
                            <p>\${data.dietDish2}</p>
                            <p>\${data.dietDish3}</p>
                            <p>\${data.dietDessert}</p>
                            `
                $("#dietWrap").html(dietRes);

            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status)
            }
        })

        // 날씨 불러오기
        $.ajax({
            url: '/weather/getWeather',
            type: 'GET',
            dataType: 'json',
            success: function (data) {
                console.log("날씨 json data: ", data)
                const items = data.response.body.items.item;
                let sky = '';
                let temperature = '';
                let imgSrc = "/resources/images/weather/";

                for (let i = 0; i < items.length; i++) {
                    let jsonObj = items[i];
                    let fcstValue = jsonObj.fcstValue;
                    let category = jsonObj.category;

                    if (category === 'SKY') {
                        switch (fcstValue) {
                            case '1':
                                sky += '맑음';
                                imgSrc += 'sun.png';
                                break;
                            case '2':
                                sky += '비';
                                imgSrc += 'heavyRain.png';
                                break;
                            case '3':
                                sky += '구름 ';
                                imgSrc += 'cloud.png';
                                break;
                            case '4':
                                sky += '흐림 ';
                                imgSrc += 'cloudSun.png';
                                break;
                        }
                    }
                    if (category === 'PTY') {
                        switch (fcstValue) {
                            case '1':
                            case '2':
                                sky = '비';
                                imgSrc = '/resources/images/weather/heavyRain.png';
                                break;
                            case '3':
                                sky += '눈';
                                imgSrc += '/resources/images/weather/snowfall.png';
                                break;
                        }
                    }
                    if (category === 'TMP') {
                        temperature = '' + fcstValue + '℃';
                    }
                }
                $('#weather').html(sky + " " + temperature);
                $('#weatherImg').attr('src', imgSrc);
            },
            error: function (xhr) {
                console.log(xhr.status);
            }
        });
    });

    /*  */
</script>
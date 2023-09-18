<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<link href="/resources/css/schedule/calendar.css" rel="stylesheet"/>
<script src="/resources/fullcalendar/main.js"></script>
<script src="/resources/fullcalendar/ko.js"></script>

<!-- 캘린더에 시간 안 보이게 하기, 크기 조정 -->
<style>
    .fc-event-time {
        display: none;
    }

    #calendar {
        width: 500px;
    }
</style>

<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal" var="CustomUser"/>
    <div class="content">
        <div class="content-header">
            <h2 class="font-24 font-md hello"><strong>안녕하세요, ${CustomUser.employeeVO.emplNm}님</strong><br>
                오늘 업무도 힘차게 파이팅! &#x1F64C;</h2>
        </div>
        <div class="content-body">
            <div class="inner">
                <section class="left">
                    <div class="section-inner flex-inner">
                        <div class="commute">
                            <div class="commute-area commute-work card-df card">
                                <button type="button" id="work" data-io="0" class="btn-commute pd-32">
                                    <h3 class="content-title font-b">출근</h3>
                                    <p id="workTime">00:00</p>
                                </button>
                            </div>
                            <div class="commute-area commute-leave card-df card">
                                <button type="button" id="leave" data-io="1" class="btn-commute pd-32">
                                    <h3 class="content-title font-b">퇴근</h3>
                                    <p id="leaveTime">00:00</p>
                                </button>

                            </div>
                        </div>
                        <div class="job">
                            <div class="job-area card card-df pd-32">
                                <div class="area-header">
                                    <h3 class="content-title font-b">해야할 일</h3>
                                    <a href="#" class="more">
                                        모두 보기 <i class="icon i-arr-rt"></i>
                                    </a>
                                </div>
                                <div class="area-body">
                                    <ul class="content-list job-list">
                                        <li><a href="#" class="list-item">
                                            <span class="badge ongoing">진행중</span>
                                            <p class="list-context">할 일 백엔드</p>
                                            <span class="list-date">2023-07-30</span>
                                        </a></li>
                                        <li><a href="#" class="list-item">
                                            <span class="badge waiting">진행전</span>
                                            <p class="list-context">할 일 백엔드</p>
                                            <span class="list-date">2023-07-30</span>
                                        </a></li>
                                        <li><a href="#" class="list-item">
                                            <span class="badge waiting">진행전</span>
                                            <p class="list-context">할 일 백엔드</p>
                                            <span class="list-date">2023-07-30</span>
                                        </a></li>
                                        <li><a href="#" class="list-item">
                                            <span class="badge waiting">진행전</span>
                                            <p class="list-context">할 일 백엔드</p>
                                            <span class="list-date">2023-07-30</span>
                                        </a></li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="notice">
                            <div class="notice-area card card-df pd-32">
                                <div class="area-header">
                                    <h3 class="content-title font-b">공지사항</h3>
                                    <a href="#" class="more">
                                        모두 보기 <i class="icon i-arr-rt"></i>
                                    </a>
                                </div>
                                <div class="area-body">
                                    <ul class="content-list notice-list">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <section class="right">
                    <div class="section-inner grid-inner">
                        <div class="saction">
                            <div class="saction-area card card-df pd-32">
                                <div class="area-header">
                                    <h3 class="content-title font-b">진행중인 결재</h3>
                                    <a href="#" class="more">
                                        모두 보기 <i class="icon i-arr-rt"></i>
                                    </a>
                                </div>
                                <div class="area-body">
                                    <ul class="content-list saction-list">
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="calendar">
                            <div class="calendar-area card card-df pd-32">

                            </div>
                        </div>
                        <div class="diet">
                            <div class="diet-area card card-df pd-32">
                                <div class="area-header">
                                    <h3 class="content-title font-b">오늘의 식단</h3>
                                </div>
                                <div class="area-body">
                                    <ul class="content-list diet-list">
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="birthday">
                            <div class="birthday-area card card-df pd-32">
                                <div class="area-header">
                                    <h3 class="content-title font-b">이달의 생일</h3>
                                </div>
                                <div class="area-body">
                                    <ul class="content-list birthday-list">
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
            </div>
        </div>

       <%-- <h3>해야 할 일</h3>
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

        <h3>진행 중인 결재</h3>
        <div id="sanctionBox">
        </div>

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
        <h3>일정</h3>
        <div id="calendar">
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
        <img src="/uploads/test/test.png"/>--%>
    </div>

</sec:authorize>
<script>
    let dclzEmplId = "${CustomUser.employeeVO.emplId}";

    $(document).ready(function () {

        // 진행 중인 결재 불러오기 (10개)
        $.ajax({
            url: `/common/loadSanction/\${dclzEmplId}`,
            type: "get",
            success: function (data) {
                code = "";
                $.each(data, function (index, item) {
                    code += `<li><a href="#" class="list-item">
                                    <p class="list-context">\${item.elctrnSanctnSj}</p>
                                    <span class="list-date">\${item.elctrnSanctnRecomDate}</span>
                            </a></li>`
                })
                $(".saction-list").html(code);
            },
            error: function (xhr, status, error) {
                console.log("code: " + xhr.status)
            }
        })

        // 공지사항 불러오기 (최신 2개)
        $.ajax({
            url: "/common/loadNotice",
            type: "get",
            success: function (data) {
                code = "";

                $.each(data, function (index, item) {
                    code += `
                           <li><a href="#" class="list-item">
                                    <span class="badge">공지사항</span>
                                    <p class="list-context">\${item.notiCtgryIconFileStreNm} \${item.notiTitle}</p>
                                    <span class="list-date">\${item.notiDate}</span>
                                </a></li>`
                })

                $(".notice-list").html(code);
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
                    code += `
                            <li><a href="#" class="list-item">
                                <img src="/uploads/profile/\${item.proflPhotoFileStreNm}" width="50px;" title="\${item.emplNm}"/>
                            </a></li>
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

        //달력
        $(document).ready(function () {
            $(function () {
                var request = $.ajax({
                    url: "/calendar/schedule",
                    method: "GET",
                    dataType: "json"
                });

                request.done(function (data) {
                    let calendarEl = document.querySelector(".calendar-area");
                    calendar = new FullCalendar.Calendar(calendarEl, {
                        height: '100%',
                        slotMinTime: '08:00',
                        slotMaxTime: '20:00',
                        headerToolbar: {
                            left: 'prev,next today',
                            center: 'title',
                            right: false
                        },
                        initialView: 'dayGridMonth',
                        navLinks: true,
                        selectable: true,
                        events: data,
                        locale: 'ko',
                        dayCellContent: function(e) {
                            e.dayNumberText = e.dayNumberText.replace('일', '');
                        }
                    });
                    calendar.render();
                });
            });
        })

        // 오늘의 식단
        $.ajax({
            url: `/common/\${today}`,
            type: 'GET',
            success: function (data) {
                let dietRes = `
                            <li class="diet-item">\${data.dietRice}</li>
                            <li class="diet-item">\${data.dietSoup}</li>
                            <li class="diet-item">\${data.dietDish1}</li>
                            <li class="diet-item">\${data.dietDish2}</li>
                            <li class="diet-item">\${data.dietDish3}</li>
                            <li class="diet-item">\${data.dietDessert}</li>
                            `
                $(".diet-list").html(dietRes);

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
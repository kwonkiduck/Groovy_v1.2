// 모달 열기 함수
function openModal(modalId) {
    document.querySelector("#modal").style.display = "flex";
    document.querySelector(modalId).classList.add("on");
}

// 모달 닫기 함수
function closeModal() {
    const modalCommon = document.querySelectorAll(".modal-common");
    modalCommon.forEach(item => item.classList.remove("on"));
    document.querySelector("#modal").style.display = "none";
}

let jobProgressVO;

//들어온 업무 요청
document.querySelector("#receiveJobContainer").addEventListener("click", (event) => {
    const target = event.target;
    let jobNo = null;

    if (target.classList.contains("receiveJob")) {
        jobNo = target.getAttribute("data-seq");
    } else if (target.closest(".receiveJob")) {
        jobNo = target.closest(".receiveJob").getAttribute("data-seq");
    }

    if (jobNo !== null) {
        event.preventDefault();
        openModal("#modal-receive-job");
        let checkboxes = document.querySelectorAll(".receive-kind");

        checkboxes.forEach(checkbox => {
            checkbox.checked = false;
        });

        $.ajax({
            type: 'get',
            url: '/job/getReceiveJobByNo?jobNo=' + jobNo,
            success: function (rslt) {
                document.querySelector(".receive-sj").innerText = rslt.jobSj;
                document.querySelector(".receive-cn").innerText = rslt.jobCn;
                document.querySelector(".receive-begin").innerText = rslt.jobBeginDate;
                document.querySelector(".receive-close").innerText = rslt.jobClosDate;
                document.querySelector(".receive-request").innerText = rslt.jobRequstEmplNm;
                let kind = rslt.commonCodeDutyKind;

                checkboxes.forEach(checkbox => {
                    checkbox.disabled = true;
                    if (checkbox.value === kind) {
                        checkbox.checked = true;
                    }
                });

                jobProgressVO = {
                    "jobNo": jobNo,
                    "commonCodeDutySttus": "거절"
                };
            },
            error: function (xhr) {
                console.log(xhr.status);
            }
        });
    }
});

document.querySelector("#reject").addEventListener("click", ()=> {
    reject(jobProgressVO);
})
//요청 상태 변경 (거절, 승인)
function reject(jobProgressVO) {
    $.ajax({
        type:'put',
        url:'/job/updateJobStatus',
        data: JSON.stringify(jobProgressVO),
        contentType: 'application/json; charset=utf-8',
        success: function () {
            location.href = "/job/main";
        },
        error: function (xhr) {
            console.log(xhr.status);
        }
    })
}


document.querySelector(".requestJob").addEventListener("click", () => {
    openModal("#modal-request-job");
});

//업무 요청하기(상세)
document.getElementById("requestJobContainer").addEventListener("click", (event) => {
    openModal("#modal-requestDetail-job");

    if (event.target.classList.contains("requestJobDetail")) {
        let checkboxes = document.querySelectorAll(".data-kind");
        checkboxes.forEach(checkbox => {
            checkbox.checked = false;
        });

        let jobNo = event.target.getAttribute("data-seq");
        $.ajax({
            type: 'get',
            url: '/job/getJobByNo?jobNo=' + jobNo,
            success: function (rslt) {
                document.querySelector(".data-sj").innerText = rslt.jobSj;
                document.querySelector(".data-cn").innerText = rslt.jobCn;
                document.querySelector(".data-begin").innerText = rslt.jobBeginDate;
                document.querySelector(".data-close").innerText = rslt.jobClosDate;
                let kind = rslt.commonCodeDutyKind;
                let checkboxes = document.querySelectorAll(".data-kind");

                checkboxes.forEach(checkbox => {
                    if (checkbox.value === kind) {
                        checkbox.checked = true;
                    }
                });
                let jobProgressVOList = rslt.jobProgressVOList;
                let code = ``;
                jobProgressVOList.forEach((jobProgressVO) => {
                    code += `<span class="${jobProgressVO.commonCodeDutySttus}">
                                    <span>${jobProgressVO.jobRecptnEmplNm}</span>
                                    ${jobProgressVO.commonCodeDutySttus === '승인' ? `<span> | ${jobProgressVO.commonCodeDutyProgrs}</span>` : ''}
                             </span>`;
                });
                document.querySelector("#receiveBox").innerHTML = code;
            },
            error: function (xhr) {
                console.log(xhr.status);
            }
        });
    }
});
document.querySelector(".addJob").addEventListener("click", () => {
    openModal("#modal-newJob");
});
document.querySelector(".myjob").addEventListener("click", () => {
    openModal("#modal-job-detail");
});

const close = document.querySelectorAll(".close");

close.forEach(item => {
    item.addEventListener("click", () => {
        closeModal();
    });
});

//날짜 유효성 검사
function validateDate() {
    const begin = document.querySelector("#jobBeginDate");
    const close = document.querySelector("#jobClosDate");
    const beginDate = new Date(begin.value);
    const closeDate = new Date(close.value);

    validateCurrentDate(begin);
    validateCurrentDate(close);

    if (beginDate > closeDate) {
        alert('끝 날짜는 시작 날짜보다 이전이 될 수 없습니다.');
        close.value = begin.value;
    }
}

function validateCurrentDate(input) {
    let currentDate = new Date();
    let inputDate = new Date(input.value);

    let currentYear = currentDate.getFullYear();
    let currentMonth = String(currentDate.getMonth() + 1).padStart(2, '0');
    let currentDay = String(currentDate.getDate()).padStart(2, '0');

    let minDate = new Date(currentYear, currentDate.getMonth(), currentDay); // 월은 0부터 시작하므로 -1 제거

    if (inputDate <= minDate) {
        alert('현재 날짜보다 이전의 날짜는 설정할 수 없습니다.');
        let formattedDate = `${currentYear}-${currentMonth}-${currentDay}`;
        input.value = formattedDate;
    }
}

//업무 요청하기
let requestBtn = document.getElementById("request");
let requestForm = document.querySelectorAll("#requestJob")[0];

requestBtn.addEventListener("click", (event) => {
    event.preventDefault();
    let formData = new FormData(requestForm);
    let requiredList = ["jobSj", "jobCn", "jobBeginDate", "jobClosDate"];
    let validation = true;

    requiredList.forEach((required) => {
        let req = document.getElementById(required);
        if (req.value.trim() === "") {
            alert("모든 값을 입력해주세요.");
            validation = false;
        }
    });

    //받는 사원의 리스트
    let receiveEmpls = receive.querySelectorAll("span");
    let selectedEmplIds = [];
    receiveEmpls.forEach((receiveEmpl) => {
        let emplId = receiveEmpl.getAttribute("data-id");
        selectedEmplIds.push(emplId);
    });
    formData.append("selectedEmplIds", selectedEmplIds);

    $.ajax({
        url: '/job/insertJob',
        type: 'post',
        data: formData,
        contentType: false,
        processData: false,
        cache: false,
        success: function() {
            location.href = "/job/main";
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
});



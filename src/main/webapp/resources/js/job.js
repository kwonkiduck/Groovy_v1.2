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
                    "jobNo": jobNo
                };
            },
            error: function (xhr) {
                console.log(xhr.status);
            }
        });
    }
});

//요청 받은 업무 목록
document.querySelector(".new-request").addEventListener("click", (event) => {
    const target = event.target;
    let jobNo = null;

    if (target.classList.contains("receiveJob")) {
        jobNo = target.getAttribute("data-seq");
    } else if (target.closest(".receiveJob")) {
        jobNo = target.closest(".receiveJob").getAttribute("data-seq");
    }

    if (jobNo !== null) {
        event.preventDefault();
        let checkboxes = document.querySelectorAll(".receive-kind-box");

        checkboxes.forEach(checkbox => {
            checkbox.checked = false;
        });

        $.ajax({
            type: 'get',
            url: '/job/getReceiveJobByNo?jobNo=' + jobNo,
            success: function (rslt) {
                document.querySelector("#receive-sj").innerText = rslt.jobSj;
                document.querySelector("#receive-cn").innerText = rslt.jobCn;
                document.querySelector("#receive-begin").innerText = rslt.jobBeginDate;
                document.querySelector("#receive-close").innerText = rslt.jobClosDate;
                let kind = rslt.commonCodeDutyKind;

                checkboxes.forEach(checkbox => {
                    checkbox.disabled = true;
                    if (checkbox.value === kind) {
                        checkbox.checked = true;
                    }
                });

                jobProgressVO = {
                    "jobNo": jobNo
                };
            },
            error: function (xhr) {
                console.log(xhr.status);
            }
        });
    }
});

document.querySelector("#reject").addEventListener("click", () => {
    jobProgressVO["commonCodeDutySttus"] = "거절"
    rejectOrAgree(jobProgressVO);
})

document.querySelector("#agree").addEventListener("click", () => {
    jobProgressVO["commonCodeDutySttus"] = "승인"
    rejectOrAgree(jobProgressVO);
})

document.querySelector("#rejectJob").addEventListener("click", () => {
    jobProgressVO["commonCodeDutySttus"] = "거절"
    rejectOrAgree(jobProgressVO);
})

document.querySelector("#agreeJob").addEventListener("click", () => {
    jobProgressVO["commonCodeDutySttus"] = "승인"
    rejectOrAgree(jobProgressVO);
})

//요청 상태 변경 함수(거절, 승인)
function rejectOrAgree(jobProgressVO) {
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
let addJobs = document.querySelectorAll(".addJob");
addJobs.forEach(addJob => {
    addJob.addEventListener("click", () => {
        openModal("#modal-newJob");
        //신규 등록
        document.querySelector("#tab-new-request").addEventListener("click", () => {
            document.querySelector(".new-job").classList.remove("on");
            openModal(".new-request");
        });
        //요청 받은 업무 목록
        document.querySelector("#tab-new-job").addEventListener("click", () => {
            document.querySelector(".new-request").classList.remove("on");
            openModal(".new-job");
        });
    });
});

//신규 등록
document.querySelector(".new-job .regist").addEventListener("click", () => {
    let formData = new FormData(document.querySelector("#registNewJob"));
    let requiredList = ["jobSj", "jobCn", "jobBeginDate", "jobClosDate"];
    let validation = true;

    requiredList.forEach((required) => {
        let req = document.getElementById(required);
        if (req.value.trim() === "") {
            validation = false;
        }
    });

    if (!validation) {
        alert("모든 값을 입력해주세요.");
    }

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
})

let progressList = document.querySelectorAll(".progress");
let myJobs = document.querySelectorAll(".myJob");
myJobs.forEach(myJob => {
    myJob.addEventListener("click", (event)=> {
        let kindList = document.querySelectorAll(".kind-data");
        let target = event.target;

        kindList.forEach(kind => {
            kind.checked = false;
        });
        progressList.forEach(progress => {
            progress.checked = false;
        });

        if (target.classList.contains("todoCard")) {
            jobNo = target.getAttribute("data-seq");
        } else if (target.closest(".todoCard")) {
            jobNo = target.closest(".todoCard").getAttribute("data-seq");
        }

        if (jobNo !== null) {
            $.ajax({
                type: 'get',
                url: `/job/getJobByNoAndId?jobNo=${jobNo}`,
                success: function (rslt) {
                    document.querySelector("#sj-data").innerHTML = rslt.jobSj;
                    document.querySelector("#cn-data").innerHTML = rslt.jobCn;
                    document.querySelector("#begin-data").innerHTML = rslt.jobBeginDate;
                    document.querySelector("#close-data").innerHTML = rslt.jobClosDate;
                    document.querySelector("#request-data").innerHTML = rslt.jobRequstEmplNm;
                    kindList.forEach(kind => {
                        kind.disabled = true;
                        if (kind.value === rslt.commonCodeDutyKind) {
                            kind.checked = true;
                        }
                    });
                    progressList.forEach(progress => {
                        progress.disabled = true;
                        if (progress.value === rslt.jobProgressVOList[0].commonCodeDutyProgrs) {
                            progress.checked = true;
                        }
                    });
                    document.querySelector("#confirm").setAttribute("data-seq", jobNo);
                    openModal("#modal-job-detail");
                },
                error: function (xhr) {
                    console.log(xhr.status);
                }
            });
        }
    });
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
function newValidateDate() {
    const begin = document.querySelector("#date-begin");
    const close = document.querySelector("#date-close");
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
            validation = false;
        }
    });

    if (!validation) {
        alert("모든 값을 입력해주세요.");
    }

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

//수정
let modifyBtn = document.querySelector("#modify");
let confirmBtn = document.querySelector("#confirm");
modifyBtn.addEventListener("click", () => {
    progressList.forEach(progress => {
        progress.disabled = false;
    });
    confirmBtn.style.display = "block";
});

confirmBtn.addEventListener("click", () => {
    let jobNo = confirmBtn.getAttribute("data-seq");
    let selectedValue;
    progressList.forEach(progress => {
        if (progress.checked) {
            selectedValue = progress.getAttribute("data-code");
        }
    });
    let jobProgressVO = {
        "jobNo": jobNo,
        "commonCodeDutyProgrs": selectedValue
    }
    console.log(jobProgressVO)
    $.ajax({
        type: 'put',
        url: '/job/updateJobProgress',
        contentType: 'application/json; charset=utf-8',
        data: JSON.stringify(jobProgressVO),
        success: function () {
            location.href = "/job/main";
        },
        error: function (xhr) {
            console.log(xhr.status);
        }
    });
})


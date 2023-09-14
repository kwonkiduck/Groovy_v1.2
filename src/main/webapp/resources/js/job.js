document.querySelector(".receiveJob").addEventListener("click",()=>{
    document.querySelector("#modal").style.display = "flex";
    document.querySelector("#modal-receive-job").classList.add("on");
})
document.querySelector(".requestJobDetail").addEventListener("click",()=>{
    document.querySelector("#modal").style.display = "flex";
    document.querySelector("#modal-requestDetail-job").classList.add("on")
})
document.querySelector(".requestJob").addEventListener("click",()=>{
    document.querySelector("#modal").style.display = "flex";
    document.querySelector("#modal-request-job").classList.add("on")
})
document.querySelector(".addJob").addEventListener("click",()=>{
    document.querySelector("#modal").style.display = "flex";
    document.querySelector("#modal-newJob").classList.add("on")
})
document.querySelector(".myjob").addEventListener("click",()=>{
    document.querySelector("#modal").style.display = "flex";
    document.querySelector("#modal-job-detail").classList.add("on")
})

const close = document.querySelectorAll(".close");

close.forEach(item => {
    item.addEventListener("click",()=>{
        const modalCommon = document.querySelectorAll(".modal-common")
        modalCommon.forEach(item => item.classList.remove("on"))
        document.querySelector("#modal").style.display = "none";
    })
})

//날짜 유효성 검사
function validateDate() {
    let begin = document.querySelector("#jobBeginDate");
    let close = document.querySelector("#jobClosDate");
    let beginDate = begin.value;
    let closeDate = close.value;
    validateCurrentDate(beginDate);
    validateCurrentDate(closeDate);

    if (closeDate != "" && beginDate > closeDate) {
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
        data: formData, // FormData 객체를 전송
        contentType: false,
        processData: false,
        cache: false,
        success: function() {
            location.href = "/employee/job";
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });
});



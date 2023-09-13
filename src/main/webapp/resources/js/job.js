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

let requestBtn = document.getElementById("request");
let requestForm = document.querySelectorAll("#requestJob")[0];

requestBtn.addEventListener("click", (event) => {
    event.preventDefault();
    let formData = new FormData(requestForm);

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
        },
        error: function(xhr) {
            console.log(xhr.status);
        }
    });


});

//
// document.querySelector("#request").addEventListener("click", (event) => {
//
//     //받는 사원의 리스트
//     let receiveEmpls = receive.querySelectorAll("span");
//     let selectedEmplIds = [];
//
//     receiveEmpls.forEach((receiveEmpl) => {
//         let emplId = receiveEmpl.getAttribute("data-id");
//         console.log(emplId);
//         selectedEmplIds.push(emplId);
//     });
//
//     console.log(JSON.stringify(selectedEmplIds));
// })


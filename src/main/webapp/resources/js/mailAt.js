const allCheck = document.querySelector("#selectAll");
let checkboxes = document.querySelectorAll('.selectmail:checked');

function checkAll() {
    let checkboxes = document.querySelectorAll(".selectmail");
    checkboxes.forEach(function (checkbox) {
        checkbox.checked = allCheck.checked;
    });
}

function modifyAt(code, td) {
    let at = td.innerText;
    let emailEtprCode = td.getAttribute("data-id");
    $.ajax({
        url: `/email/${code}/${emailEtprCode}`,
        type: 'put',
        data: at,
        success: function (result) {
            at = result;
            td.innerText = at;
        },
        error: function (xhr, status, error) {
            console.log("code: " + xhr.status);
            console.log("message: " + xhr.responseText);
            console.log("error: " + xhr.error);
        }
    });
}

function modifyDeleteAt(code, td) {
    let emailEtprCode = td.getAttribute("data-id");
    let at = document.querySelector("input[type=hidden]").value;
    $.ajax({
        url: `/email/${code}/${emailEtprCode}`,
        type: 'put',
        data: at,
        success: function (result) {
            td.remove();
        },
        error: function (xhr, status, error) {
            console.log("code: " + xhr.status);
            console.log("message: " + xhr.responseText);
            console.log("error: " + xhr.error);
        }
    });
}

function modifyTableAt(td) {
    let code = td.getAttribute("data-type");
    if (code === 'redng' || code === 'imprtnc') {
        modifyAt(code, td);
    } else {
        code = 'delete';
        modifyDeleteAt(code, td)
    }
}

function modifyAtByBtn() {
    checkboxes = document.querySelectorAll(".selectmail:checked");
    checkboxes.forEach(function (checkbox) {
        let td = checkbox.parentNode.nextElementSibling;
        modifyTableAt(td);
        checkbox.checked = false;
        allCheck.checked = false;
    });
}

function modifyDeleteAtByBtn() {
    checkboxes = document.querySelectorAll(".selectmail:checked");
    checkboxes.forEach(function (checkbox) {
        let tr = checkbox.closest("tr");
        modifyTableAt(tr);
        checkbox.checked = false;
        allCheck.checked = false;
    });
}
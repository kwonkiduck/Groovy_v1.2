const allCheck = document.querySelector("#selectAll");
const checkboxes = document.querySelectorAll('.selectmail:checked');

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
        url: `/email/\${code}/\${emailEtprCode}`,
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

function modifyTableAt(td) {
    let code = td.getAttribute("data-type");
    modifyAt(code, td);
}

function modifyRedngAtByBtn() {
    checkboxes.forEach(function (checkbox) {
        let td = checkbox.parentNode.nextElementSibling;
        modifyTableAt(td);
        checkbox.checked = false;
        allCheck.checked = false;
    });
}
//조직도 팝업
let orgBtnTo = document.querySelector("#orgBtnTo");
let receiveTo = document.querySelector("#receiveTo");
let orgBtnCc = document.querySelector("#orgBtnCc");
let receiveCc = document.querySelector("#receiveCc");

getOrgChart(orgBtnTo, receiveTo);
getOrgChart(orgBtnCc, receiveCc);

function getOrgChart(orgBtn, receive) {
    orgBtn.addEventListener("click", () => {
        fetch("/job/jobOrgChart")
            .then((response) => response.text())
            .then((data) => {
                let popup = window.open("", "_blank", "width=800,height=600");

                popup.document.write(data);

                popup.document.querySelector("#orgCheck").addEventListener("click", () => {
                    const checkboxes = popup.document.querySelectorAll("input[name=orgCheckbox]");
                    let str = ``;
                    checkboxes.forEach((checkbox) => {
                        if (checkbox.checked) {
                            const label = checkbox.closest("label");
                            const emplId = checkbox.id;
                            const emplNm = label.querySelector("span").innerText;

                            let empl = {
                                emplId,
                                emplNm
                            }
                            if (orgBtn.getAttribute("id") === "orgBtnTo") {
                                str += `<span data-id=${empl.emplId}>
                                            ${empl.emplNm}
                                            <button type="button" class="close-empl">X</button>
                                        </span>
                                            <input type="hidden" name="emplIdToArr" value="${empl.emplId}">`;
                            } else if (orgBtn.getAttribute("id") === "orgBtnCc") {
                                str += `<span data-id=${empl.emplId}>
                                            ${empl.emplNm}
                                            <button type="button" class="close-empl">X</button>
                                            <input type="hidden" name="emplIdCcArr" value="${empl.emplId}">
                                        </span>`;
                            }

                        }
                    });
                    receive.insertAdjacentHTML("afterend", str);
                });

                popup.document.querySelector("#orgCheck").addEventListener("click", () => {
                    popup.close();
                });
            })
            .catch((error) => {
                console.error("데이터 가져오기 실패:", error);
            });
    });
}


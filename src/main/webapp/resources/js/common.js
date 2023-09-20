document.addEventListener("DOMContentLoaded",()=>{
    const navList = document.querySelectorAll(".nav-list > a");
    const tabHeader = document.querySelector("#tab-header");
    const tabList = tabHeader.querySelectorAll("a");

    /*  aside   */
    navList.forEach((item, index) => {
        item.addEventListener("click", () => {
            sessionStorage.setItem("activeNavItem", index);
        });

        const activeIndex = sessionStorage.getItem("activeNavItem");
        if (activeIndex && index === parseInt(activeIndex)) {
            navList.forEach((otherItem) => {
                otherItem.classList.remove("active");
            });
            item.classList.add("active");
        }
    });

    /*  tab */
    tabList.forEach(item=>{
        item.addEventListener("click",()=>{
            tabList.forEach(list=>{
                list.classList.remove("on");
            })
            item.classList.add("on");
        })
    })

})
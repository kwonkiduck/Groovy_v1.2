<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<style>
    .memo {
        border: 1px solid red;
        width: calc((315 / 1920) * 100vw);
        height: calc((320 / 1080) * 100vh);
    }
    #inputMemo {
        display: flex;
        align-items: center;
        justify-content: center;
    }
    #memoLists {
        display: flex;
    }
</style>
</head>
<body>
<h1>메모장</h1>
<h4>나만의 메모 공간 &#x1F4AD;</h4>
<div class="memoWrap">
    <div id="inputMemo" class="memo">
        <button id="inputMemoBtn">
            메모 추가
        </button>
    </div>
    <div id="memoLists">
        <div id="appendMemo"></div>
        <div id="memoList">
            <div class="memo">
                제목: <p>dfsdfsedf</p>
                내용: <p>sdfdga;wethg;agh</p>
            </div>
        </div>
    </div>
</div>

<script>
    const inputMemoBtn = document.querySelector("#inputMemoBtn");
    const memoLists = document.querySelector("#memoLists");
    let flug = true;
    inputMemoBtn.addEventListener("click",()=>{
        if(flug){
            const memoElem = document.createElement("div");
            memoElem.className = "memo";

            const memoTitle = document.createElement("input");
            memoTitle.type = "text";
            memoTitle.name = "memoSj";
            memoTitle.placeholder = "제목을 입력해주세요.";
            memoElem.appendChild(memoTitle);

            const memoCnt = document.createElement("textarea");

            memoCnt.name = "memoCn"
            memoCnt.placeholder = "내용을 입력해주세요.";

            memoElem.appendChild(memoCnt);
            const saveBtn = document.createElement("button");

            saveBtn.className = "savebtn";
            saveBtn.innerText = "저장";
            memoElem.appendChild(saveBtn);
            console.log(memoElem);

            document.querySelector("#appendMemo").append(memoElem);
            flug = false;
        }

    })
    memoLists.addEventListener("click",(e)=>{
        if(e.target.classList.contains("savebtn")){
            const target = e.target;
            /* ajax 처리 */
            flug = true;
        }
    })

</script>

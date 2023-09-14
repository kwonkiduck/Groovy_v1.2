<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
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
    
    .memoSn {
    	display: none;
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
        <c:forEach items="${memoList}" var="list">
            <div class="memo">
                <div class="memo-content">
                   <p class="memoSn">${list.memoSn}</p>
                   <p class="title">${list.memoSj}</p>
                   <p class="content">${list.memoCn}</p>
                   <p><fmt:formatDate value="${list.memoWrtngDate}" type="date" dateStyle="long" /></p>
                </div>
                <div class="bntWrap">
                    <button class="modifyBtn">수정</button>
                    <button class="delete">삭제</button>
                    <button class="save" style="display: none">저장</button>
                </div>
            </div>
         </c:forEach>
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
            memoTitle.id = "memoSj";
            memoTitle.placeholder = "제목을 입력해주세요.";
            memoElem.appendChild(memoTitle);

            const memoCnt = document.createElement("textarea");
            memoCnt.name = "memoCn";
            memoCnt.id = "memoCn";
            memoCnt.placeholder = "내용을 입력해주세요.";

            memoElem.appendChild(memoCnt);
            const saveBtn = document.createElement("button");

            saveBtn.className = "savebtn";
            saveBtn.innerText = "저장";
            memoElem.appendChild(saveBtn);

            document.querySelector("#appendMemo").append(memoElem);
            flug = false;
        }

    })
    memoLists.addEventListener("click",(e)=>{
        const target = e.target;
        if(target.classList.contains("savebtn")){
        	
            const memoElem = target.parentElement;
            const memoTitleInput = memoElem.querySelector('input[name="memoSj"]');
            const memoContentTextarea = memoElem.querySelector('textarea[name="memoCn"]');
            
            const memoSj = memoTitleInput.value;
            const memoCn = memoContentTextarea.value;
            
            console.log("memoSj", memoSj);
            console.log("memoCn", memoCn);
            
            const memoData = {
            		memoSj: memoSj,
            		memoCn: memoCn
            	};
            
            console.log("memoData", memoData);
            
            $.ajax({
                    url: "/memo/memoMain",
                    type: "POST",
                    data: JSON.stringify(memoData),
                    contentType: "application/json;charset=UTF-8",
                    success:function(data){
	                    		if(data=="success") {
	                    			console.log("성공")
	                               location.href=location.href;                    			
	                    		}
	                    		else {
	                    			alert("메모 추가를 실패했습니다");
	                    		}
                            },
                    error: function (request, status, error) {
                          console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                        }            

        })

            flug = true;
        }
        
        
        if(target.classList.contains("modifyBtn")){
            const memo = target.closest(".memo");
            const memoContent = memo.querySelector(".memo-content");
            let title = memo.querySelector(".title");
            let content = memo.querySelector(".content");
            const memoSnElement = memo.querySelector(".memoSn");
            
            const memoSn = memoSnElement.innerText;
            const memoSnInput = document.createElement("input");
            memoSnInput.type = "hidden";
            memoSnInput.name = "memoSn";
            memoSnInput.id = "memoSn";
            memoSnInput.value = memoSn;
            
            const memoTitle = document.createElement("input");
            memoTitle.type = "text";
            memoTitle.name = "memoSj";
            memoTitle.id = "memoSj";
            memoTitle.value = title.innerText;

            const memoCnt = document.createElement("textarea");
            memoCnt.name = "memoCn"
            memoCnt.value = content.innerText;
            memoCnt.id = "memoCn";

            memoContent.innerHTML = "";
            memoContent.append(memoSnInput);
            memoContent.append(memoTitle);
            memoContent.append(memoCnt);
            
            memo.querySelector(".modifyBtn").style.display = "none";
            memo.querySelector(".delete").style.display = "none";
            memo.querySelector(".save").style.display = "block";
            
            $.ajax({
				url: `memoMain/\${memoSn}`,
		        method: "GET",
		        dataType: "text",
		        success: function (response) {
		        		if(response=="success"){
		        		console.log("성공" + response); 
		        		
		        		} 
		        		
		        	} //success function 끝
		        }) //get ajax 끝
            
        } //modifyBtn if문 끝
        
        if(target.classList.contains("save")){
            const memo = target.closest(".memo");
            const memoNumber = memo.querySelector(".memoSn");
            console.log(memoNumber);
            const memoContent = memo.querySelector(".memo-content");
            document.querySelector(".modifyBtn").style.display = "inline-block";
            document.querySelector(".delete").style.display = "inline-block";
            document.querySelector(".save").style.display = "none";

            let sn = document.createElement("p");
            sn.classList = "memoSn";
            let title = document.createElement("p");
            title.classList = "title";
            let content = document.createElement("p");
            content.classList = "content";

            console.log(title, content);
            sn.innerText = memo.querySelector("#memoSn").value;
            title.innerText = memo.querySelector("#memoSj").value;
            content.innerText = memo.querySelector("#memoCn").value;
            
			console.log(sn.innerText, title.innerText);
            
			memoContent.innerHTML = "";
            memoContent.append(sn);
            memoContent.append(title);
            memoContent.append(content);

            let memoSn = sn.innerText;
            let memoSj = title.innerText;
            let memoCn = content.innerText;
            
            const updateData = {
                    memoSn: memoSn,
                    memoSj: memoSj,
                    memoCn: memoCn
                };
            
            console.log(updateData);
            
            $.ajax({
                url: `memoMain/\${memoSn}`,
                type: "PUT",
                dataType: "text",
                data: JSON.stringify(updateData),
                contentType: "application/json;charset=UTF-8",
                success:function(data){
                    		if(data=="success") {
                    			console.log("성공")
                               location.href=location.href;                    			
                    		} // if 끝
                    		else {
                    			alert("메모 추가를 실패했습니다");
                    		} // else 끝
                        }, // success 끝
                error: function (request, status, error) {
                      console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                    } // save error 끝            
    }) // put ajax 끝
        } // save if 끝
        
        if(target.classList.contains("delete")) {
            const memo = target.closest(".memo");
            const memoNumber = memo.querySelector(".memoSn");
            console.log(memoNumber);
            memoSn = memoNumber.innerText;

            console.log(memoSn);

            const deleteData = {
                memoSn : memoSn
            }

            console.log(deleteData);

            $.ajax({
                url: `memoMain/\${memoSn}`,
                type: "DELETE",
                dataType: "text",
                data: JSON.stringify(deleteData),
                contentType: "application/json;charset=UTF-8",
                success: function(data) {
                    if(data=="success") {
                        console.log("삭제 성공");
                        location.href = location.href;
                    } else {
                        alert("메모 삭제를 실패했습니다.");
                    }
                },
                error: function (request, status, error) {
                      console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
                }
            }) //delete ajax 끝
        }
    }) // memoLists.addEventListener 끝
</script>
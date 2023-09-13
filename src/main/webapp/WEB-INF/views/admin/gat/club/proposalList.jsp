<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<h1 class="tab"><a href="/club/admin">동호회 관리</a></h1><br /><br />
<div class="content-wrapper">
    <div class="content-header">
        <h2>동호회 제안내역</h2>
    </div>
    <div class="content-body">
        <div id="listGrid" class="ag-theme-alpine">

        </div>
    </div>
</div>
<script>
    const returnString = (params) => params.value;
    class ClassBtn {
        init(params) {
            const clbEtprCode = params.data.clbEtprCode;
            const clbConfmAt = params.data.clbConfmAt;
            console.log(clbConfmAt);
            const clbComfmAtWord = ['승인','거절'];
            this.eGui = document.createElement('div');
           if(clbConfmAt == 0){
               this.eGui.innerHTML = `
                        <button class="approve">승인</button>
                        <button class="disapprove">거절</button>
                    `;
               this.id = params.data.notiEtprCode;
               this.approveBtn = this.eGui.querySelector(".approve");
               this.disapproveBtn = this.eGui.querySelector(".disapprove");

               this.approveBtn.onclick = () => {
                   acceptAjax(clbEtprCode,'1');
               };
               this.disapproveBtn.onclick = () => {
                   acceptAjax(clbEtprCode,'2');
               };
           }else if(clbConfmAt == 1 || clbConfmAt == 2){
               this.eGui.innerHTML = `
                    <p class="status">\${clbComfmAtWord[clbConfmAt-1]}</p>
               `;
               const status = this.eGui.querySelector(".status");
               console.log(status);
           }
        }
        getGui() {return this.eGui;}
    }
    /* 검색 */
    const getString = function (param) {
        const str = param;
        return str;
    };
    const StringRenderer = function (params) {
        return getString(params.value);
    };

    function onQuickFilterChanged() {
        gridOptions.api.setQuickFilter(document.getElementById('quickFilter').value);
    }
    function generateRowNumber(params) {
        return params.node.rowIndex + 1;
    }
    function acceptAjax(clbEtprCode,text){
        $.ajax({
            url: `/club/admin/update`,
            type: "PUT",
            data: JSON.stringify({
                clbConfmAt: text,
                clbEtprCode: clbEtprCode
            }),
            contentType: "application/json; charset=utf-8",
            success: function (data) {
                window.location.href = "/club/admin/proposalList";
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    }
    let rowData = [];
    const columnDefs = [
        {field: "No", headerName: "No",valueGetter: generateRowNumber},
        {field: "clbChirmnEmplId", headerName: "사번"},
        {
            field: "clbNm", headerName: "동호회 이름", getQuickFilterText: (params) => {
                return params.data.clbNm
            },cellRenderer: StringRenderer
        },
        {field: "clbDc", headerName: "동호회 설명",cellRenderer: StringRenderer},
        {field: "clbPsncpa", headerName: "동호회 정원"},
        {field: "clbDate", headerName: "신청 날짜"},
        {field: "chk", headerName: " ", cellRenderer: ClassBtn},
        {field: "clbEtprCode", headerName: "clbEtprCode", hide: true},
        {field: "clbConfmAt", headerName: "clbConfmAt", hide: true,sortable: true},
    ];
    const Options = {
        columnDefs: columnDefs,
        rowData: rowData,
    };
    function customSort(a, b) {
        if (a.clbConfmAt == 0 && b.clbConfmAt != 0) {
            return -1;
        } else if (a.clbConfmAt != 0 && b.clbConfmAt == 0) {
            return 1;
        }
        return 0;
    }
    function loadProposalList(){
        $.ajax({
            url: `/club/admin/proposalList`,
            type: "POST",
            success: function (data) {
                const sortedData = data.sort(customSort);
                Options.api.setRowData(sortedData);
            },
            error: function (request, status, error) {
                console.log("code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error);
            }
        })
    }
    document.addEventListener('DOMContentLoaded', () => {
        const listGrid = document.querySelector('#listGrid');
        loadProposalList();
        new agGrid.Grid(listGrid, Options);
    });
</script>

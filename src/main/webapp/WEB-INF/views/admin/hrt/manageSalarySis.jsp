<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<script src="https://code.jquery.com/jquery-3.6.0.slim.min.js"></script>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
    #myGrid {width: 100%; height: calc((360 / 1080) * 100vh);}
</style>
<h1 class="tab">기본 급여 및 공제 관리</h1>
<br /><br />

<h2>급여 기본 설정</h2>
<button id="saveSalary">저장하기</button>
<div id="myGrid" class="ag-theme-alpine" ></div>

<br /><hr /><br />
<h2>공제 기본 설정</h2>
<form action="">
    <button id="saveSis">저장하기</button>
    <table border=" 1" >
        <tr>
            <th>국민연금</th>
            <td>요율</td>
            <td>
                개인부담분 :
                <input type="text" id="sisNpPersonal">
                회사부담분 :
                <input type="text" id="sisNpComp">
            </td>
        </tr>
        <tr>
            <th>국민연금</th>
            <td>요율</td>
            <td>
                개인부담분 :
                <input type="text" id="sisHiPersonal">
                회사부담분 :
                <input type="text" id="sisHiComp">
            </td>
        </tr>
        <tr>
            <th>고용보험</th>
            <td>요율</td>
            <td>
                개인부담분 :
                <input type="text" id="sisEiPersonal">
                회사부담분 :
                <input type="text" id="sisEiComp">
            </td>
        </tr>
        <tr>
            <th>산재보험</th>
            <td>요율</td>
            <td>
                회사부담분 :
                <input type="text" id="sisWci">
            </td>
        </tr>
    </table>
    <br /><hr /><br />
    <h2>소득세 설정</h2>
</form>
<form action="">
    <button id="saveIncmtax">저장하기</button>
    <table border=" 1" >
        <tr>
            <th>소득세</th>
            <td>
                <input type="text" id="incmtaxIncmtax">%
            </td>
        </tr>
        <tr>
            <th>지방소득세</th>
            <td>
                <input type="text" id="incmtaxLocalityIncmtax">%
            </td>
        </tr>
    </table>
</form>
<script>
    let saveList = [];
    function getAllData() {
        const rowData = gridOptions.api.forEachNode((obj,idx)=>{
            saveList.push( obj.data);
        });
    }
    function saveDataToServer() {
        getAllData();
        const url = undefined;/* 매핑 url 쓰셈*/
        const requestData = JSON.stringify({ saveList });
        ajaxFn(url,requestData);
    }
    function ajaxFn(url,item){
        fetch(url, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: requestData = item,
        })
            .then((response) => {
                if (response.ok) {
                    return response.json();
                } else {
                    throw new Error('Failed to save data');
                }
            })
            .then((data) => {
                console.log('Server response:', data);
            })
            .catch((error) => {
                console.error('Error:', error);
            });
    }
    const saveSalary = document.getElementById('saveSalary');
    saveSalary.addEventListener('click', () => {
        saveDataToServer();
    });


    /*그냥 확인하라고 넣음*/
    const columnDefs = [
        { headerName: '(만원)', field: 'category' },
        { field: "DEPT010",  headerName:"인사팀",editable: true},
        { field: "DEPT011",  headerName:"회계팀",editable: true},
        { field: "DEPT012", headerName:"영업팀",editable: true},
        { field: "DEPT013", headerName:"홍보팀",editable: true},
        { field: "DEPT014", headerName:"총무팀",editable: true}
    ];
    let rowData = [
        { DEPT010: 5,DEPT011: 1,DEPT012:10, DEPT013:50, DEPT014:100,category:"사원"},
        { DEPT010: 5,DEPT011: 1,DEPT012:10, DEPT013:50, DEPT014:100,category:"대리"},
        { DEPT010: 5,DEPT011: 1,DEPT012:10, DEPT013:50, DEPT014:100,category:"과장"},
        { DEPT010: 5,DEPT011: 1,DEPT012:10, DEPT013:50, DEPT014:100,category:"차장"},
        { DEPT010: 5,DEPT011: 1,DEPT012:10, DEPT013:50, DEPT014:100,category:"팀장"},
        { DEPT010: 5,DEPT011: 1,DEPT012:10, DEPT013:50, DEPT014:100,category:"부장"}
    ];

    const gridOptions = {
        columnDefs: columnDefs,
        rowData: rowData,
    };
    /* 실제 불러올 때 -> ajax가 있고 foreach로 불러오는거 있음 선택하셈 */

    document.addEventListener('DOMContentLoaded', () => {
        const gridDiv = document.querySelector('#myGrid');
        new agGrid.Grid(gridDiv, gridOptions);
    });
</script>
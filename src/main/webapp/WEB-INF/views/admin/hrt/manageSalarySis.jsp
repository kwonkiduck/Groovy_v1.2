<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script defer src="https://unpkg.com/ag-grid-community/dist/ag-grid-community.min.js"></script>
<style>
    #myGrid {width: 100%; height: calc((360 / 1080) * 100vh);}
    #table {width: 100%; height: calc((360 / 1080) * 100vh);}
    #empl {display: block; width: 100; height: 100%; text-align: center;}
    #pay {display: block;}
</style>
<h1 class="tab">기본 급여 및 공제 관리</h1>
<br /><br />

<h2>급여 기본 설정</h2>
<button id="saveSalary">저장하기</button>
<form action="manageSalarySis.jsp" method="post">
    <table border="1" id="table">
    	<thead id="deptName">
    		<tr>
    			<th></th>
    			<th></th>
    			<th></th>
    			<th></th>
    			<th></th>
    			<th></th>
    		</tr>
    	</thead>
			<tr>
				<td id="empl"></td>
				<td><input type="text" id="pay" name=""/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
			</tr>
			<tr>
				<td id="empl"></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
			</tr>
			<tr>
				<td id="empl"></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
			</tr>
			<tr>
				<td id="empl"></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
			</tr>
			<tr>	
				<td id="empl"></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
			</tr>
			<tr>	
				<td id="empl"></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
			</tr>
			<tr>
				<td id="empl"></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
				<td><input type="text" id="pay"/></td>
			</tr>
	</table>
</form>
<div id="myGrid" class="ag-theme-alpine" ></div>

<br /><hr /><br />
<h2>공제 기본 설정</h2>
<form action="">
    <button id="saveSis">저장하기</button>
    <table border="1" >
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
	const deptName = document.querySelector("#deptName");
    deptName = function fAjax(){
        let xhr = new XMLHttpRequest();
        xhr.open("get", "/admin/hrt/manageSalarySis", true);
        xhr.onreadystatechange = function(){
            if (xhr.readyState == 4 && xhr.status == 200){
            	const dept = JSON.parse(xhr.responseText);
                console.log("값이 json으로 들어오니? ", dept);
            }
            document.addEventListener("DOMContentLoaded", function() {
                fAjax();
            });
        }
        xhr.send();
    }																																																			
/* 실제 불러올 때 -> ajax가 있고 foreach로 불러오는거 있음 선택하셈 */
</script>
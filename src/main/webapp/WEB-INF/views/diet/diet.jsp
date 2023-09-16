<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>

<script type="text/javascript">
    
    $(document).ready(function() {
      var msg = "${map.msg}";
        if(msg != "") alert(msg);
    });
    
    function _onSubmit(){
        
        if($("#file").val() == ""){
            alert("파일을 업로드해주세요.");
            $("#file").focus();
            return false;
        }
        
        if(!confirm(gTxt("confirm.save"))){
            return false;
        }
        
        return true;
    }
    
</script>

</head>
<body>

<h1>식단</h1>
<div>
    <form name="inputForm" method="post" action="dietMain" enctype="multipart/form-data"> 
    	<input type="file" name="file" id="file" accept=".xlsx, .xls"/>
        <input type="submit" value="엑셀파일 업로드" />
    </form>
</div>

</body>
</html>
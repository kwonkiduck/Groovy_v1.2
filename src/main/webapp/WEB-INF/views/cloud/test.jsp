<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>파일 업로드 테스트</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.3.1.js" integrity="sha256-2Kok7MbOyxpgUVvAk/HJ2jigOSYS2auK4Pfzbm7uH60=" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</head>
<body>
    <h1>S3 이미지 업로더</h1>
    <div class="col-md-12">
        <div class="col-md-2">
            <form id="upload-form" enctype="multipart/form-data">
                <div class="form-group">
                    <label for="img">파일 업로드</label>
                    <input type="file" id="img" name="data" />
                </div>
                <button type="button" class="btn btn-primary" id="btn-save">저장</button>
            </form>
        </div>
        <div class="col-md-10">
            <p><strong>결과 이미지!!</strong></p>
            <img src="" id="result-image"/>
        </div>
    </div>
    <script type="text/javascript">
        $('#btn-save').on('click', uploadImage);

        function uploadImage() {
            let file = $('#img')[0].files[0];
            let formData = new FormData();
            formData.append('data', file);

            $.ajax({
                type: 'POST',
                url: '/cloud/upload', // 수정된 경로
                data: formData,
                contentType: false,
                processData: false
            }).done(function (data) {
                $('#result-image').attr('src', data);
            }).fail(function (error) {
                alert("에러발생 에러발생 !!!" + error);
            });
        }
    </script>
</body>
</html>
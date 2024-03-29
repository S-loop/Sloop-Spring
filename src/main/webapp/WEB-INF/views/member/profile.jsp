<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<html lang="en">
<head>
    <title>파일업로드예제</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>

<div class="container">
    <h2>파일업로드</h2>


    <form name="dataForm" id="dataForm" onsubmit="return registerAction()">

        <div>
            <h3>변경하려는 자</h3>
            <p>번호 = ${member.memberIdx}</p>
        </div>
        <div class='uploadResult'>
            <ul>

            </ul>
        </div>
        <button id="btn-upload" type="button" style="border: 1px solid #ddd; outline: none;">파일 추가</button>

        <input id="input_file" multiple="multiple" type="file" style="display:none;">
        <span style="font-size:10px; color: gray;">※첨부파일은 최대 10개까지 등록이 가능합니다.</span>

        <div class="data_file_txt" id="data_file_txt" style="margin:40px;">
            <span>첨부 파일</span>
            <br />
            <div id="articlefileChange">
            </div>
        </div>

        <button type="submit" style="border: 1px solid #ddd; outline: none;">전송</button>
    </form>
</div>


<!-- 파일 업로드 스크립트 -->
<script>
    $(document).ready(function()
        // input file 파일 첨부시 fileCheck 함수 실행
    {
        $("#input_file").on("change", fileCheck);

    });


    /**
     * 첨부파일로직
     */

    $('#btn-upload').click(function (e) {
        e.preventDefault();
        $('#input_file').click();
    });

    // 파일 현재 필드 숫자 totalCount랑 비교값
    let fileCount = 0;
    // 해당 숫자를 수정하여 전체 업로드 갯수를 정한다.
    let totalCount = 10;
    // 파일 고유넘버
    let fileNum = 0;
    // 첨부파일 배열
    let content_files = new Array();

    // 파일 개수와 크기 검토 및 화면에 출력(업로드한 파일 목록 영역에)
    function fileCheck(e) {
        var files = e.target.files;

        // 파일 배열 담기
        var filesArr = Array.prototype.slice.call(files);

        // 파일 개수 확인 및 제한
        if (fileCount + filesArr.length > totalCount) {
            $.alert('파일은 최대 '+totalCount+'개까지 업로드 할 수 있습니다.');
            return;
        } else {
            fileCount = fileCount + filesArr.length;
        }

        // 각각의 파일 배열담기 및 기타
        filesArr.forEach(function (f) {
            let reader = new FileReader();
            reader.onload = function (e) {
                // 파일 크기 검사 (25MB 미만만 업로드 가능)
                if (f.size >= 26214400){
                    alert("25MB 미만 파일만 첨부할 수 있습니다.");
                    return;
                }
                content_files.push(f);

                // 화면에 출력
                $('#articlefileChange').append(
                    '<div id="file' + fileNum + '" onclick="fileDelete(\'file' + fileNum + '\')">'
                    + '<font style="font-size:12px">' + f.name + '</font>'
                    + '<img src="../resources/images/x-button.png" style="width:20px; height:auto; vertical-align: middle; cursor: pointer;"/>'
                    + '<div/>'
                );
                fileNum ++;
            };
            reader.readAsDataURL(f);
        });
        $("#input_file").val("");
    }

    // 파일 부분 삭제 함수
    function fileDelete(fileNum){
        var no = fileNum.replace(/[^0-9]/g, "");
        content_files[no].is_delete = true;
        $('#' + fileNum).remove();
        fileCount --;
        console.log(content_files);
    }

    /*
     * 폼 submit 로직
     */
    function registerAction(){
        let status = false;

        let form = $("form")[0];
        let formData = new FormData(form);
        for (let x = 0; x < content_files.length; x++) {
            // 삭제 안한것만 담아 준다.
            if(!content_files[x].is_delete){
                formData.append("memberProfile", content_files[x]);
            }
        }
        /*
        * 파일업로드 multiple ajax처리
        */
        $.ajax({
            type: "POST",
            enctype: "multipart/form-data",
            url: "/member/profile",
            data : formData,
            processData: false,
            contentType: false,
            success: function (data) {
                console.log(data);
                if(JSON.parse(data)['result'] == "FAIL"){
                    alert("파일업로드 실패! 확장자를 확인해주세요.");
                    return ;

                } else if (JSON.parse(data)['result'] == "ok"){
                    alert("업로드 성공!");
                    location.href = "/member/home";
                } return;
            },
            error: function (xhr, status, error) {
                alert("서버오류로 지연되고있습니다. 잠시 후 다시 시도해주시기 바랍니다.");
                return false;
            }
        });

        return false;
    }
</script>
</body>
</html>
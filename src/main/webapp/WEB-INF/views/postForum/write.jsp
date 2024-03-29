<%--
  Created by IntelliJ IDEA.
  User: thegreatjy
  Date: 12/25/23
  Time: 4:20 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link href="/resources/css/style_post.css" rel="stylesheet">
<link href="/resources/css/style_studygroup_daily.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.7.1.slim.js"
        integrity="sha256-UgvvN8vBkgO0luPSUl2s8TIlOSYRoGFAX4jlCIm9Adc=" crossorigin="anonymous"></script>
<script src="/resources/ckeditor/ckeditor.js"></script>

<main class="col-md-9 ms-sm-auto col-lg-10 px-md-4">
    <div class="container-studyGroup">
        <div class="box-size contents_wrapper">
            <!-- 글 작성 화면 -->
            <div class="mb-3" style="margin-top:30px;">
                <%--@elvariable id="postForumDTO" type="kr.co.sloop.postForum.domain.PostForumDTO"--%>
                <form:form modelAttribute="postForumDTO" method="post" action="./write">
                    <!-- 카테고리 -->
                    <div class="CategoryList">카테고리 :
                    <form:radiobutton class="form-check-input" path="categoryPostIdx" id="categoryPostDaily" name="categoryPostIdx" value="1"/>
                    <label for="categoryPostDaily">일상</label>

                    <form:radiobutton class="form-check-input" path="categoryPostIdx" id="categoryPostHobby" name="categoryPostIdx" value="2"/>
                    <label for="categoryPostDaily">취미</label>

                    <form:radiobutton class="form-check-input" path="categoryPostIdx" id="categoryPostWorry" name="categoryPostIdx" value="3"/>
                    <label for="categoryPostDaily">고민</label>

                    <form:radiobutton class="form-check-input" path="categoryPostIdx" id="categoryPostCareer" name="categoryPostIdx" value="4"/>
                    <label for="categoryPostDaily">진로</label>
                    </div><!--카테고리-->


                    <!-- 글 제목 -->
                    <p><form:input class="form-control" path="postForumTitle" autofocus="true" placeholder="제목"/></p>
                    <p><form:errors path="postForumTitle"/></p>


                    <!-- 글 내용 (에디터) -->
                    <p><form:textarea path="postForumContents" class="form-control" id="postForumContents"
                                      name="postForumContents" rows="3"></form:textarea></p>
                    <p><form:errors path="postForumContents"/></p>
                    <script>
                        var ckeditor_config = {
                            width: "100%",
                            height: "400px",
                            image_previewText: '',
                            resize_enabled: false,
                            enterMode: CKEDITOR.ENTER_BR,
                            shiftEnterMode: CKEDITOR.ENTER_P,
                            filebrowserUploadUrl: "./upload-image"
                        };

                        CKEDITOR.replace("postForumContents", ckeditor_config);

                        // 이미지 업로드가 끝나고 실행하는 함수
                        CKEDITOR.on('dialogDefinition', function (ev) {
                            // Take the dialog name and its definition from the event data.
                            let dialogName = ev.data.name;
                            let dialogDefinition = ev.data.definition;

                            let uploadTab = dialogDefinition.getContents('Upload');
                            let uploadButton = uploadTab.get('uploadButton');

                            uploadButton['filebrowser']['onSelect'] = function (fileUrl, errorMessage) {

                            }

                        });
                    </script>

                    <!-- 작성하기 버튼 -->
                    <section class="writeSection">
                    <input class="btn_write" type="submit" value="작성하기">
                    </section>

                </form:form>
            </div>
        </div>
    </div>
</main>

package kr.co.sloop.daily.domain;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class FileUploadDTO {
    //변수
    private String uuid;      //pk
    private String fileName;  //실제파일명
    private boolean img;      //이미지 존재 유무

    //이미지 파일 경로 가져오기
    public String getLink(){
        if(img) {
            return "s_" + uuid + "_" + fileName;
        }else {
            return "noImage.png";
        }
    }
}
package kr.co.groovy.file;

import kr.co.groovy.vo.UploadFileVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.Map;

@Mapper
public interface FileMapper {
    UploadFileVO downloadFile (int uploadFileSn);
    void uploadFile(Map<String, Object> map);
}

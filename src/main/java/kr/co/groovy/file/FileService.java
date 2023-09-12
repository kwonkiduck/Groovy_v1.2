package kr.co.groovy.file;

import kr.co.groovy.vo.UploadFileVO;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class FileService {
    final
    FileMapper mapper;

    public FileService(FileMapper mapper) {
        this.mapper = mapper;
    }

    UploadFileVO downloadFile(int uploadFileSn) {
        return mapper.downloadFile(uploadFileSn);
    }

    void uploadFile(Map<String, Object> map) {
        mapper.uploadFile(map);
    }

}

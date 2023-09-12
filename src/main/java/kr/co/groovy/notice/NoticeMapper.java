package kr.co.groovy.notice;

import kr.co.groovy.vo.NoticeVO;
import kr.co.groovy.vo.UploadFileVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface NoticeMapper {
    List<NoticeVO> loadNoticeList();

    List<NoticeVO> findNotice(Map<String, Object> paramMap);

    NoticeVO loadNoticeDetail(String notiSeq);

    List<UploadFileVO> loadNotiFiles(String notiEtprCode);

    UploadFileVO downloadNotiFile(int uploadFileSn);

    void modifyNoticeView(String notiEtprCode);


    void inputNotice(NoticeVO vo);

    int getNotiSeq();

    void uploadNoticeFile(Map<String, Object> map);

    void deleteNotice(String notiEtprCode);

}

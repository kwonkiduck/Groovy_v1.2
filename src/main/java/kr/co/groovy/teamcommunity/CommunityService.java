package kr.co.groovy.teamcommunity;

import kr.co.groovy.vo.AnswerVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.RecomendVO;
import kr.co.groovy.vo.SntncVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

@Slf4j
@Service
public class CommunityService {
    final CommunityMapper mapper;
    final String uploadPath;

    public CommunityService(CommunityMapper mapper, String uploadPath) {
        this.mapper = mapper;
        this.uploadPath = uploadPath;
    }
    public void inputPost(SntncVO vo, MultipartFile postFile) throws IOException {
        /* sntncEtprCode */
        String sntncEtprCode = makeSntncEtprCode();
        vo.setSntncEtprCode(sntncEtprCode);
        mapper.inputPost(vo);
        boolean hasFile = postFile.isEmpty();
        log.info(postFile + "");
        if(postFile!= null && postFile.getSize() != 0 && !postFile.getName().equals("")){
            String path = uploadPath + "/teamCommunity";
            log.debug("path: " + path);
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                if (uploadDir.mkdirs()) {
                    log.info("폴더 생성 성공");
                } else {
                    log.info("폴더 생성 실패");
                }
            }

            String originalFileName = postFile.getOriginalFilename();
            String extension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
            String newFileName = UUID.randomUUID() + "." + extension;

            File saveFile = new File(path, newFileName);
            postFile.transferTo(saveFile);

            long fileSize = postFile.getSize();
            HashMap<String, Object> map = new HashMap<>();
            map.put("sntncEtprCode", sntncEtprCode);
            map.put("originalFileName", originalFileName);
            map.put("newFileName", newFileName);
            map.put("fileSize", fileSize);
            log.info(String.valueOf(map));

            mapper.uploadPostFile(map);
        }


    }
    public void inputTeamNoti(Map<String, Object> map){
        /* sntncEtprCode */
        String sntncEtprCode = makeSntncEtprCode();
        map.put("sntncEtprCode",sntncEtprCode);
        log.info("service Map => " + map);
        mapper.inputTeamNoti(map);
    }
    public List<SntncVO> loadTeamNoti(String emplId){return mapper.loadTeamNoti(emplId);}
    public void modifyTeamNoti(Map<String, Object> map){mapper.modifyTeamNoti(map);}
    public List<SntncVO> loadPost(String emplId){
        return mapper.loadPost(emplId);
    };
    public int modifyPost(Map<String, Object> map){return mapper.modifyPost(map);};
    public void deletePost(Map<String, Object> map){mapper.deletePost(map);}
    /*public List<RecomendVO> loadRecomend(String emplId){return mapper.loadRecomend(emplId);}*/
    public int loadRecomend(String sntncEtprCode){return mapper.loadRecomend(sntncEtprCode);}
    public int findRecomend(HashMap<String, Object> map) {return mapper.findRecomend(map);}

    public void inputRecomend(RecomendVO vo){ mapper.inputRecomend(vo);}
    public void deleteRecomend(RecomendVO vo){ mapper.deleteRecomend(vo);}
    public List<EmployeeVO> loadEmpl(String emplId){return mapper.loadEmpl(emplId);}
    /*  댓글  */
    public void inputAnswer(Map<String, Object> map){mapper.inputAnswer(map);}
    public int loadAnswerCnt(String sntncEtprCode){return mapper.loadAnswerCnt(sntncEtprCode);}
    public List<AnswerVO> loadAnswer(String sntncEtprCode){return mapper.loadAnswer(sntncEtprCode);}

    public String makeSntncEtprCode(){
        int postSeq = mapper.getSeq();
        /*'SNTNC-'||SNTNC_SEQ.nextval||'-'||TO_CHAR(sysdate,'yyyyMMdd')*/
        // 현재 날짜 구하기
        Date now = new Date();
        // 날짜 포맷팅
        SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
        String nowDate = format.format(now);

        String sntncEtprCode = "SNTNC-" + postSeq + "-" + nowDate;
        return sntncEtprCode;
    }
}

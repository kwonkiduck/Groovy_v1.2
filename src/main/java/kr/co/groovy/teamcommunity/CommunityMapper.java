package kr.co.groovy.teamcommunity;

import kr.co.groovy.vo.*;
import org.apache.ibatis.annotations.Mapper;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Mapper
public interface CommunityMapper {
    void inputPost(SntncVO vo);

    int getSeq();
    void uploadPostFile(Map<String, Object> map);
    int modifyPost(Map<String, Object> map);
    void deletePost(Map<String, Object> map);
    List<SntncVO> loadPost(String emplId);
    List<EmployeeVO> loadEmpl(String emplId);
    int loadRecomend(String sntncEtprCode);
    int findRecomend(HashMap<String, Object> map);

    void inputRecomend(RecomendVO vo);
    void deleteRecomend(RecomendVO vo);
    /*  댓글  */
    void inputAnswer(Map<String, Object> map);
    int loadAnswerCnt(String sntncEtprCode);
    List<AnswerVO> loadAnswer(String sntncEtprCode);

    void inputTeamNoti(Map<String, Object> map);
    List<SntncVO> loadTeamNoti(String emplId);
    void modifyTeamNoti(Map<String, Object> map);
    void deleteTeamNoti(Map<String, Object> map);
}

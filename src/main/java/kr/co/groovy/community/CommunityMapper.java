package kr.co.groovy.community;

import kr.co.groovy.vo.*;
import org.apache.ibatis.annotations.Mapper;

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
    int loadRecommend(String sntncEtprCode);
    int findRecommend(Map<String, Object> map);

    void inputRecommend(RecommendVO vo);
    void deleteRecommend(RecommendVO vo);
    /*  댓글  */
    void inputAnswer(Map<String, Object> map);
    int loadAnswerCnt(String sntncEtprCode);
    List<AnswerVO> loadAnswer(String sntncEtprCode);

    void inputTeamNoti(Map<String, Object> map);
    List<SntncVO> loadTeamNoti(String emplId);
    void modifyTeamNoti(Map<String, Object> map);
    void deleteTeamNoti(Map<String, Object> map);

    /*  투표  */
    List<VoteRegisterVO> loadAllRegistVote(String emplId);
    List<VoteOptionVO> loadVoteOption(Map<String, Object> map);
    void inputVote(Map<String, Object> map);
    void deleteVote(Map<String, Object> map);
    int inputVoteRegist(VoteRegisterVO vo);
    int inputVoteOptions(VoteOptionVO vo);
    void updateVoteRegistAt(String voteRegistNo);
    int getVoteSeq();

    void updateVoteRegistAtFromDate(Map<String, Object> map);
}

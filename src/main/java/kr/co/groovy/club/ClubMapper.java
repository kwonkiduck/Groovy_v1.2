package kr.co.groovy.club;

import kr.co.groovy.vo.ClubVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface ClubMapper {
    List<ClubVO> loadAllClub(String clbConfmAt);
    List<ClubVO> loadClub(Map<String, Object> map);
    List<ClubVO> loadProposalList();
    List<ClubVO> loadRegistList();
    int getSeq();
    void inputClub(Map<String, Object> map);
    void updateClubAt(Map<String, Object> map);
    void inputClubMbr(Map<String, Object> map);
    void deleteClubMbr(Map<String, Object> map);
}

package kr.co.groovy.sanction;

import kr.co.groovy.vo.*;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.parameters.P;

import java.util.List;
import java.util.Map;

@Mapper
public interface SanctionMapper {

    SanctionFormatVO loadFormat(String format);

    String getSeq(String formatSanctnKnd);

    int getStatus(@Param("elctrnSanctnDrftEmplId") String elctrnSanctnDrftEmplId, @Param("commonCodeSanctProgrs") String commonCodeSanctProgrs);

    List<SanctionVO> loadRequest(@Param("elctrnSanctnDrftEmplId") String emplId);

    void inputSanction(SanctionVO vo);

    void inputLine(SanctionLineVO vo);

    void inputRefrn(ReferenceVO vo);

    /* 결재 문서 불러오기 */

    List<SanctionLineVO> loadAwaiting(@Param("emplId") String emplId);

    List<SanctionLineVO> loadLine(String elctrnSanctnEtprCode);

    List<ReferenceVO> loadRefrn(String elctrnSanctnEtprCode);

    SanctionVO loadSanction(String elctrnSanctnEtprCode);

    UploadFileVO loadSanctionFile(String elctrnSanctnEtprCode);

    /* */

    void approve(String elctrnSanctnemplId);

    void reject(@Param("elctrnSanctnemplId") String elctrnSanctnemplId, @Param("sanctnLineReturnResn") String sanctnLineReturnResn);

    void collect(String elctrnSanctnEtprCode);

    List<EmployeeVO> loadAllLine(@Param("depCode") String depCode, @Param("emplId") String emplId);
    List<SanctionVO> loadReference(String emplId);

}

package kr.co.groovy.sanction;

import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.enums.Department;
import kr.co.groovy.enums.SanctionFormat;
import kr.co.groovy.enums.SanctionProgress;
import kr.co.groovy.utils.ParamMap;
import kr.co.groovy.vo.*;
import lombok.extern.slf4j.Slf4j;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.context.WebApplicationContext;

import java.lang.reflect.Method;
import java.util.List;
import java.util.Map;

@Slf4j
@Service
public class SanctionService {
    final SanctionMapper mapper;
    final WebApplicationContext context;


    public SanctionService(SanctionMapper mapper, WebApplicationContext context) {
        this.mapper = mapper;
        this.context = context;
    }


    public void approve(String elctrnSanctnemplId, String elctrnSanctnEtprCode) {
        mapper.approve(elctrnSanctnemplId, elctrnSanctnEtprCode);
    }
  public void finalApprove(String elctrnSanctnemplId, String elctrnSanctnEtprCode) {
        mapper.finalApprove(elctrnSanctnemplId, elctrnSanctnEtprCode);
    }

    public void reject(String elctrnSanctnemplId, String sanctnLineReturnResn, String elctrnSanctnEtprCode) {
        mapper.reject(elctrnSanctnemplId, sanctnLineReturnResn, elctrnSanctnEtprCode);
    }

    public void collect(String elctrnSanctnEtprCode) {
        mapper.collect(elctrnSanctnEtprCode);
    }


    public void startApprove(@RequestBody Map<String, Object> request) {
        try {
            String approvalType = (String) request.get("approvalType");
            String methodName = (String) request.get("methodName");
            Map<String, Object> parameters = (Map<String, Object>) request.get("parameters");
            Class<?> serviceType = Class.forName(approvalType);
            Object serviceInstance = context.getBean(serviceType);
            Method method = serviceType.getDeclaredMethod(methodName, Map.class);
            method.invoke(serviceInstance, parameters);
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    SanctionFormatVO loadFormat(String format) {
        return mapper.loadFormat(format);
    }

    String getSeq(String formatSanctnKnd) {
        return mapper.getSeq(formatSanctnKnd);
    }


    int getStatus(String elctrnSanctnDrftEmplId, String commonCodeSanctProgrs) {
        return mapper.getStatus(elctrnSanctnDrftEmplId, commonCodeSanctProgrs);
    }

    List<SanctionLineVO> loadAwaiting(String emplId) {
        List<SanctionLineVO> list = mapper.loadAwaiting(emplId);
        for (SanctionLineVO vo : list) {
            vo.setCommonCodeSanctProgrs(SanctionProgress.valueOf(vo.getCommonCodeSanctProgrs()).label());
        }
        return list;
    }

    List<SanctionVO> loadRequest(String emplId) {
        List<SanctionVO> list = mapper.loadRequest(emplId);
        for (SanctionVO vo : list) {
            vo.setElctrnSanctnFormatCode(SanctionFormat.valueOf(vo.getElctrnSanctnFormatCode()).label());
            vo.setCommonCodeSanctProgrs(SanctionProgress.valueOf(vo.getCommonCodeSanctProgrs()).label());
        }

        return list;
    }

    void inputSanction(ParamMap requestData) {
        log.info(String.valueOf(requestData));
        SanctionVO vo = new SanctionVO();
        String etprCode = requestData.getString("etprCode");
        String formatCode = requestData.getString("formatCode");
        String writer = requestData.getString("writer");
        String title = requestData.getString("title");
        String content = requestData.getString("content");

        vo.setElctrnSanctnEtprCode(etprCode);
        vo.setElctrnSanctnFormatCode(formatCode);
        vo.setElctrnSanctnSj(title);
        vo.setElctrnSanctnDc(content);
        vo.setElctrnSanctnDrftEmplId(writer);
        vo.setCommonCodeSanctProgrs("SANCTN010");
        mapper.inputSanction(vo);

        List<String> approverList = requestData.get("approver", List.class);
        log.info(approverList + "");

        if (approverList != null) {
            for (int i = 0; i < approverList.size(); i++) {
                SanctionLineVO lineVO = createSanctionLine(etprCode, approverList.get(i), i, approverList);
                mapper.inputLine(lineVO);
            }
        }

        ReferenceVO referenceVO = new ReferenceVO();
        referenceVO.setElctrnSanctnEtprCode(etprCode);

        List<String> referrerList = requestData.get("referrer", List.class);
        if (referrerList != null) {
            for (String referrer : referrerList) {
                referenceVO.setSanctnRefrnEmplId(referrer);
                mapper.inputRefrn(referenceVO);
            }
        }
    }

    private SanctionLineVO createSanctionLine(String etprCode, String approver, int index, List<String> approverList) {
        SanctionLineVO lineVO = new SanctionLineVO();
        lineVO.setElctrnSanctnEtprCode(etprCode);
        lineVO.setElctrnSanctnemplId(approver);
        lineVO.setSanctnLineOrdr(String.valueOf(index + 1));
        lineVO.setCommonCodeSanctProgrs(index == 0 ? "SANCTN013" : "SANCTN014");
        lineVO.setElctrnSanctnFinalAt(index == approverList.size() - 1 ? "Y" : "N");
        return lineVO;
    }

    public List<SanctionLineVO> loadLine(String elctrnSanctnEtprCode) {
        List<SanctionLineVO> list = mapper.loadLine(elctrnSanctnEtprCode);
        for (SanctionLineVO vo : list) {
            vo.setCommonCodeSanctProgrs(SanctionProgress.valueOf(vo.getCommonCodeSanctProgrs()).label());
            vo.setCommonCodeDept(Department.valueOf(vo.getCommonCodeDept()).label());
            vo.setCommonCodeClsf(ClassOfPosition.valueOf(vo.getCommonCodeClsf()).label());
        }
        return list;
    }

    public List<ReferenceVO> loadRefrn(String elctrnSanctnEtprCode) {
        List<ReferenceVO> list = mapper.loadRefrn(elctrnSanctnEtprCode);
        for (ReferenceVO vo : list) {
            vo.setCommonCodeDept(Department.valueOf(vo.getCommonCodeDept()).label());
            vo.setCommonCodeClsf(ClassOfPosition.valueOf(vo.getCommonCodeClsf()).label());
        }
        return list;
    }

    public SanctionVO loadSanction(String elctrnSanctnEtprCode) {
        SanctionVO vo = mapper.loadSanction(elctrnSanctnEtprCode);
        vo.setElctrnSanctnFormatCode(SanctionFormat.valueOf(vo.getElctrnSanctnFormatCode()).label());
        vo.setCommonCodeSanctProgrs(SanctionProgress.valueOf(vo.getCommonCodeSanctProgrs()).label());
        vo.setCommonCodeDept(Department.valueOf(vo.getCommonCodeDept()).label());
        vo.setCommonCodeClsf(ClassOfPosition.valueOf(vo.getCommonCodeClsf()).label());
        return vo;
    }

    UploadFileVO loadSanctionFile(String elctrnSanctnEtprCode) {
        return mapper.loadSanctionFile(elctrnSanctnEtprCode);
    }

    List<EmployeeVO> loadAllLine(String depCode, String emplId) {
        return mapper.loadAllLine(depCode, emplId);
    }

    List<SanctionVO> loadReference(String emplId){
        List<SanctionVO>list =  mapper.loadReference(emplId);
        for (SanctionVO vo : list) {
            vo.setCommonCodeSanctProgrs(SanctionProgress.valueOf(vo.getCommonCodeSanctProgrs()).label());
        }
        return list;
    }
}


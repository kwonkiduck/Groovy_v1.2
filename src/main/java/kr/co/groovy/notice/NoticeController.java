package kr.co.groovy.notice;

import kr.co.groovy.vo.NoticeVO;
import kr.co.groovy.vo.UploadFileVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Slf4j
@Controller
@RequestMapping("/notice")
public class NoticeController {
    final
    NoticeService service;
    final
    String uploadPath;

    public NoticeController(NoticeService service, String uploadPath) {
        this.service = service;
        this.uploadPath = uploadPath;
    }

    /* 관리자 */
    @GetMapping("/manageNotice")
    public ModelAndView manageNotice(ModelAndView mav) {
        List<NoticeVO> list = service.loadNoticeListForAdmin();
        mav.addObject("notiList", list);
        mav.setViewName("admin/gat/notice/manage");
        return mav;
    }

    @GetMapping("/inputNotice")
    public String inputNoticeForm() {
        return "admin/gat/notice/register";
    }

    @PostMapping("/inputNotice")
    @ResponseBody
    public String inputNotice(NoticeVO vo, MultipartFile[] notiFiles) {
        return service.inputNotice(vo, notiFiles);
    }

    @GetMapping("/detailForAdmin")
    public ModelAndView loadNoticeDetailForAdmin(ModelAndView mav, String notiSeq) {
        NoticeVO vo = service.loadNoticeDetail(notiSeq);
        List<UploadFileVO> list = service.loadNotiFiles(notiSeq);
        mav.addObject("noticeDetail", vo);
        mav.addObject("notiFiles", list);
        mav.setViewName("admin/gat/notice/detail");
        return mav;
    }

    @GetMapping("/deleteNotice")
    public String deleteNotice(String notiEtprCode) {
        service.deleteNotice(notiEtprCode);
        return "redirect:/admin/gat/notice/manage";
    }


    /* 사원 */
    @GetMapping("/loadNoticeList")
    public ModelAndView loadNoticeList(ModelAndView mav) {
        List<NoticeVO> list = service.loadNoticeList();
        mav.addObject("noticeList", list);
        mav.setViewName("common/companyNotice");
        return mav;
    }

    @GetMapping("/findNotice")
    public ModelAndView findNotice(ModelAndView mav, @RequestParam(value = "keyword") String keyword, @RequestParam(value = "sortBy") String sortBy) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("keyword", keyword);
        paramMap.put("sortBy", sortBy);
        List<NoticeVO> list = service.findNotice(paramMap);
        mav.addObject("noticeList", list);
        mav.setViewName("common/companyNotice");
        return mav;
    }

    @GetMapping("/noticeDetail")
    public ModelAndView loadNoticeDetail(ModelAndView mav, String notiEtprCode) {
        service.modifyNoticeView(notiEtprCode);
        NoticeVO vo = service.loadNoticeDetail(notiEtprCode);
        List<UploadFileVO> list = service.loadNotiFiles(notiEtprCode);
        mav.addObject("noticeDetail", vo);
        mav.addObject("notiFiles", list);
        mav.setViewName("common/companyNoticeDetail");
        return mav;
    }


    @GetMapping("/fileDownload")
    public void fileDownload(int uploadFileSn, HttpServletResponse resp) throws Exception {
        try {
            UploadFileVO vo = service.downloadNotiFile(uploadFileSn);
            String originalName = new String(vo.getUploadFileOrginlNm().getBytes("utf-8"), "iso-8859-1");
            String filePath = uploadPath + "/notice";
            String fileName = vo.getUploadFileStreNm();

            File file = new File(filePath, fileName);
            if (!file.isFile()) {
                log.info("파일 없음");
                return;
            }

            resp.setContentType("application/octet-stream");
            resp.setHeader("Content-Disposition", "attachment; filename=\"" + originalName + "\"");
            resp.setHeader("Content-Transfer-Encoding", "binary");
            resp.setContentLength((int) file.length());

            FileInputStream inputStream = new FileInputStream(file);
            OutputStream outputStream = resp.getOutputStream();
            byte[] buffer = new byte[4096];
            int bytesRead = -1;
            while ((bytesRead = inputStream.read(buffer)) != -1) {
                outputStream.write(buffer, 0, bytesRead);
            }
            inputStream.close();
            outputStream.close();
        } catch (IOException e) {
            log.info("파일 다운로드 실패");
        }
    }


}

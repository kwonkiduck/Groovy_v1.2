package kr.co.groovy.main;

import kr.co.groovy.vo.DietVO;
import kr.co.groovy.vo.NoticeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.util.List;

@Slf4j
@Controller
@RequestMapping("/main")
public class MainController {
    final
    MainService service;
    final
    String uploadPath;

    public MainController(MainService service, String uploadPath) {
        this.service = service;
        this.uploadPath = uploadPath;
    }

    @GetMapping(value = "/{today}")
    @ResponseBody
    public DietVO loadMenu(@PathVariable String today) {
        return service.loadDiet(today);
    }

    @GetMapping("/home")
    public String comebackHome() {
        return "main/home";
    }

    @PostMapping("/uploadFile")
    public String uploadFile(MultipartFile defaultFile) {
        try {
            // 혹시 쓸 거면 경로 꼭 수정하기~
            String path = uploadPath + "/profile";
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                if (uploadDir.mkdirs()) {
                    log.info("폴더 생성 성공");
                } else {
                    log.info("폴더 생성 실패");
                }
            }

            String originalFileName = defaultFile.getOriginalFilename();
            File saveFile = new File(path, originalFileName);
            defaultFile.transferTo(saveFile);

            log.info("사진 저장 성공");
            return "redirect:/main/home";
        } catch (Exception e) {
            log.info("사진 저장 실패");
            return null;
        }
    }

    @GetMapping("loadNotice")
    @ResponseBody
    public List<NoticeVO> loadNotice() {
        return service.loadNotice();
    }
}

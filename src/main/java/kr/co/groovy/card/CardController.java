package kr.co.groovy.card;

import kr.co.groovy.vo.CardReservationVO;
import kr.co.groovy.vo.CardVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Slf4j
@Controller
@RequestMapping("/card")
public class CardController {

    private final CardService service;

    public CardController(CardService service) {
        this.service = service;
    }


    @GetMapping("/manage")
    public String manageCard(Model model) {
        List<CardReservationVO> loadCardWaitingList = service.loadCardWaitingList();
        model.addAttribute("loadCardWaitingList", loadCardWaitingList);
        model.addAttribute("waitingListCnt", loadCardWaitingList.size());
        return "admin/at/card/manage";
    }

    @PostMapping("/inputCard")
    @ResponseBody
    public int inputCard(CardVO cardVO) {
        int result = service.inputCard(cardVO);
        return result;
    }

    @GetMapping("/loadAllCard")
    @ResponseBody
    public List<CardVO> loadAllCard() {
        return service.loadAllCard();
    }

    @PostMapping("/modifyCardNm")
    @ResponseBody
    public int modifyCardNm(@RequestBody CardVO cardVO) {
        return service.modifyCardNm(cardVO);
    }

    @GetMapping("/modifyCardStatusDisabled/{cprCardNo}")
    @ResponseBody
    public int modifyCardStatusDisabled(@PathVariable String cprCardNo) {
        return service.modifyCardStatusDisabled(cprCardNo);
    }

    @PostMapping("/assignCard")
    @ResponseBody
    public int assignCard(@RequestBody CardReservationVO cardReservationVO) {
        return service.assignCard(cardReservationVO);
    }

    @GetMapping("/reservationRecords")
    public String manageCardReservationRecords(Model model) {
        List<CardReservationVO> records = service.loadAllResveRecords();
        model.addAttribute("records", records);
        return "admin/at/card/reservationRecords";
    }

    @PostMapping("/returnChecked")
    @ResponseBody
    public int returnChecked(@RequestBody CardReservationVO cardReservationVO) {
        return service.returnChecked(cardReservationVO);
    }

    /* 신청 및 결재 */
    @GetMapping("/request")
    public String requestCard(Model model) {
        List<CardReservationVO> list = service.loadCardRecord();
        model.addAttribute("cardRecord", list);
        return "employee/card/request";
    }

    @PostMapping("/request")
    public String inputRequest(CardReservationVO cardReservationVO) {
        log.info(cardReservationVO.toString());
        service.inputRequest(cardReservationVO);
        int generatedKey = cardReservationVO.getCprCardResveSn();
        return "redirect:/card/detail/" + generatedKey;
    }

    @GetMapping("/detail/{cprCardResveSn}")
    public String loadRequestDetail(@PathVariable int cprCardResveSn, Model model) {
        CardReservationVO vo = service.loadRequestDetail(cprCardResveSn);
        model.addAttribute("detailVO", vo);
        return "employee/card/detail";
    }

    @GetMapping("/data/{cprCardResveSn}")
    @ResponseBody
    public ResponseEntity<CardReservationVO> loadData(@PathVariable int cprCardResveSn) {
        CardReservationVO vo = service.loadRequestDetail(cprCardResveSn);
        log.info(vo.toString());
        return ResponseEntity.ok(vo);
    }
}

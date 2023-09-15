package kr.co.groovy.card;

import kr.co.groovy.vo.CardReservationVO;
import kr.co.groovy.vo.CardVO;
import lombok.extern.slf4j.Slf4j;
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
        log.info("loadCardWaitingList:{}",loadCardWaitingList);
        log.info("loadCardWaitingList:{}",loadCardWaitingList.size());
        return "admin/at/card/manage";
    }

    @PostMapping("/inputCard")
    @ResponseBody
    public int inputCard(CardVO cardVO) {
        log.info("cardVO : {}", cardVO);
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
        log.info("cardRservationVO : {}", cardReservationVO);
        log.info("result : {}", service.assignCard(cardReservationVO));
        return service.assignCard(cardReservationVO);
    }

    @GetMapping("/reservationRecords")
    public String manageCardReservationRecords() {
        return "admin/at/card/reservationRecords";
    }

}

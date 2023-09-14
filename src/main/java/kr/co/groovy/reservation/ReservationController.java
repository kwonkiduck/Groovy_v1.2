package kr.co.groovy.reservation;

import kr.co.groovy.vo.CardVO;
import kr.co.groovy.vo.VehicleVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
@Slf4j
@Controller
@RequestMapping("/reserve")
public class ReservationController {

    final
    ReservationService service;

    public ReservationController(ReservationService service) {
        this.service = service;
    }

    /* 차량 예약 */
    @GetMapping("/manageVehicle")
    public ModelAndView loadReservedAndRegisteredVehicle(ModelAndView mav) {
        List<VehicleVO> allVehicles = service.getAllVehicles();
        List<VehicleVO> todayReservedVehicles = getTodayReservedVehicles();
        mav.addObject("allVehicles", allVehicles);
        mav.addObject("todayReservedVehicles", todayReservedVehicles);
        mav.setViewName("admin/gat/car/manage");
        return mav;
    }

    @GetMapping("/inputVehicle")
    public ModelAndView inputVehicle(ModelAndView mav) {
        mav.setViewName("admin/gat/car/register");
        return mav;
    }

    @PostMapping("/inputVehicle")
    public ModelAndView insertVehicle(VehicleVO vehicleVO, ModelAndView mav) {
        log.info("vehicleVO: " + vehicleVO);
        int count = service.inputVehicle(vehicleVO);
        if (count > 0) {
            mav.setViewName("redirect:/gat/manageVehicle");
        }
        return mav;
    }

    @GetMapping("/loadVehicle")
    public ModelAndView loadVehicle(ModelAndView mav) {
        List<VehicleVO> todayReservedVehicles = getTodayReservedVehicles();
        mav.addObject("todayReservedVehicles", todayReservedVehicles);
        mav.setViewName("admin/gat/car/list");
        return mav;
    }

    private List<VehicleVO> getTodayReservedVehicles() {
        List<VehicleVO> todayReservedVehicles = service.getTodayReservedVehicles();
        for (int i = 0; i < todayReservedVehicles.size(); i++) {
            todayReservedVehicles.get(i).setVhcleResveNo(i + 1);
        }
        return todayReservedVehicles;
    }

    @GetMapping("/manageCard")
    public String manageCard() {
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
        log.info("{}", service.loadAllCard());
        return service.loadAllCard();
    }

    @PostMapping("/modifyCardNm")
    @ResponseBody
    public int modifyCardNm(@RequestBody CardVO cardVO) {
        log.info("cardVO : {}", cardVO);
        return service.modifyCardNm(cardVO);
    }

    @GetMapping("/modifyCardUseAt/{cprCardNo}")
    @ResponseBody
    public int modifyCardUseAt(@PathVariable String cprCardNo) {
        log.info("cprCardNo : {}", cprCardNo);
        return service.modifyCardStatusDisabled(cprCardNo);
    }

    @GetMapping("/manageCardReservationRecords")
    public String manageCardReservationRecords() {
        return "admin/at/card/reservationRecords";
    }

}

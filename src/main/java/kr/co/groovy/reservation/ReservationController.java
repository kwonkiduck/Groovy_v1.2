package kr.co.groovy.reservation;

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
        List<VehicleVO> todayReservedVehicles = service.getTodayReservedVehicles();
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
        int count = service.inputVehicle(vehicleVO);
        if (count > 0) {
            mav.setViewName("redirect:/gat/manageVehicle");
        }
        return mav;
    }

    @PutMapping("/return")
    @ResponseBody
    public String modifyReturnAt(@RequestBody String vhcleResveNo) {
        log.info("vhcleResveNo: " + vhcleResveNo);
        return String.valueOf(service.modifyReturnAt(vhcleResveNo));
    }

    @GetMapping("/loadVehicle")
    public ModelAndView loadVehicle(ModelAndView mav) {
        List<VehicleVO> allReservation = service.getAllReservation();
        mav.addObject("allReservation", allReservation);
        mav.setViewName("admin/gat/car/list");
        return mav;
    }
}

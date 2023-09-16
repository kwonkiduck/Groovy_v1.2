package kr.co.groovy.salary;

import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.enums.Department;
import kr.co.groovy.vo.AnnualSalaryVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.TariffVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SalaryService {
    final
    SalaryMapper mapper;

    public SalaryService(SalaryMapper mapper) {
        this.mapper = mapper;
    }

    List<AnnualSalaryVO> loadSalary(){
        List<AnnualSalaryVO> list = mapper.loadSalary();
        for (AnnualSalaryVO vo : list) {
            vo.setCommonCodeDeptCrsf(Department.valueOf(vo.getCommonCodeDeptCrsf()).label());
        }
        return list;
    }
    List<AnnualSalaryVO> loadBonus(){
        List<AnnualSalaryVO> list = mapper.loadBonus();
        for (AnnualSalaryVO vo : list) {
            vo.setCommonCodeDeptCrsf(ClassOfPosition.valueOf(vo.getCommonCodeDeptCrsf()).label());
        }
        return list;
    }
    List<TariffVO> loadTariff(){
        return mapper.loadTariff();
    }
}

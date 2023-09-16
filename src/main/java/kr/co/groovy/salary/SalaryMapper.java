package kr.co.groovy.salary;

import kr.co.groovy.vo.AnnualSalaryVO;
import kr.co.groovy.vo.TariffVO;

import java.util.List;

public interface SalaryMapper {

    List<AnnualSalaryVO> loadSalary();
    List<AnnualSalaryVO> loadBonus();
    List<TariffVO> loadTariff();
}

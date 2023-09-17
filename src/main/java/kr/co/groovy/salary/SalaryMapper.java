package kr.co.groovy.salary;

import kr.co.groovy.vo.AnnualSalaryVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.SalaryVO;
import kr.co.groovy.vo.TariffVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface SalaryMapper {

    List<AnnualSalaryVO> loadSalary();

    List<AnnualSalaryVO> loadBonus();

    List<TariffVO> loadTariff(@Param("year") String year);

    List<EmployeeVO> loadEmpList();

    List<SalaryVO> loadPaymentList(@Param("emplId") String emplId, @Param("year") String year);
}

package kr.co.groovy.diet;

import java.util.Date;
import java.util.List;

import kr.co.groovy.vo.DietVO;

public interface DietMapper {
	public int insertDiet(DietVO dietVO);
	
	public List<DietVO> getAllDiet();
	
	public Date getOneDiet(Date dietDate);
}

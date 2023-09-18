package kr.co.groovy.diet;

import org.springframework.stereotype.Service;

import kr.co.groovy.vo.DietVO;

@Service
public class DietService {

	final
	DietMapper dietMapper;
	
	public DietService(DietMapper dietMapper) {
		this.dietMapper = dietMapper;
	}
	
	
	public int insertDiet(DietVO dietVO) {
		return dietMapper.insertDiet(dietVO);
	}

}

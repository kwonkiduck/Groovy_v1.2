package kr.co.groovy.salary.manage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class SalaryManageService {

	@Autowired
	private SalaryManageMapper mapper;

	public String clsfCode(String commonCodeClsfAllwnc) {
		return null;
	}
}
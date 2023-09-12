package kr.co.groovy.security;

import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.enums.Department;
import kr.co.groovy.vo.EmployeeVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import java.util.Collection;
import java.util.stream.Collectors;

@Slf4j
public class CustomUser extends User {
    private EmployeeVO employeeVO;

    public CustomUser(String username, String password
            , Collection<? extends GrantedAuthority> authorities) {
        super(username, password, authorities);
    }

    public CustomUser(EmployeeVO employeeVO) {
        super(employeeVO.getEmplId() + "",
                employeeVO.getEmplPassword(),
                employeeVO.getEmployeeAuthVOList().stream()
                          .map(auth -> new SimpleGrantedAuthority(auth.getAuthCode()))
                          .collect(Collectors.toList())
        );
        employeeVO.setCommonCodeClsf(ClassOfPosition.valueOf(employeeVO.getCommonCodeClsf()).label());
        this.employeeVO= employeeVO;

    }

    public void setEmployeeVO(EmployeeVO employeeVO) {
        this.employeeVO = employeeVO;
    }

    public EmployeeVO getEmployeeVO() {
        return employeeVO;
    }
}





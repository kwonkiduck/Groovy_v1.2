package kr.co.groovy.security;

import kr.co.groovy.employee.EmployeeMapper;
import kr.co.groovy.vo.ConnectionLogVO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.net.UnknownHostException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.ArrayList;
import java.util.List;

@Slf4j
public class CustomLoginSuccessHandler extends
        SavedRequestAwareAuthenticationSuccessHandler {
    private final EmployeeMapper mapper;
    InetAddress ip;

    public CustomLoginSuccessHandler(EmployeeMapper mapper) {
        this.mapper = mapper;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request,
                                        HttpServletResponse response, Authentication auth)
            throws ServletException, IOException {

        log.warn("Authentication Successful");

        User customUser = (User) auth.getPrincipal();
        String username = customUser.getUsername();
        log.info("username : " + customUser.getUsername());

        // 아이디 기억하기 쿠키 생성
//        boolean isRememberIdChecked = request.getParameter("rememberId") != null;
//        if (isRememberIdChecked) {
//            Cookie idCookie = new Cookie("emplId", username);
//            idCookie.setMaxAge(60 * 60 * 24 * 7); // 쿠키 유효기간 7일
//            idCookie.setPath("/");
//            response.addCookie(idCookie);
//        }

        // 접속 로그 (+암호화 X)
        /*
        ConnectionLogVO connectionLogVO = new ConnectionLogVO();
        try {
            connectionLogVO.setEmplId(username);
            ip = InetAddress.getLocalHost();
            if (ip != null) {
                connectionLogVO.setConectLogIp(ip.getHostAddress());
                NetworkInterface network = NetworkInterface.getByInetAddress(ip);
                byte[] mac = network.getHardwareAddress();
                log.info(mac+"");
                if (mac != null) {
                    String macAddress = "";
                    for (int i = 0; i < mac.length; i++) {
                        macAddress += (String.format("%02x", mac[i]) + ":");
                    }

                    MessageDigest digest = MessageDigest.getInstance("SHA-256");
                    byte[] encodedHash = digest.digest(macAddress.getBytes());
                    StringBuilder hexString = new StringBuilder(2 * encodedHash.length);

                    for (byte b : encodedHash) {
                        hexString.append(String.format("%02x", b & 0xFF));
                    }   // hexString.toString()


                    connectionLogVO.setConectLogMacadrs(macAddress);
                    log.info(macAddress);
                    mapper.inputConectLog(connectionLogVO);
                }
            }
        } catch (UnknownHostException | SocketException e) {
            log.debug(e.getMessage());
//        } catch (NoSuchAlgorithmException e) {
//            throw new RuntimeException(e);
        }

        // 암호화 끝
        */
        List<String> roleNames = new ArrayList<String>();
        auth.getAuthorities().forEach(authority -> {
            roleNames.add(authority.getAuthority());
        });

        log.info("role : " + roleNames);

        //신입사원(ROLE_NEW)
        if (roleNames.contains("ROLE_NEW")) {
            response.sendRedirect("/employee/initPassword");
        } else {
            response.sendRedirect("/main/home");
        }
        if (!response.isCommitted()) {
            // 리다이렉트 전에 응답이 커밋되지 않았을 경우에만 리다이렉트 수행
            super.onAuthenticationSuccess(request, response, auth);
        }
    }
}




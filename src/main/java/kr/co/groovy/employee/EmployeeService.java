package kr.co.groovy.employee;

import kr.co.groovy.enums.ClassOfPosition;
import kr.co.groovy.enums.Department;
import kr.co.groovy.security.CustomUser;
import kr.co.groovy.vo.ConnectionLogVO;
import kr.co.groovy.vo.EmployeeVO;
import kr.co.groovy.vo.NotificationVO;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.time.LocalDate;
import java.util.*;

@Slf4j
@Service
public class EmployeeService {
    final
    EmployeeMapper mapper;
    final
    BCryptPasswordEncoder encoder;
    final
    String uploadPath;


    public EmployeeService(EmployeeMapper mapper, BCryptPasswordEncoder encoder, String uploadPath) {
        this.mapper = mapper;
        this.encoder = encoder;
        this.uploadPath = uploadPath;
    }

    public EmployeeVO signIn(String emplId) {
        return mapper.signIn(emplId);
    }

    public void initPassword(String emplId, String emplPassword) {
        String encodePw = encoder.encode(emplPassword);
        mapper.initPassword(emplId, encodePw);

/*
        try {
            InetAddress ip = InetAddress.getLocalHost();
            if (ip != null) {
                NetworkInterface network = NetworkInterface.getByInetAddress(ip);
                byte[] mac = network.getHardwareAddress();
                if (mac != null) {
                    // MessageDigest digest = MessageDigest.getInstance("SHA-256");
                    String macAddress = "";
                    for (int i = 0; i < mac.length; i++) {
                        macAddress += (String.format("%02x", mac[i]) + ":");
                    }

                    byte[] encodedHash = digest.digest(macAddress.getBytes());
                    StringBuilder hexString = new StringBuilder(2 * encodedHash.length);

                    for (byte b : encodedHash) {
                        hexString.append(String.format("%02x", b & 0xFF));
                    }
                    String emplMacadrs = hexString.toString();

                    mapper.initMacAddr(macAddress, emplId);
                }
            }
        } catch (UnknownHostException | SocketException e) {
            log.debug(e.getMessage());
//        } catch (NoSuchAlgorithmException e) {
//            throw new RuntimeException(e);
        }*/
    }

    public int countEmp() {
        return mapper.countEmp();
    }

    public void inputEmp(EmployeeVO vo) {
        vo.setEmplPassword(encoder.encode(vo.getEmplPassword()));
        mapper.inputEmp(vo);
    }

    public List<EmployeeVO> loadEmpList() {
        List<EmployeeVO> list = mapper.loadEmpList();
        for (EmployeeVO vo : list) {
            vo.setCommonCodeDept(Department.valueOf(vo.getCommonCodeDept()).label());
            vo.setCommonCodeClsf(ClassOfPosition.valueOf(vo.getCommonCodeClsf()).label());
        }
        return list;
    }

    public List<EmployeeVO> findEmp(String depCode, String emplNm, String sortBy) {
        List<EmployeeVO> list = mapper.findEmp(depCode, emplNm, sortBy);
        for (EmployeeVO vo : list) {
            vo.setCommonCodeDept(Department.valueOf(vo.getCommonCodeDept()).label());
            vo.setCommonCodeClsf(ClassOfPosition.valueOf(vo.getCommonCodeClsf()).label());
        }
        return list;
    }

    public List<EmployeeVO> loadBirthday() {
        return mapper.loadBirthday();
    }

    public EmployeeVO loadEmp(String emplId) {
        return mapper.loadEmp(emplId);
    }

    public EmployeeVO findById(String emplId) {
        return mapper.findById(emplId);
    }

    public String modifyProfile(String emplId, MultipartFile profileFile) {
        try {
            String path = uploadPath + "/profile";
            log.info("profile path: " + path);
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                if (uploadDir.mkdirs()) {
                    log.info("폴더 생성 성공");
                } else {
                    log.info("폴더 생성 실패");
                }
            }

            String originalFileName = profileFile.getOriginalFilename();
            String extension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
            String newFileName = UUID.randomUUID() + "." + extension; // 나중에 처리해도 됨(테스트 기간에는 X)

            File saveFile = new File(path, newFileName);
            profileFile.transferTo(saveFile);

            // 로그인한 유저의 프로필 사진 변수 값 변경
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            EmployeeVO employeeVO = customUser.getEmployeeVO();
            employeeVO.setProflPhotoFileStreNm(newFileName);

            mapper.modifyProfile(emplId, newFileName, originalFileName);
            log.info("프로필 사진 변경 성공");
            return newFileName;
        } catch (Exception e) {
            log.info("프로필 사진 변경 실패");
            return "error";
        }
    }

    public void modifyPassword(String emplId, String emplPassword) {
        String encodePw = encoder.encode(emplPassword);
        mapper.modifyPassword(emplId, encodePw);
    }

    public String modifySign(String emplId, MultipartFile signPhotoFile) {
        try {
            String path = uploadPath + "/sign";
            File uploadDir = new File(path);
            if (!uploadDir.exists()) {
                if (uploadDir.mkdirs()) {
                    log.info("폴더 생성 성공");
                } else {
                    log.info("폴더 생성 실패");
                }
            }

            String originalFileName = signPhotoFile.getOriginalFilename();
            String extension = originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
            String newFileName = UUID.randomUUID() + "." + extension; // 나중에 처리해도 됨(테스트 기간에는 X)

            File saveFile = new File(path, newFileName);
            signPhotoFile.transferTo(saveFile);

            // 로그인한 유저의 서명 사진 변수 값 변경
            Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
            CustomUser customUser = (CustomUser) authentication.getPrincipal();
            EmployeeVO employeeVO = customUser.getEmployeeVO();
            employeeVO.setSignPhotoFileStreNm(newFileName);

            mapper.modifySign(emplId, newFileName, originalFileName);
            log.info("서명 변경 성공");
            return newFileName;
        } catch (Exception e) {
            log.info("서명 변경 실패");
            return "error";
        }
    }

    public NotificationVO getNoticeAt(String emplId) {
        return mapper.getNoticeAt(emplId);
    }

    public void modifyEmp(EmployeeVO vo) {
        vo.setEmplPassword(encoder.encode(vo.getEmplPassword()));
        mapper.modifyEmp(vo);
    }

    public void modifyNoticeAt(NotificationVO vo, String emplId) {
        Map<String, Object> map = new HashMap<>();
        map.put("notificationVO", vo);
        map.put("emplId", emplId);

        // 로그인한 유저의 알림 상태 값 변경
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        CustomUser customUser = (CustomUser) authentication.getPrincipal();
        EmployeeVO employeeVO = customUser.getEmployeeVO();
        employeeVO.setNotificationVO(vo);
        mapper.modifyNoticeAt(map);
    }

//    public void inputConectLog(String emplId){
//        mapper.inputConectLog(emplId);
//    }

    List<ConnectionLogVO> loadConnectionLog(String today) {
        today = String.valueOf(LocalDate.now());
        return mapper.loadConnectionLog(today);
    }

    String findTelNoByEmplId(String emplId) {
        String telNo = mapper.findTelNoByEmplId(emplId);
        if (telNo != null) {
            return "exists";
        } else {
            return "null";
        }
    }

    public void sendMessage(String emplTelno, String password) {
        String hostNameUrl = "https://sens.apigw.ntruss.com";
        String requestUrl = "/sms/v2/services/";
        String requestUrlType = "/messages";
        String accessKey = "fcSixF8BWBoQBG4CFu2e";
        String secretKey = "A130dEIHZXHnlS0xGZrdhyX9ZGxmy17gAfpzvnM4";
        String serviceId = "ncp:sms:kr:276170051339:groovy";
        String method = "POST";
        String timestamp = Long.toString(System.currentTimeMillis());
        requestUrl += serviceId + requestUrlType;
        String apiUrl = hostNameUrl + requestUrl;

        JSONObject bodyJson = new JSONObject();
        JSONObject toJson = new JSONObject();
        JSONArray toArr = new JSONArray();

        toJson.put("to", emplTelno);
        toArr.add(toJson);

        bodyJson.put("type", "SMS");
        bodyJson.put("contentType", "COMM");
        bodyJson.put("from", "01039202239");
        bodyJson.put("content", "[Groovy] 임시 비밀번호는 " + password + "입니다.");
        bodyJson.put("messages", toArr);
        String body = bodyJson.toJSONString();
        log.info(body);

        try {
            URL url = new URL(apiUrl);

            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setUseCaches(false);
            connection.setDoOutput(true);
            connection.setDoInput(true);
            connection.setRequestProperty("content-type", "application/json");
            connection.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            connection.setRequestProperty("x-ncp-iam-access-key", accessKey);
            connection.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            connection.setRequestMethod(method);
            connection.setDoOutput(true);

            DataOutputStream dout = new DataOutputStream(connection.getOutputStream());
            dout.write(body.getBytes());
            dout.flush();
            dout.close();

            int responseCode = connection.getResponseCode();
            BufferedReader br = null;
            log.info("responseCode: " + responseCode);
            if (responseCode == 202) {
                br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            } else {
                br = new BufferedReader(new InputStreamReader(connection.getErrorStream()));
            }

            String inputLine;
            StringBuffer response = new StringBuffer();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();

            log.info(response.toString());
        } catch (Exception e) {
            e.getMessage();
        }
    }

    private String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws InvalidKeyException, NoSuchAlgorithmException {
        String space = " ";
        String newLine = "\n";

        String message = new StringBuilder()
                .append(method)
                .append(space)
                .append(url)
                .append(newLine)
                .append(timestamp)
                .append(newLine)
                .append(accessKey)
                .toString();

        SecretKeySpec signingKey = null;
        String encodeBase64String = null;
        try {
            signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
            Mac mac = Mac.getInstance("HmacSHA256");
            mac.init(signingKey);
            byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
            encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
        } catch (UnsupportedEncodingException e) {
            encodeBase64String = e.toString();
        }
        return encodeBase64String;
    }
}


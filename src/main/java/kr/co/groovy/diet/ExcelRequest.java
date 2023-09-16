package kr.co.groovy.diet;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import org.springframework.web.multipart.MultipartFile;

public class ExcelRequest {
	String uploadSuin;

	public ExcelRequest(String uploadSuin) {
		this.uploadSuin = uploadSuin;
	}
	
	public ExcelRequest() {
	}

	public List<HashMap<String, String>> parseExcelMultiPart(Map<String, MultipartFile> files, 
				String KeyString, int fileKeyParam, String atchFileId, String storePath) throws Exception {
		int fileKey = fileKeyParam;
		List<HashMap<String, String>> list = null;
		
		String storePathString = "";
	    String atchFileIdString = "";
	    
	    if ("".equals(storePath) || storePath == null) {
	        storePathString = uploadSuin;
	    } else {
	        storePathString = uploadSuin+storePath;
	    }
	 
	    if (!"".equals(atchFileId) || atchFileId != null) {
	        atchFileIdString = atchFileId;
	    }
	    
	    File saveFolder = new File(EgovWebUtil.filePathBlackList(storePathString));
	    
	    if (!saveFolder.exists() || saveFolder.isFile()) {
	        saveFolder.mkdirs();
	    }
		
	    Iterator<Entry<String, MultipartFile>> iterator = files.entrySet().iterator();
	    MultipartFile file;
	    String filePath = "";
	    
	    while(iterator.hasNext()) {
	    	Entry<String, MultipartFile> entry = iterator.next();
	    	
	    	file = entry.getValue();
	    	String orginFileName = file.getOriginalFilename();
	    	
	    	if("".equals(orginFileName)) {
	    		continue;
	    	}
	    	
	    	int index = orginFileName.lastIndexOf(".");
	    	String fileExt = orginFileName.substring(index + 1);
	    	String newName = KeyString + fileKey;
	    	
	    	if(!"".equals(orginFileName)) {
	    		filePath = storePathString + File.separator + newName+"."+fileExt;
	    		file.transferTo(new File(EgovWebUtil.filePathBlackList(filePath)));
	    	}
	    	
	    	list = ExcelManagerXlsx.getInstance().getListXlsxRead(filePath);
	    	
	    }
	    
		return list;
	}
	
	
	public static class EgovWebUtil {
        public static String filePathBlackList(String value) {
            String returnValue = value;
            if (returnValue == null || returnValue.trim().equals("")) {
                return "";
            }

            returnValue = returnValue.replaceAll("\\.\\./", ""); 
            returnValue = returnValue.replaceAll("\\.\\.\\\\", "");

            return returnValue;
        }
    }
}
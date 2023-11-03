package com.kr.pub.service;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kr.pub.dto.ImageDTO;

@Service
public class ImageService {
	private static String CURR_IMAGE_REPO_PATH = "C:\\file_repo";
	
	public List<ImageDTO> imageProcess(MultipartHttpServletRequest multipartRequests) throws IOException {
		List<ImageDTO> fileList = new ArrayList<>();
        Iterator<String> fileNames = multipartRequests.getFileNames();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy\\MM\\dd");
        String today = dateFormat.format(new Date());
        
        while (fileNames.hasNext()) {
            String fileName = fileNames.next();
            MultipartFile mFile = multipartRequests.getFile(fileName);
            String originalFileName = mFile.getOriginalFilename(); // 파일명.jpg
            
            String fileExtension = "";
            int lastDotIndex = originalFileName.lastIndexOf(".");
            if (lastDotIndex > 0) {
                fileExtension = originalFileName.substring(lastDotIndex + 1);
            }
            
            String contentType = "image/" + fileExtension;

            if (mFile.getSize() != 0) {
                String uuid = UUID.randomUUID().toString();
                String savePath = CURR_IMAGE_REPO_PATH + "\\" + today;
                String saveFileName = uuid;
                
                File file = new File(savePath, saveFileName);
                
                ImageDTO newFile = ImageDTO.builder()
                		.imgNameOrg(originalFileName)
                		.imgNameReal("\\" + today+ "\\" +saveFileName)
                		.length(mFile.getSize())
                		.contentType(contentType)
                		.build();
                		
                fileList.add(newFile);

                if (!file.exists()) {
                    if (file.getParentFile().mkdirs()) {
                        file.createNewFile();
                    }
                }
                
                System.out.println("originalFileName" + " : " + originalFileName);
                System.out.println("fileNameOrg" + " : " + originalFileName);
                System.out.println("fileNameReal" + " : " + saveFileName);
                System.out.println("length" + " : " + file.length());
                System.out.println("contentType " + fileExtension);
                System.out.println();
                mFile.transferTo(file);
            }
        }
        	return fileList;
	}

}

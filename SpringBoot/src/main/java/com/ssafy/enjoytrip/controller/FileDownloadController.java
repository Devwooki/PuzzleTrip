package com.ssafy.enjoytrip.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.InputStreamResource;
import org.springframework.core.io.Resource;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.net.URLEncoder;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

@RestController
@RequestMapping("/file")
public class FileDownloadController {
    private Logger logger = LoggerFactory.getLogger(FileDownloadController.class);

    @Value("${file.path}")
    private String uploadPath;
    @GetMapping("download/{sFolder}/{oFile}/{sFile}")
    private ResponseEntity<?> download(
            @PathVariable("sFolder")String sFolder,
            @PathVariable("oFile")  String oFile,
            @PathVariable("sFile")  String sFile) throws Exception{
        logger.debug("파일 다운로드 경로 : {}, {}, {}",sFolder, oFile,sFile );
        String file = uploadPath + File.separator + sFolder
                                     + File.separator + sFile;
        logger.debug("파일 다운로드 경로 : {}", file);
        try{
            //서버에 저장된 파일 리소스를 얻는다.
            Path filePath = Paths.get(file);
            Resource resource = new InputStreamResource(Files.newInputStream(filePath));

            //한글파일명과 공백을 처리하기 위해 utf-8로 인코딩을 변경한다.
            HttpHeaders headers = new HttpHeaders();
            headers.setContentDisposition(ContentDisposition.builder("attachment").filename(URLEncoder.encode(oFile, "UTF-8").replaceAll("\\+", "%20")).build());

            headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
            //외부에서도 받을 수 있게 됨
            return new ResponseEntity<Object>(resource, headers, HttpStatus.OK);
        }catch(Exception e){
            e.printStackTrace();
            return new ResponseEntity<Object>(null, HttpStatus.CONFLICT);
        }
    }
}

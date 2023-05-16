package com.ssafy.enjoytrip.controller;

import com.ssafy.enjoytrip.model.attraction.dto.AttractionInfo;
import com.ssafy.enjoytrip.model.attraction.dto.Gugun;
import com.ssafy.enjoytrip.model.attraction.service.AttractionInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;


@RestController
@CrossOrigin("*")
@RequestMapping("/attraction")
public class AttractionController {
    private final AttractionInfoService service;
    private final Logger logger = LoggerFactory.getLogger(AttractionInfoService.class);

    @Autowired
    public AttractionController(AttractionInfoService service) {
        this.service = service;
    }
    @GetMapping("{areaCode}")
    private List<Gugun> getGugun(@PathVariable String areaCode) throws Exception {
        logger.debug("getGugun Sido : {} ", areaCode);
        return service.getGugun(areaCode);
    }

    @PostMapping("lists")
    private List<AttractionInfo> attractionLists(@RequestBody Map<String, Object> paramMap) throws Exception {

        logger.debug("attractionLists : {} ", paramMap);
        String areaCode = (String) paramMap.get("areaCode");
        String gugunCode = (String) paramMap.get("gugunCode");
        String checked = (String) paramMap.get("checked");
        logger.debug("attractionLists : {} ", checked);
        return service.attractionLists(paramMap);
    }


}

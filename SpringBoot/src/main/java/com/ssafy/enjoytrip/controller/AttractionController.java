package com.ssafy.enjoytrip.controller;

import com.ssafy.enjoytrip.attraction.model.dto.AttractionInfo;
import com.ssafy.enjoytrip.attraction.model.dto.Gugun;
import com.ssafy.enjoytrip.attraction.model.service.AttractionInfoService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/attraction")
public class AttractionController {
    private final AttractionInfoService service;
    private final Logger logger = LoggerFactory.getLogger(AttractionInfoService.class);

    @Autowired
    public AttractionController(AttractionInfoService service) {
        this.service = service;
    }

    @GetMapping("searchtrip")
    private String moveSearchTrip() {
        logger.debug("move searchTrip Page");
        return "travel/searchtrip";
    }

    @GetMapping("{areaCode}")
    @ResponseBody
    private List<Gugun> getGugun(@PathVariable String areaCode) throws Exception {
        logger.debug("getGugun Sido : {} ", areaCode);
        return service.getGugun(areaCode);
    }

    @PostMapping("lists")
    @ResponseBody
    private List<AttractionInfo> attractionLists(@RequestBody Map<String, Object> paramMap) throws Exception {

        logger.debug("attractionLists : {} ", paramMap);
        String areaCode = (String) paramMap.get("areaCode");
        String gugunCode = (String) paramMap.get("gugunCode");
        String checked = (String) paramMap.get("checked");
        logger.debug("attractionLists : {} ", checked);
        return service.attractionLists(paramMap);
    }


}

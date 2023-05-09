package com.ssafy.enjoytrip.attraction.model.service;


import com.ssafy.enjoytrip.attraction.model.dto.AttractionInfo;
import com.ssafy.enjoytrip.attraction.model.dto.Gugun;

import java.util.List;
import java.util.Map;

public interface AttractionInfoService {
	List<Gugun> getGugun(String areaCode) throws Exception;
    List<AttractionInfo> attractionLists(Map<String, Object> paramMap) throws Exception;
}

package com.ssafy.enjoytrip.model.attraction.service;


import com.ssafy.enjoytrip.model.attraction.dto.AttractionInfo;
import com.ssafy.enjoytrip.model.attraction.dto.Gugun;

import java.util.List;
import java.util.Map;

public interface AttractionInfoService {
	List<Gugun> getGugun(String areaCode) throws Exception;
    List<AttractionInfo> attractionLists(Map<String, Object> paramMap) throws Exception;
}

package com.ssafy.enjoytrip.attraction.model.service;

import com.ssafy.enjoytrip.attraction.model.dto.AttractionInfo;
import com.ssafy.enjoytrip.attraction.model.dto.Gugun;
import com.ssafy.enjoytrip.attraction.model.mapper.AttractionInfoMapper;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Map;

@Service
public class AttractionInfoServiceImpl implements AttractionInfoService {
	private AttractionInfoMapper attractionInfoMapper;

	public AttractionInfoServiceImpl(AttractionInfoMapper attractionInfoMapper) {
		this.attractionInfoMapper = attractionInfoMapper;
	}

	@Override
	public List<Gugun> getGugun(String areaCode) throws Exception {
		return attractionInfoMapper.selectByAreaCode(areaCode);
	}

	@Override
	public List<AttractionInfo> attractionLists(Map<String, Object> paramMap) throws Exception {
        /* paramMap : {
			areaCode : int,
			gugunCode : int,
			checked : List<String>
		}*/


        //정리
        // contentType 선택된게 없으면 모든 지역 관광지 데이터 받아오고
        // 선택 된게 있으면 선택된 관광지 정보만 받아오게 한다.
        List<String> contentTypes = (List<String>) paramMap.get("contentTypes");

		if(contentTypes.size() == 0) {
            paramMap.remove("contentTypes");//기존 checked는 문자열이라제거
            paramMap.put("contentTypes", null);
        }
		return attractionInfoMapper.selectByAreaCodeGugunCode(paramMap);
	}

}

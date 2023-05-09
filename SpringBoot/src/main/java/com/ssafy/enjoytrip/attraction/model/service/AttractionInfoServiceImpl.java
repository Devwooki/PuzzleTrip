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
			checked : String[]
		}*/
		System.out.println((String)paramMap.get("checked"));
		String[] checked = ((String)paramMap.get("checked")).split(" ");
		System.out.println("@@@@@@@@@@@@@@@" + Arrays.toString(checked) + "," + checked.length + ", checked[0] :" + checked[0]);
		paramMap.remove("checked");//기존 checked는 문자열이라제거
		if(checked[0].equals("")) paramMap.put("checked", null); //" "으로 구분된 String배열로 삽입
		else paramMap.put("checked", checked); //" "으로 구분된 String배열로 삽입
		return attractionInfoMapper.selectByAreaCodeGugunCode(paramMap);
	}

}

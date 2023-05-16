package com.ssafy.enjoytrip.model.attraction.mapper;


import com.ssafy.enjoytrip.model.attraction.dto.AttractionInfo;
import com.ssafy.enjoytrip.model.attraction.dto.Gugun;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface AttractionInfoMapper {
	List<Gugun> selectByAreaCode(String areaCode) throws SQLException;
    List<AttractionInfo> selectByAreaCodeGugunCode(Map<String, Object> paramMap) throws SQLException;

}

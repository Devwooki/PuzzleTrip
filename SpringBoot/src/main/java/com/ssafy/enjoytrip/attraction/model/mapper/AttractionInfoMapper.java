package com.ssafy.enjoytrip.attraction.model.mapper;


import com.ssafy.enjoytrip.attraction.model.dto.AttractionInfo;
import com.ssafy.enjoytrip.attraction.model.dto.Gugun;
import org.apache.ibatis.annotations.Mapper;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

@Mapper
public interface AttractionInfoMapper {
	List<Gugun> selectByAreaCode(String areaCode) throws SQLException;
    List<AttractionInfo> selectByAreaCodeGugunCode(Map<String, Object> paramMap) throws SQLException;

}

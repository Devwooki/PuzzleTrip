package com.ssafy.enjoytrip.attraction.model.dto;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class AttractionInfo {
	private int contentId;
	private int contentTypeId;
	private String title;
	private String addr1;
	private String zipCode;
	private String tel;
    private String firstImage;
    private int readCount;
    private int sidoCode;
    private int gugunCode;
    private String latitude;
    private String longitude;
	private int recommand;

}

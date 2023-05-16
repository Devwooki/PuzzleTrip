package com.ssafy.enjoytrip.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan(basePackages = {"com.ssafy.enjoytrip.**.mapper"})
public class DatabaseConfiguration {}

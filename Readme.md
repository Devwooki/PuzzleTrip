# EnjoyTrip

![main.png](readmeFile%2Fmain.png)

## 프로젝트 개요

공공 데이터를 활용해 지역과 관광지 타입기반 조회 데이터를 활용해
사용자에게 여행지 정보를 제공하는 Web Application

## 왜 Puzzle Trip인가요?
- 퍼즐 조각들이 모여 큰 그림을 그리듯 사용자들에게 크고 작은 기억,추억,경험을 제공하겠다는 의미를 담았습니다.😄


- WD👨🏻‍💻 : `2023.04.26` ~ `2023.05.27`

<br>

## 🤝 collaborator

<table align="center">
    <tr>
      <th style="text-align: center; font-size : 14px;">이OO🤴🏻</th>
      <th style="text-align: center; font-size : 14px;">김OO🤝</th>
    </tr>
    <tr>
        <td height="140px" width="300px" align="center"> 
          <a href="https://github.com/Devwooki">
            <img src="https://avatars.githubusercontent.com/u/70623636?v=4" width="140px" /> 
          </a> 
          <br>
        </td>
        <td height="140px" width="300px" align="center">
          <a href="https://github.com/DongMinE">
            <img src="https://avatars.githubusercontent.com/u/91265819?v=4" width="140px" />
          </a>
          <br>
        </td>
    </tr>
    <tr>
      <td>
        <ul>
          <li>👀 FE
            <br>&nbsp;✅ 게시판, 회원관련 페이지 제작 및 디자인
            <br>&nbsp;✅ Vuex를 통한 상태관리(유저정보, 게시판)
          </li>
          <li>⚙️ BE 마이그레이션 진행
            <br>&nbsp;✅Servelt -> Spring, Spring Boot
          </li>
          <li>🍃 Spring
            <br>&nbsp;✅ REST API로 변환
            <br>&nbsp;✅ 회원정보, 게시판 CRUD 구현
            <br>&nbsp;✅ 파일 업로드 및 이미지 출력
            <br>&nbsp;✅ JWT 로그인 적용
            <br>&nbsp;✅ WebSocket활용 실시간 채팅
            <br>&nbsp;🛠️ 여행정보 CURD 구현
            <br>&nbsp;🛠️ 핫플레이스 CURD 구현
            <br>&nbsp;💭 친구추가 기능
          </li>
          <li> 💾 DB
           <br>&nbsp;✅ 스키마 및 테이블 생성
           <br>&nbsp;✅ MyBatis 적용
          </li>
          <li>☁️ 배포
            <br>&nbsp;✅ DB AWS EC2 배포
            <br>&nbsp;✅ API 서버 AWS EC2 배포
          </li>
        </ul>
      </td>
      <td>
        <ul>
          <li>👀 FE 마이그레이션 진행
            <br>&nbsp;JSP -> Vue2
          </li>
          <li>🗺️ 카카오지도API 활용
            <br>&nbsp;✅ 여행 계획 생성
            <br>&nbsp;✅ 마커를 활용한 지역 관광지 출력
            <br>&nbsp;✅ Vuex를 통한 상태관리(여행 일정 작성 및 마커 관리)
            <br>
          </li>
          <li>🚐 카카오모빌리티 API 활용
            <br>&nbsp;✅ 길찾기 구현 : 마커 기반 출발지, 도착지 이벤트 등록
          </li>
          <li>☀️ OpenWeatherMap AIP 활용
            <br>&nbsp;✅ 지역별 날씨 정보 출력
          </li>
          <li>☀ Dargable AIP 활용
            <br>&nbsp;✅ 상태관리를 활용해 일정 편집, 삭제 기능 구현
          </li>
          <li>✅ 화면 디자인 및 이펙트 생성</li>
        </ul>
      </td>
    </tr>
</table>

## 웹사이트 둘러보기

<details>
    <summary>메인페이지</summary>
    
    준비중.. 영상 업로드 예정
</details>

<details>
    <summary>여행지 검색</summary>
    
    준비중.. 영상 업로드 예정
</details>

<details>
    <summary>여행 계획 작성</summary>
    
    준비중.. 영상 업로드 예정
</details>

<details>
    <summary>게시판</summary>
    
    준비중.. 영상 업로드 예정
</details>

<details>
    <summary>회원정보</summary>
    
    준비중.. 영상 업로드 예정
</details>

<details>
    <summary>실시간 채팅</summary>
    
    준비중.. 영상 업로드 예정
</details>

## ⚒️ 사용 언어 및 프레임워크

### 👀 Front-End

- HTML 5
- CSS
- Vue2
- Vuex
- Vuetify
- Font Awesome

### ⚙️ Back-End

- Java 8
- Spring 5.3
- Spring Boot 2.7
- Maven 4.0
- MyBatis
- MySQL
- AWS EC2

<br>

## 💽 DB스키마

- (준비중)

## 클래스 다이어 그램

- (준비중)

## 🦴프로젝트 구조

<details>
<summary>Spring Server</summary>

```
com
 ㄴssafy
   ├─aop
   ㄴ-enjoytrip
     ├─config
     ├─controller
     ├─exception
     ├─interceptor
     ㄴ-model
       ├─attraction
       │ ├─dto
       │ ├─mapper
       │ ㄴ-service
       ├─board
       │ ├─dto
       │ ├─mapper
       │ ㄴ-service
       ├─JWT
       ├─user
       │ ├─dto
       │ ├─mapper
       │ ㄴ-service
       ㄴ─WSChat
         ├─dto
         ├─mapper
         ㄴ-service
```

</details>

<details>
<summary>Vue</summary>

```
src
 ├─assets
 │ ├─mainSlice
 │ ㄴ-marker
 ├─components
 │ ├─Attraction
 │ ├─Board
 │ ├─Chat
 │ ㄴ-User
 ├─router
 ├─store
 │ ㄴ-modules
 ├─util
 ㄴ-views
   ├─layout
   ├─main
   ㄴ-user
```

</details>

## 📲 Update Log

- [23.05.26] v1.0.0 배포
- [23.06.10] v1.0.1 API서버(Spring) EC2 배포

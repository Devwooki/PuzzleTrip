# EnjoyTrip

## 프로젝트 개요

공공 데이터를 활용해 지역과 관광지 타입기반 조회 데이터를 활용해
사용자에게 여행지 정보를 제공하는 Web Application

- WD👨🏻‍💻 : `2023.04.26` ~ `2023.05.27`

<br>

## 🤝 collaborator

---

<table align="center">
    <tr>
      <th style="text-align: center; font-size : 14px;">이현욱🤴🏻</th>
      <th style="text-align: center; font-size : 14px;">김동민🤝</th>
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
            <br>&nbsp;🛠️ API 서버 AWS EC2 배포
          </li>
        </ul>
      </td>
      <td>
        <ul>
          <li>👀 FE 마이그레이션 진행
            <br>&nbsp;JSP -> Vue2
          </li>
          <li>🗺️ 카카오지도API 활용
            <br>&nbsp;✅ 1. 출발/도착 경유지 출력
            <br>&nbsp;✅ 2. 여행 계획 생성
            <br>&nbsp;⚒️ 
            <br>
          </li>
          <li>✅ 화면 디자인 및 이펙트 생성</li>
        </ul>
      </td>
    </tr>
</table>

## 웹사이트 둘러보기

---

```
Update,,
```

## ⚒️ 사용 언어 및 프레임워크

---

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

---

- 생략

## 클래스 다이어 그램

---

- 생략

## 🦴프로젝트 구조

---

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
---
23.05.26 v1.0.0 배포
23.06.10 v1.0.1 API서버(Spring) EC2 배포

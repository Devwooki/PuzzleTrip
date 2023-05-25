package com.ssafy.enjoytrip.model.JWT;

import com.ssafy.enjoytrip.exception.UnAuthorizedException;
import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jws;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.util.Date;
import java.util.Map;

/*
JWT 구조
aaaa.bbbb.cccc
a : 헤더
 - Type : JWT
 - alg : 해싱 알고리즘 지정, RSA나 SHA256 + salt키 주로 사용
b : payload(내용)
 - 정보를 담을 수 있다. JSON형태,
 - JSON 내부의 각 key-value를 claim이라 지칭한다
 	- 등록된 클레임 : 토큰에 정보를 담기위해 사용, 이름은 이미 정해짐, optional
 	- 공개 클레임 : 충돌방지 -> uri형태
 	- 비공개 클레임 : 서버 <-> 클라이언트간 협의하에 사용되는 이름
c : signature(서명)
 - 헤더 인코딩 값, 정보 인코딩 값을 합친 후 비밀키로 해쉬
* */
@Service
public class JwtServiceImpl implements JwtService {
//https://galid1.tistory.com/755
	public static final Logger logger = LoggerFactory.getLogger(JwtServiceImpl.class);

	private static final String SALT = "ssafySecret";
	private static final int ACCESS_TOKEN_EXPIRE_MINUTES = 1; // 분단위
	private static final int REFRESH_TOKEN_EXPIRE_MINUTES = 2; // 주단위

	@Override
	public <T> String createAccessToken(String key, T data) {
		return create(key, data, "accessToken", 1000 * 120 * ACCESS_TOKEN_EXPIRE_MINUTES);
//테스트용 짧은시간		return create(key, data, "accessToken", 1000 * 10 * ACCESS_TOKEN_EXPIRE_MINUTES);
	}

//	AccessToken에 비해 유효기간을 길게...
	@Override
	public <T> String createRefreshToken(String key, T data) {
		return create(key, data, "refreshToken", 1000 * 60 * 60 * 24 * 7 * REFRESH_TOKEN_EXPIRE_MINUTES);
//테스트용 짧은시간		return create(key, data, "refreshToken", 1000 * 30 * ACCESS_TOKEN_EXPIRE_MINUTES);
	}

	//Token 발급
	/**
	 * key : Claim에 셋팅될 key 값
	 * data : Claim에 셋팅 될 data 값
	 * subject : payload에 sub의 value로 들어갈 subject값
	 * expire : 토큰 유효기간 설정을 위한 값
	 * jwt 토큰의 구성 : header+payload+signature
	 */
	@Override
	public <T> String create(String key, T data, String tokenName, long expire) {
		// Payload 설정 : 생성일 (IssuedAt), 유효기간 (Expiration),
		// 토큰 제목 (Subject), 데이터 (Claim) 등 정보 세팅.
		Claims claims = Jwts.claims()
				// 토큰 제목 설정 ex) access-token, refresh-token
				.setSubject(tokenName)
				// 생성일 설정
				.setIssuedAt(new Date())
				// 만료일 설정 (유효기간)
				.setExpiration(new Date(System.currentTimeMillis() + expire));

		// 저장할 data의 key, value
		claims.put(key, data);

		String jwt = Jwts.builder() //토큰이 만들어진다. 토큰에는 {{헤더.페이로드.시그니처}}형태
				// Header 설정 : 토큰의 타입, 해쉬 알고리즘 정보 세팅.
				.setHeaderParam("typ", "JWT")
				.setClaims(claims)
				// Signature 설정 : secret key를 활용한 암호화.
				.signWith(SignatureAlgorithm.HS256, this.generateKey())//SALT값으로 서명 생성
				.compact(); // 직렬화 처리.

		return jwt;
	}

	// Signature 설정에 들어갈 key 생성.
	private byte[] generateKey() {
		byte[] key = null;
		try {
			// charset 설정 안하면 사용자 플랫폼의 기본 인코딩 설정으로 인코딩 됨.
			key = SALT.getBytes("UTF-8");//인코딩키
		} catch (UnsupportedEncodingException e) {
			if (logger.isInfoEnabled()) {
				e.printStackTrace();
			} else {
				logger.error("Making JWT Key Error ::: {}", e.getMessage());
			}
		}

		return key;
	}

//	전달 받은 토큰이 제대로 생성된것인지 확인 하고 문제가 있다면 UnauthorizedException을 발생.
	@Override
	public boolean checkToken(String jwt) {
		try {
//			Json Web Signature? 서버에서 인증을 근거로 인증정보를 서버의 private key로 서명 한것을 토큰화 한것
//			setSigningKey : JWS 서명 검증을 위한  secret key 세팅
//			parseClaimsJws : 파싱하여 원본 jws 만들기
			Jws<Claims> claims = Jwts.parser()
					.setSigningKey(this.generateKey())
					.parseClaimsJws(jwt);
//			Claims 는 Map의 구현체 형태
			logger.debug("claims: {}", claims);
			return true;
		} catch (Exception e) {
			logger.error(e.getMessage());
			return false;
		}
	}

	//토큰 받아서 정보를 해독한다.
	@Override
	public Map<String, Object> get(String key) {
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();

		//access-token헤더에서 JWT추출
		String jwt = request.getHeader("accessToken");

		//JWT 파싱
		Jws<Claims> claims = null;
		//JWS : JWT에 서명(전자서명)을 담은 객체
		//Calims : JWT페이로드(value)에 저장된 클레임 정보를 담는 객체
		try {
			//access-token 파싱 후 검증 -> payload를 얻음
			claims = Jwts.parser()
					.setSigningKey(SALT.getBytes("UTF-8"))
					.parseClaimsJws(jwt);
		} catch (Exception e) {
			logger.error(e.getMessage());
			throw new UnAuthorizedException();
		}

		//claim에 포함된 값 추출
		Map<String, Object> value = claims.getBody();
		logger.info("value : {}", value);
		return value;
	}

	@Override
	public String getUserId() {
		return (String) this.get("user").get("userid");
	}

}

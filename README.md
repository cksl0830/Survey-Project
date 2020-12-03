# SpringSurvey
스프링 프로젝트

스프링 문법을 이용한 설문조사 사이트 구축

로그인, 회원가입, 설문참여, 설문 추가/삭제(수정기능 없음), 설문 결과 출력, 관리자페이지(사용자 정지기능) 구현

## Spring MVC
 
org.sist.project.controller - url매핑용 컨트롤러 저장  
org.sist.project.domain - 각종 DTO클래스 저장  
org.sist.project.persistence - 각종 DAO인스턴스, 클래스 저장  
org.sist.project.service - 비지니스 로직 구현  

웬만하면 DAO와 Service 클래스는 인터페이스를 만들고 구현하도록 설정



## layout

모든 페이지는 /WEB-INF/view/layout 폴더의 header, footer, layout.jsp 로 구현함

tiles를 사용해 content부분만 구현하도록 설계

## Security

페이지 접근은 Spring Security를 통해 설정.   
관리자는 ROLE_ADMIN  
로그인한 사용자는 ROLE_USER  

### URL별 권한 표시

url | 파일명 | 권한
|---|---|---|
/survey/index | index.jsp | ROLE_USER, ROLE_ADMIN

## 테이블 구조

tbl_member - 사용자(관리자 포함) 정보 저장 테이블  
tbl_auth - 사용자(관리자) 권한 정보 테이블 (ex: user1 - ROLE_USER, admin1 - ROLE_ADMIN)  
tbl_survey - 설문 정보 저장 테이블(시퀀스, 작성자, 제목, 내용, 작성일, 마감일, 상태)   
tbl_survey_item - 설문 항목 저장 테이블 (항목시퀀스, 설문시퀀스, 내용)   
tbl_survey_result - 설문 참여정보 저장 테이블 (참여자 - 설문항목시퀀스, 참여일)  
tbl_reply - 설문에 대한 댓글
tbl_notice - 사용자에게 전달할 알림테이블 (댓글, 설문참여가 발생하면 트리거로 알림 저장) 


## MyBatis

/src/main/resources/mapper폴더 안에 각종 매퍼파일(xml설정파일) 생성  
DAO마다 하나씩 생성  

/src/main/resources 폴더에 mybatis-config.xml 파일 생성후   
```
<typeAliases>
	<package name="org.zerock.domain"/>
</typeAliases>
```
typeAliases에 패키지명 설정해서 사용하도록 설계  

매퍼 파일 namespace 설정은 org.sist.project.mapper.테이블명Mapper 형식으로 사용   
sqlSession.getMapper로 필드에 DAO구현 클래스를 생성후 사용을 권장  

## Spring 에러 조치 방법

java.lang.ClassNotFoundException: org.springframework.web.context.ContextLoaderListener
프로젝트 우클릭 -> Deployment Assembly > Add 버튼 > Java Build Path Entries > Maven Dependencies 선택 > Apply버튼
프로젝트 우클릭 -> Maven > Update Project
가끔식 의미없이 오류가 난다면 run -> runas -> maven clean 후 maven update해보자.

### pom.xml 첫줄 에러

java 버전이 spring설정과 일치하지 않을때 발생, properties에서 1.8로 설정되있는지 확인, JRE system library도 1.8로 되있는지 확인
pom.xml에서 1.8되어있는지 확인 그리고 maven clean 후 update

maven update 수행할 때 마다 1.6으로 수정되는데 영구히 변경하려면 아래처럼 source와 target태그에 1.6으로 되있던 설정을 1.8로 변경

```
<plugin>
	<groupId>org.apache.maven.plugins</groupId>
	<artifactId>maven-compiler-plugin</artifactId>
	<version>2.5.1</version>
	<configuration>
		<source>1.8</source>
		<target>1.8</target>
		<compilerArgument>-Xlint:all</compilerArgument>
		<showWarnings>true</showWarnings>
		<showDeprecation>true</showDeprecation>
	</configuration>
</plugin>
```


기억...
```
<context-param>
	<param-name>contextConfigLocation</param-name>
	<param-value>
	   /WEB-INF/spring/root-context.xml  
	   /WEB-INF/spring/security-context.xml
	</param-value>
</context-param>
```

### 에러코드 리스트

100번대 - member

200번대 - survey

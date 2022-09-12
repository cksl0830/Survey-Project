// 사용자 일련번호 추가 & 프로필 이미지 추가

SELECT 'DROP TABLE "' || TABLE_NAME || '" CASCADE CONSTRAINTS;' FROM user_tables;

SELECT 'DROP SEQUENCE "' || SEQUENCE_NAME || '";' FROM user_sequences;

SELECT 'CREATE SEQUENCE "' || TABLE_NAME || '_SEQ";' FROM user_tables;
/* 사용자 */
CREATE TABLE tbl_member (
	member_seq NUMBER NOT NULL, /* 사용자 시퀀스 */
	username VARCHAR2(50) NOT NULL, /* 아이디 */
	email VARCHAR2(200) NOT NULL, /* 이메일 */
	password VARCHAR2(100) NOT NULL, /* 비밀번호 */
	enabled NUMBER(1) DEFAULT 1 NOT NULL, /* 사용여부 */
	name VARCHAR2(50) NOT NULL, /* 이름 */
	birth DATE NOT NULL, /* 생일 */
	gender NUMBER(1) NOT NULL, /* 성별 */
	image VARCHAR2(1000) /* 프로필이미지 */
);

ALTER TABLE tbl_member
	ADD
		CONSTRAINT PK_tbl_member
		PRIMARY KEY (
			member_seq
		);

ALTER TABLE tbl_member
	ADD
		CONSTRAINT UK_tbl_member
		UNIQUE (
			username
		);

/* 사용자 권한 */
CREATE TABLE tbl_auth (
	member_seq NUMBER NOT NULL, /* 아이디 */
	authority VARCHAR2(20) DEFAULT 'ROLE_USER' NOT NULL /* 권한명 */
);

ALTER TABLE tbl_auth
	ADD
		CONSTRAINT PK_tbl_auth
		PRIMARY KEY (
            member_seq
        );

/* 설문항목테이블 */
CREATE TABLE tbl_survey_item (
	survey_item_seq NUMBER NOT NULL, /* 설문항목시퀀스 */
	survey_seq NUMBER(4) NOT NULL, /* 설문 시퀀스 */
	content VARCHAR2(2000) NOT NULL /* 내용 */
);

ALTER TABLE tbl_survey_item
	ADD
		CONSTRAINT PK_tbl_survey_item
		PRIMARY KEY (
			survey_item_seq
		);

/* 설문테이블 */
CREATE TABLE tbl_survey (
	survey_seq NUMBER(4) NOT NULL, /* 설문 시퀀스 */
	member_seq NUMBER NOT NULL, /* 작성자 */
	title VARCHAR2(500) NOT NULL, /* 제목 */
	content VARCHAR2(4000), /* 내용 */
	reg_date DATE DEFAULT sysdate NOT NULL, /* 작성일 */
	end_date DATE DEFAULT sysdate+10 NOT NULL, /* 마감일 */
	progressing NUMBER(1) DEFAULT 1 NOT NULL, /* 상태 */
	image VARCHAR2(1000) /* 설문사진 */
);

ALTER TABLE tbl_survey
	ADD
		CONSTRAINT PK_tbl_survey
		PRIMARY KEY (
			survey_seq
		);

/* 설문결과테이블 */
CREATE TABLE tbl_survey_result (
	survey_result_seq NUMBER NOT NULL, /* 설문결과시퀀스 */
	survey_seq NUMBER(4), /* 설문 시퀀스 */
	survey_item_seq NUMBER NOT NULL, /* 설문항목시퀀스 */
	member_seq NUMBER NOT NULL, /* 참여자 */
	reg_date DATE DEFAULT sysdate NOT NULL /* 참여일 */
);

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT PK_tbl_survey_result
		PRIMARY KEY (
			survey_result_seq
		);

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT UK_tbl_survey_result
		UNIQUE (
			survey_seq,
			member_seq
		);

/* 댓글테이블 */
CREATE TABLE tbl_reply (
	reply_seq NUMBER NOT NULL, /* 댓글 시퀀스 */
	survey_seq NUMBER(4) NOT NULL, /* 설문 시퀀스 */
	member_seq NUMBER NOT NULL, /* 사용자 시퀀스 */
	reply_msg VARCHAR2(2000), /* 댓글 내용 */
	writetime DATE NOT NULL /* 댓글 작성 시간 */
);

ALTER TABLE tbl_reply
	ADD
		CONSTRAINT PK_tbl_reply
		PRIMARY KEY (
			reply_seq
		);

/* 알림테이블 */
CREATE TABLE tbl_notice (
	notice_seq NUMBER NOT NULL, /* 알림 시퀀스 */
	recieve_member_seq NUMBER NOT NULL, /* 알림수신인 */
	notice_member_seq NUMBER, /* 알림발신인 */
	survey_seq NUMBER(4), /* 설문 시퀀스 */
	reply_seq NUMBER, /* 댓글 시퀀스 */
	survey_result_seq NUMBER, /* 설문결과시퀀스 */
	notice_message VARCHAR2(200) NOT NULL, /* 알림메세지 */
	notice_type NUMBER(2), /* 알림타입(댓글, 참여) */
	notice_regdate DATE NOT NULL, /* 알림생성 날짜 */
	notice_readdate DATE /* 알림확인날짜 */
);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT PK_tbl_notice
		PRIMARY KEY (
			notice_seq
		);

ALTER TABLE tbl_auth
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_auth
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_survey_item
	ADD
		CONSTRAINT FK_tbl_sur_TO_tbl_sur_item
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_survey
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_survey
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT FK_sur_it_TO_sur_re
		FOREIGN KEY (
			survey_item_seq
		)
		REFERENCES tbl_survey_item (
			survey_item_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT FK_tbl_mem_TO_tbl_sur_result
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_survey_result
	ADD
		CONSTRAINT FK_tbl_sur_TO_tbl_sur_result
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		);

ALTER TABLE tbl_reply
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_reply
		FOREIGN KEY (
			member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_reply
	ADD
		CONSTRAINT FK_tbl_survey_TO_tbl_reply
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_survey_TO_tbl_notice
		FOREIGN KEY (
			survey_seq
		)
		REFERENCES tbl_survey (
			survey_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_notice
		FOREIGN KEY (
			recieve_member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_member_TO_tbl_notice2
		FOREIGN KEY (
			notice_member_seq
		)
		REFERENCES tbl_member (
			member_seq
		);

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_reply_TO_tbl_notice
		FOREIGN KEY (
			reply_seq
		)
		REFERENCES tbl_reply (
			reply_seq
		)
		ON DELETE CASCADE;

ALTER TABLE tbl_notice
	ADD
		CONSTRAINT FK_tbl_survey_res_TO_tbl_not
		FOREIGN KEY (
			survey_result_seq
		)
		REFERENCES tbl_survey_result (
			survey_result_seq
		)
		ON DELETE CASCADE;
		
CREATE SEQUENCE "SEQ_MEMBER";
CREATE SEQUENCE "SEQ_AUTH";
CREATE SEQUENCE "SEQ_SURVEY_ITEM";
CREATE SEQUENCE "SEQ_SURVEY";
CREATE SEQUENCE "SEQ_SURVEY_RESULT";
CREATE SEQUENCE "SEQ_REPLY";
CREATE SEQUENCE "SEQ_NOTICE";

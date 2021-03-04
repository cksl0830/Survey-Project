package org.sist.project.domain;

public class NoticeVO {
	private int notice_seq;
	private int recieve_member_seq;
	private int survey_seq;
	private int reply_seq;
	private int survey_result_seq;
	private String notice_message;
	private int notice_type;
	private String notice_regdate;
	private String notice_readdate;
	private String receive_username;
	private String participated_username;
	private String usimage;
	private int progressing;

	//서베이 이름
	//서베이 사진
	//상대방 사진
	
	/*NOTICE_SEQ         NOT NULL NUMBER        
	RECIEVE_MEMBER_SEQ NOT NULL NUMBER        
	NOTICE_MEMBER_SEQ           NUMBER        
	SURVEY_SEQ                  NUMBER(4)     
	REPLY_SEQ                   NUMBER        
	SURVEY_RESULT_SEQ           NUMBER        
	NOTICE_MESSAGE     NOT NULL VARCHAR2(200) 
	NOTICE_TYPE                 NUMBER(2)     
	NOTICE_REGDATE     NOT NULL DATE          
	NOTICE_READDATE             DATE 
	
	select x.*
    , CASE notice_type  
            WHEN 1 THEN participated_username||'님이 ['||title||'] 설문에 댓글을 남기셨습니다.'
            WHEN 2 THEN participated_username||'님이 ['||title||']설문에 참여하였습니다.'
            END as notice_message
from (            
select notice_seq, recieve_member_seq, notice_member_seq, c.username as participated_username
        , a.survey_seq, reply_seq, survey_result_seq, notice_type, notice_regdate, notice_readdate  
        , d.title 
        , CASE notice_type  
            WHEN 1 THEN c.image
            WHEN 2 THEN d.image
            END as image
from tbl_notice a
join tbl_member c on a.notice_member_seq = c.member_seq
join tbl_survey d on a.survey_seq = d.survey_seq
where recieve_member_seq = 1) x
	*/
	
	public int getNotice_seq() {
		return notice_seq;
	}
	public void setNotice_seq(int notice_seq) {
		this.notice_seq = notice_seq;
	}
	public int getSurvey_seq() {
		return survey_seq;
	}
	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}
	public int getReply_seq() {
		return reply_seq;
	}
	public void setReply_seq(int reply_seq) {
		this.reply_seq = reply_seq;
	}
	public int getSurvey_result_seq() {
		return survey_result_seq;
	}
	public void setSurvey_result_seq(int survey_result_seq) {
		this.survey_result_seq = survey_result_seq;
	}
	public String getNotice_message() {
		return notice_message;
	}
	public void setNotice_message(String notice_message) {
		this.notice_message = notice_message;
	}
	public int getNotice_type() {
		return notice_type;
	}
	public void setNotice_type(int notice_type) {
		this.notice_type = notice_type;
	}
	public String getNotice_regdate() {
		return notice_regdate;
	}
	public void setNotice_regdate(String notice_regdate) {
		this.notice_regdate = notice_regdate;
	}
	public String getNotice_readdate() {
		return notice_readdate;
	}
	public void setNotice_readdate(String notice_readdate) {
		this.notice_readdate = notice_readdate;
	}
	public int getRecieve_member_seq() {
		return recieve_member_seq;
	}
	public void setRecieve_member_seq(int recieve_member_seq) {
		this.recieve_member_seq = recieve_member_seq;
	}
	public String getReceive_username() {
		return receive_username;
	}
	public void setReceive_username(String receive_username) {
		this.receive_username = receive_username;
	}
	public String getParticipated_username() {
		return participated_username;
	}
	public void setParticipated_username(String participated_username) {
		this.participated_username = participated_username;
	}
	public String getUsimage() {
		return usimage;
	}
	public void setUsimage(String usimage) {
		this.usimage = usimage;
	}
	public int getProgressing() {
		return progressing;
	}
	public void setProgressing(int progressing) {
		this.progressing = progressing;
	}

	
	
}

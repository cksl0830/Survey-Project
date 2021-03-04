package org.sist.project.domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class SurveyVO {
	private int survey_seq;
	private int member_seq;
	private String name; 
	private String title;
	private String content;
	private Date reg_date;
	private Date end_date;
	private int progressing;
	private String image;
	private int participantCnt;
	private MultipartFile mimage;
	private String realPath;

	public SurveyVO(SurveyVO surveyCopy) {
		this.survey_seq = surveyCopy.survey_seq;
		this.member_seq = surveyCopy.member_seq;
		this.name = surveyCopy.name; 
		this.title = surveyCopy.title;
		this.content = surveyCopy.content;
		this.reg_date = surveyCopy.reg_date;
		this.end_date = surveyCopy.end_date;
		this.progressing = surveyCopy.progressing;
		this.image = surveyCopy.image;
		this.participantCnt = surveyCopy.participantCnt;
	}

	
	public SurveyVO() {
	}

	@Override
	public String toString() {
		return "SurveyVO [survey_seq=" + survey_seq + ", member_seq=" + member_seq + ", name=" + name + ", title="
				+ title + ", content=" + content + ", reg_date=" + reg_date + ", end_date=" + end_date + ", progressing="
				+ progressing + "image=" + image + "participantCnt=" + participantCnt +"]";
	}
	
	
	
	public int getSurvey_seq() {
		return survey_seq;
	}
	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}
	public int getMember_seq() {
		return member_seq;
	}
	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public Date getReg_date() {
		return reg_date;
	}
	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}
	public Date getEnd_date() {
		return end_date;
	}
	public void setEnd_date(Date end_date) {
		this.end_date = end_date;
	}
	public int getProgressing() {
		return progressing;
	}
	public void setProgressing(int progressing) {
		this.progressing = progressing;
	}
	public String getImage() {
		return image;
	}
	public void setImage(String image) {
		this.image = image;
	}
	public int getParticipantCnt() {
		return participantCnt;
	}
	public void setParticipantCnt(int participantCnt) {
		this.participantCnt = participantCnt;
	}
	public void initSurveyVO(ResultSet rs) throws SQLException {
		this.setSurvey_seq(rs.getInt("survey_seq"));
		this.setTitle(rs.getString("title"));
		this.setMember_seq(rs.getInt("member_seq"));
		this.setName(rs.getString("name"));
		this.setContent(rs.getString("content"));
		this.setReg_date(rs.getDate("reg_date"));
		this.setEnd_date(rs.getDate("end_date"));
		this.setProgressing(rs.getInt("progressing"));
		this.setImage(rs.getString("image"));
		this.setParticipantCnt(rs.getInt("participantCnt"));
	}


	public MultipartFile getMimage() {
		return mimage;
	}


	public void setMimage(MultipartFile mimage) {
		this.mimage = mimage;
	}


	public String getRealPath() {
		return realPath;
	}


	public void setRealPath(String realPath) {
		this.realPath = realPath;
	}
	
	

	
}

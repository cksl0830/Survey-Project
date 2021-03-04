package org.sist.project.domain;

public class ReplyVO {
	private int survey_seq;
	private int reply_seq;
	private int member_seq;
	private String reply_msg;
	private String writedate;
	private String username;
	private String image;
	private String writetime;

	public ReplyVO() {
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


	public int getMember_seq() {
		return member_seq;
	}


	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}


	public String getReply_msg() {
		return reply_msg;
	}


	public void setReply_msg(String reply_msg) {
		this.reply_msg = reply_msg;
	}


	public String getWritedate() {
		return writedate;
	}


	public void setWritedate(String writedate) {
		this.writedate = writedate;
	}


	public String getUsername() {
		return username;
	}


	public void setUsername(String username) {
		this.username = username;
	}


	public String getImage() {
		return image;
	}


	public void setImage(String image) {
		this.image = image;
	}


	public String getWritetime() {
		return writetime;
	}


	public void setWritetime(String writetime) {
		this.writetime = writetime;
	}

	
	
}

package org.sist.project.domain;

import java.util.Date;

//설문조사 보기 선택
public class SurveyResultVO {

	private int survey_result_seq;
	private int survey_item_seq;
	private int survey_seq;
	

	private int member_seq;
	private Date reg_date;
	
	public SurveyResultVO() {}
	
	public SurveyResultVO(SurveyResultVO resultCopy) {
		this.survey_result_seq = resultCopy.survey_result_seq;
		this.survey_item_seq = resultCopy.survey_item_seq;
		this.member_seq = resultCopy.member_seq;
		this.reg_date = resultCopy.reg_date;
	}
	public int getSurvey_seq() {
		return survey_seq;
	}

	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}
	public int getSurvey_result_seq() {
		return survey_result_seq;
	}

	public void setSurvey_result_seq(int survey_result_seq) {
		this.survey_result_seq = survey_result_seq;
	}

	public int getSurvey_item_seq() {
		return survey_item_seq;
	}

	public void setSurvey_item_seq(int survey_item_seq) {
		this.survey_item_seq = survey_item_seq;
	}

	public int getMember_seq() {
		return member_seq;
	}

	public void setMember_seq(int member_seq) {
		this.member_seq = member_seq;
	}

	public Date getReg_date() {
		return reg_date;
	}

	public void setReg_date(Date reg_date) {
		this.reg_date = reg_date;
	}

	@Override
	public String toString() {
		return "SurveyResultVO [survey_result_seq=" + survey_result_seq + ", survey_item_seq=" + survey_item_seq
				+ ", member_seq=" + member_seq + ", reg_date=" + reg_date + "]";
	}
	
	
}

package org.sist.project.domain;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// 진행중인 설문
public class SurveyItemVO {
	private int survey_item_seq;
	private int survey_seq;
	private String content;	
	
	
	@Override
	public String toString() {
		return "SurveyItemVO [survey_item_seq=" + survey_item_seq + ", survey_seq=" + survey_seq + ", content="
				+ content + "]";
	}
	public int getSurvey_item_seq() {
		return survey_item_seq;
	}
	public void setSurvey_item_seq(int survey_item_seq) {
		this.survey_item_seq = survey_item_seq;
	}
	public int getSurvey_seq() {
		return survey_seq;
	}
	public void setSurvey_seq(int survey_seq) {
		this.survey_seq = survey_seq;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public static List<SurveyItemVO> initSurveyItemVO(ResultSet rs) throws SQLException {
		List<SurveyItemVO> itemList = new ArrayList<SurveyItemVO>();
		while (rs.next()) {
			SurveyItemVO surveyItemVO = new SurveyItemVO();
			surveyItemVO.setSurvey_item_seq(rs.getInt("survey_item_seq"));
			surveyItemVO.setSurvey_seq(rs.getInt("survey_seq"));
			surveyItemVO.setContent(rs.getString("content"));
			itemList.add(surveyItemVO);
		}
		return itemList;
	}
}

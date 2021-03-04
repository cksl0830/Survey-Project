package org.sist.project.domain;

public class ResultDataSet {
	private int age;
	private int gender;
	private String name;
	private int survey_item_seq;
	
	@Override
	public String toString() {
		return "ResultDataSet [age=" + age + ", gender=" + gender + ", name=" + name + ", survey_item_seq="
				+ survey_item_seq + "]";
	}
	public int getAge() {
		return age;
	}
	public void setAge(int age) {
		this.age = age;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getSurvey_item_seq() {
		return survey_item_seq;
	}
	public void setSurvey_item_seq(int survey_item_seq) {
		this.survey_item_seq = survey_item_seq;
	}
}

package org.sist.test;

import java.util.List;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.project.persistance.SurveyDAO;
import org.sist.project.service.SurveyService;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations= {"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class SurveyTest {
	@Inject
	private SurveyDAO dao;
	@Inject
	private SurveyService service;
	
	@Test
	public void testSelectSurvey() throws Exception {
		int survey_seq = 5;
		SurveyWithItemVO surveyWithItemVO = service.getSurveyItems(survey_seq);
		System.out.println(surveyWithItemVO);
	}	
	
	@Test
	public void testSelectSurveyResult() throws Exception {
		int survey_seq = 5;
		SurveyWithDatasetVO surveyWithDatasetVO = service.getSurveyResult(survey_seq);
		System.out.println(surveyWithDatasetVO);
	}
}

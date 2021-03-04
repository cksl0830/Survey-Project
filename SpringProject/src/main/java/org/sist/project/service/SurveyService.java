package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.domain.SurveyResultVO;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;

public interface SurveyService {
	public List<SurveyVO> getSurveyList(SearchCriteria cri) throws Exception;
	public PageMaker getPagination(SearchCriteria cri) throws Exception;
	public SurveyVO getSurvey(int survey_seq) throws Exception;
	public SurveyWithItemVO getSurveyItems(int survey_seq) throws Exception;
	public SurveyWithDatasetVO getSurveyResult(int survey_seq) throws Exception;
	public List<ReplyVO> getReplyList(int survey_seq);
	public int insertReply(ReplyVO replyVO);
	public void addSurvey(SurveyVO svo, SurveyWithItemVO sivo);
	public void	closeSurvey(int survey_seq); 
	public void removeSurvey(int survey_seq);
	public void addSurveyResult(SurveyResultVO srvo);
	public int updateReply(ReplyVO replyVO);
	public int delReply(ReplyVO replyVO);

	public List<SurveyVO> getSearchMember(SearchCriteria cri);
	public void removeSurveyUnabled(String[] surseqlist, String realPath);
	
}

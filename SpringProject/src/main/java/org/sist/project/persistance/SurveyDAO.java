package org.sist.project.persistance;

import java.util.List;

import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyResultVO;
import org.sist.project.domain.SurveyVO;

public interface SurveyDAO {
	public List<SurveyVO> selectSurveyList(SearchCriteria cri) throws Exception;

	public PageMaker selectCountPaging(SearchCriteria cri);
	public List<ResultDataSet> selectSurveyResultDataSet(int survey_seq);
	public List<SurveyItemVO> selectSurveyItems(int survey_seq);
	public SurveyVO selectSurvey(int survey_seq);
	public SurveyItemVO selecyMySurveyResult(int survey_seq, int member_seq);
	public List<ReplyVO> selectReplyList(int survey_seq);

	public int insertReply(ReplyVO replyVO);

	public void insertSurvey(SurveyVO svo);

	public void insertSurveyItem(List<SurveyItemVO> itemlist);
	
	public void addSurveyResult(SurveyResultVO srvo);

	public int updateReply(ReplyVO replyVO);

	public int delReply(ReplyVO replyVO);
	public List<SurveyVO> selectSearchSurvey(SearchCriteria cri);

	public void	 closeSurvey(int survey_seq);
	public void removeSurvey(int survey_seq);
	public void deleteSurveyUnabled(String[] surseqlist);

	public List<String> selectImageFileName(String[] surseqlist);

}

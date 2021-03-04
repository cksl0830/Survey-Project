package org.sist.project.persistance;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.domain.SurveyItemVO;
import org.sist.project.domain.SurveyResultVO;
import org.sist.project.domain.SurveyVO;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class SurveyDAOImpl implements SurveyDAO{
	private static final Logger logger = LoggerFactory.getLogger(SurveyDAOImpl.class);
	private String namespace = "org.sist.project.mapper.SurveyMapper";

	@Autowired
	private SqlSession sqlSession;
	
	@Override
	public List<SurveyVO> selectSurveyList(SearchCriteria cri) throws Exception {
		logger.info("selectSurveyList");
		List<SurveyVO> surveyList = sqlSession.selectList(namespace+".selectSurveyList", cri);
		return surveyList;
	}

	@Override
	public PageMaker selectCountPaging(SearchCriteria cri) {
		logger.info("selectCountPaging");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		int totalCount = sqlSession.selectOne(namespace+".selectCountPaging", cri);
		pageMaker.setTotalCount(totalCount);
		return pageMaker;
	}

	@Override
	public List<SurveyItemVO> selectSurveyItems(int survey_seq) {
		logger.info("selectSurvey");
		List<SurveyItemVO> surveyItemList = null;
		surveyItemList = sqlSession.selectList(namespace+".selectSurveyItems", survey_seq);
		return surveyItemList;
	}

	@Override
	public List<ResultDataSet> selectSurveyResultDataSet(int survey_seq) {
		logger.info("selectSurveyResultDataSet");
		return sqlSession.selectList(namespace+".selectResultDataset", survey_seq);
	}

	@Override
	public SurveyVO selectSurvey(int survey_seq) {
		logger.info("selectSurvey");
		return sqlSession.selectOne(namespace+".selectSurvey", survey_seq);
	}

	@Override
	public SurveyItemVO selecyMySurveyResult(int survey_seq, int member_seq) {
		logger.info("selecyMySurveyResult");
		Map<String, Integer> params = new HashMap<>();
		params.put("survey_seq", survey_seq);
		params.put("member_seq", member_seq);
		return sqlSession.selectOne(namespace+".selecyMySurveyResult", params);
	}
	
	@Override
	public List<ReplyVO> selectReplyList(int survey_seq) {
		logger.info("selectReplyList");
		return sqlSession.selectList(namespace+".selectReplyList", survey_seq);
	}

	@Override
	public int insertReply(ReplyVO replyVO) {
		logger.info("insertReply");
		String username = replyVO.getUsername();
		replyVO.setMember_seq(sqlSession.selectOne(namespace+".selectReplyMember",username));
		return sqlSession.insert(namespace+".insertReply", replyVO);
	}
	@Override
	public int updateReply(ReplyVO replyVO) {
		logger.info("updateReply");
		return sqlSession.update(namespace+".updateReply", replyVO);
	}
	
	@Override
	public int delReply(ReplyVO replyVO) {
		logger.info("delReply");
		return sqlSession.delete(namespace+".delReply", replyVO);
	}

	
	@Override
	public void insertSurvey(SurveyVO svo) {
		logger.info("addSurvey");
		sqlSession.insert(namespace+".insertSurvey", svo);
		System.out.println("addsurvey �꽦怨�");
	}
	@Override
	public void insertSurveyItem(List<SurveyItemVO> itemlist) {
		logger.info("addSurveyItem");
		Iterator<SurveyItemVO> itemir = itemlist.iterator();
		while (itemir.hasNext()) {
			SurveyItemVO surveyItemVO = itemir.next();
			sqlSession.insert(namespace+".insertSurveyItem", surveyItemVO);
		}
		System.out.println("addsurveyitem �꽦怨�");
	}

	@Override
	public void addSurveyResult(SurveyResultVO srvo) {
		logger.info("addSurveyResult");
		sqlSession.insert(namespace+".addSurveyResult", srvo);
	}
	@Override
	public List<SurveyVO> selectSearchSurvey(SearchCriteria cri) {
		logger.info("selectSearchSurvey");
		List<SurveyVO> list = sqlSession.selectList(namespace+".selectSearchSurvey", cri);
		return list;
	}

	@Override
	public void closeSurvey(int survey_seq) {
		logger.info("closeSurvey");
		sqlSession.update(namespace+".closeSurvey", survey_seq);
	}

	@Override
	public void removeSurvey(int survey_seq) {
		logger.info("removeSurvey");
		sqlSession.delete(namespace+".removeSurvey", survey_seq);
	}
	@Override
	public void deleteSurveyUnabled(String[] surseqlist) {
		logger.info("delSurveyUnabled");
		sqlSession.delete(namespace+".deleteSurveyUnabled",surseqlist);
	}
	
	@Override
	public List<String> selectImageFileName(String [] surseqlist) {
		logger.info("selectImageFileName");
		List<String> list = new ArrayList<>();
		
		list = sqlSession.selectList(namespace+".selectImageFileName", surseqlist);
		
		return list;
	}



}
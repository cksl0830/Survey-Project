package org.sist.project.service;

import java.io.File;
import java.io.IOException;
import java.util.Iterator;
import java.util.List;
import java.util.UUID;

import org.sist.project.domain.Criteria;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.ReplyVO;
import org.sist.project.domain.ResultDataSet;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.domain.SurveyResultVO;
import org.sist.project.domain.SurveyVO;
import org.sist.project.domain.SurveyWithDatasetVO;
import org.sist.project.domain.SurveyWithItemVO;
import org.sist.project.persistance.SurveyDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.multipart.MultipartFile;

import sun.security.krb5.internal.crypto.crc32;

@Service
public class SurveyServiceImpl implements SurveyService{

	@Autowired
	SurveyDAO dao;
	
	@Override
	public List<SurveyVO> getSurveyList(SearchCriteria cri) throws Exception {
		return dao.selectSurveyList(cri);
	}

	@Override
	public PageMaker getPagination(SearchCriteria cri) throws Exception {
		return dao.selectCountPaging(cri);
	}

	@Override
	public SurveyVO getSurvey(int survey_seq) throws Exception {
		return dao.selectSurvey(survey_seq);
	}
	@Override
	public SurveyWithItemVO getSurveyItems(int survey_seq) throws Exception {
		SurveyVO surveyVO = getSurvey(survey_seq);
		SurveyWithItemVO surveyWithItemVO = new SurveyWithItemVO(surveyVO);
		surveyWithItemVO.setSurveyItemList(dao.selectSurveyItems(survey_seq));
		return surveyWithItemVO;
	}

	@Override
	public SurveyWithDatasetVO getSurveyResult(int survey_seq) throws Exception {
		SurveyWithItemVO surveyWithItemVO = getSurveyItems(survey_seq);
		SurveyWithDatasetVO surveyWithDatasetVO = new SurveyWithDatasetVO(surveyWithItemVO);
		List<ResultDataSet> dataSetList = dao.selectSurveyResultDataSet(survey_seq);
		surveyWithDatasetVO.setDataset(dataSetList);
		return surveyWithDatasetVO;
	}

	@Override
	public List<ReplyVO> getReplyList(int survey_seq) {
		List<ReplyVO> replyList = dao.selectReplyList(survey_seq);
		return replyList;
	}

	@Override
	public int insertReply(ReplyVO replyVO) {
		int result = dao.insertReply(replyVO);
		return result;
	}
	
	@Override
	public int updateReply(ReplyVO replyVO) {
		int result = dao.updateReply(replyVO);
		return result;
	}
	
	@Override
	public int delReply(ReplyVO replyVO) {
		int result = dao.delReply(replyVO);
		return result;
	}
	
	@Transactional
	@Override
	public void addSurvey(SurveyVO svo, SurveyWithItemVO sivo) {
		MultipartFile mimage = svo.getMimage();
		try {
				if(mimage!=null && mimage.getSize()!=0){
					String uuidname = UUID.randomUUID().toString()+".jpg";
					byte[] bytes = mimage.getBytes();
					File file = new File(svo.getRealPath(), uuidname);
					FileCopyUtils.copy(bytes, file);
					svo.setImage(uuidname);
				}else {
					svo.setImage(null);
				}
			} 
			catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
			}
		dao.insertSurvey(svo);
		dao.insertSurveyItem(sivo.getSurveyItemList());
	}

	// �꽕臾몄“�궗 蹂닿린 �꽑�깮
	@Override
	public void addSurveyResult(SurveyResultVO srvo) {
		dao.addSurveyResult(srvo);
	}


	@Override
	public List<SurveyVO> getSearchMember(SearchCriteria cri) {
		List<SurveyVO> list = dao.selectSearchSurvey(cri);
		return list;
	}

	@Override
	public void closeSurvey(int survey_seq) {
		dao.closeSurvey(survey_seq);
	}

	@Override
	public void removeSurvey(int survey_seq) {
		dao.removeSurvey(survey_seq);
	}
	@Override
	public void removeSurveyUnabled(String[] surseqlist, String realPath) {
		List<String> filename = dao.selectImageFileName(surseqlist);
		for (int i = 0; i < filename.size(); i++) {
			if (filename.get(i) != null) {
				File deletefile = new File(realPath, filename.get(i));
				if( deletefile.exists() ){
					if(deletefile.delete()){
						System.out.println("�뙆�씪�궘�젣 �꽦怨�");
					}else{
						System.out.println("�뙆�씪�궘�젣 �떎�뙣");
					}
				}else{
					System.out.println("�뙆�씪�씠 議댁옱�븯吏� �븡�뒿�땲�떎.");
				}
			}
			
		}
		
		dao.deleteSurveyUnabled(surseqlist);
	}


}

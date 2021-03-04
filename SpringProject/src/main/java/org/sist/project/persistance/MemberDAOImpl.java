package org.sist.project.persistance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.sist.project.domain.MemberVO;
import org.sist.project.domain.NoticeVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.member.MemberDetails;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class MemberDAOImpl implements MemberDAO{
	
	private static final Logger logger = LoggerFactory.getLogger(MemberDAOImpl.class);
	private String namespace = "org.sist.project.mapper.MemberMapper";

	@Autowired
	private SqlSession sqlSession;

	@Override
	public List<MemberVO> selectAdminList() throws Exception {
		logger.info("getAdminList");
		return sqlSession.selectList(namespace+".selectAdminList");
	}

	@Override
	public boolean insertMember(MemberVO member) throws Exception {
		logger.info("addMember");
		return sqlSession.insert(namespace+".insertMember", member) != 0 ? true : false;
	}

	@Override
	public boolean modifyMember(MemberVO member) throws Exception {
		logger.info("modifyMember");
		return sqlSession.update(namespace+".modifyMember", member) != 0 ? true : false;
	}
	
	@Override
	public boolean removeMember(int member_seq) throws Exception {
		logger.info("removeMember");
		return sqlSession.update(namespace+".removeMember", member_seq) != 0 ? true : false;
	}

	@Override
	public MemberDetails selectUserById(String username) throws Exception{
		logger.info("selectUserById");
		return sqlSession.selectOne(namespace+".selectUserById", username);
	}

	@Override
	public String selectUsername(String username) throws Exception{
		logger.info("selectUsername");
		return sqlSession.selectOne(namespace+".selectUsername", username);
	}

	@Override
	public String selectUserEmail(String username) throws Exception{
		logger.info("selectUserEmail");
		return sqlSession.selectOne(namespace+".selectUserEmail", username);
	}

	@Override
	public void updateUserPassword(String username, String authKey) throws Exception{
		logger.info("updateUserPassword");
		Map<String, Object> mapParam = new HashMap<>();
		mapParam.put("username", username);
		mapParam.put("password", authKey);
		sqlSession.update(namespace+".updateUserPassword", mapParam);
	}

	@Override
	public int selectNoticeCount(int member_seq) throws Exception {
		logger.info("selectNoticeCount");
		return sqlSession.selectOne(namespace+".selectNoticeCount", member_seq);
	}
	public List<MemberVO> selectSearchMember(SearchCriteria cri) {
		logger.info("selectSearchMember");
		return sqlSession.selectList(namespace+".selectSearchMember", cri);
	}
	
	@Override
	public void updateMemberUnabled(String [] memlist) {
		logger.info("updateMemberEnabled");
		 sqlSession.update(namespace+".updateMemberUnabled",memlist);
	}

	@Override
	public List<NoticeVO> selectUserNotice(int member_seq) {
		logger.info("selectUserNotice");
		return sqlSession.selectList(namespace+".selectUserNotice", member_seq);
	}

	@Override
	public int readUserNotice(int member_seq) {
		logger.info("readUserNotice");
		return sqlSession.update(namespace+".readUserNotice", member_seq);
	}

	@Override
	public PageMaker selectMemberCountPaging(SearchCriteria cri) {
		logger.info("selectMemberCountPaging");
		PageMaker pageMaker = new PageMaker();
		pageMaker.setCri(cri);
		int totalCount = sqlSession.selectOne(namespace+".selectMemberCountPaging", cri);
		pageMaker.setTotalCount(totalCount);
		return pageMaker;
	}

}

package org.sist.project.persistance;

import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.NoticeVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.sist.project.member.MemberDetails;

public interface MemberDAO {
	public List<MemberVO> selectAdminList() throws Exception;
	public boolean insertMember(MemberVO member) throws Exception;
	public boolean modifyMember(MemberVO member) throws Exception;
	public boolean removeMember(int member_seq) throws Exception;
	public MemberDetails selectUserById(String username) throws Exception;
	public String selectUsername(String username) throws Exception;
	public String selectUserEmail(String username) throws Exception;
	public void updateUserPassword(String username, String authKey) throws Exception;
	public List<MemberVO> selectSearchMember(SearchCriteria cri);
	public void updateMemberUnabled(String [] memlist);
//	public void updateMemberUnabled2(ArrayList<Integer> member_seqList);
	public int selectNoticeCount(int member_seq) throws Exception;
	public List<NoticeVO> selectUserNotice(int member_seq);
	public int readUserNotice(int member_seq);
	public PageMaker selectMemberCountPaging(SearchCriteria cri);
}

package org.sist.project.service;

import java.util.List;

import org.sist.project.domain.MemberVO;
import org.sist.project.domain.NoticeVO;
import org.sist.project.domain.PageMaker;
import org.sist.project.domain.SearchCriteria;
import org.sist.project.domain.SearchVO;
import org.springframework.web.multipart.MultipartFile;

public interface MemberService {
	public List<MemberVO> getAdminList() throws Exception;

	public void addMember(MemberVO member, MultipartFile multipartFile, String realPath) throws Exception;

	public void modifyMember(MemberVO member, MultipartFile multipartFile, String realPath,
			String password, String changePassword, int garbage) throws Exception;
	
	public String checkUsername(String username) throws Exception;
	public String checkUserEmail(String username) throws Exception;

	public void modifyPassword(String username, String authKey) throws Exception;

	public int getNoticeCount(int member_seq) throws Exception;

	public List<MemberVO> getSearchMember(SearchCriteria cri) throws Exception;

	public void modifyMemberUnabled(String[] memlist) throws Exception;

	public List<NoticeVO> getUserNotice(int member_seq) throws Exception;

	public int readUserNotice(int member_seq) throws Exception;

	void removeMember(int member_seq, String password) throws Exception;

	public PageMaker getMemberPagination(SearchCriteria cri) throws Exception;

}

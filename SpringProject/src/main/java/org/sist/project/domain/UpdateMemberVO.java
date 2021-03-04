package org.sist.project.domain;

import java.util.List;

public class UpdateMemberVO extends MemberVO{

	List<UpdateMemberVO> member_seqList;

	public List<UpdateMemberVO> getMember_seqList() {
		return member_seqList;
	}

	public void setMember_seqList(List<UpdateMemberVO> member_seqList) {
		this.member_seqList = member_seqList;
	}

	
	
}

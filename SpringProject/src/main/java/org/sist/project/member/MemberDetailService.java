package org.sist.project.member;

import org.sist.project.persistance.MemberDAO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

@Service
public class MemberDetailService implements UserDetailsService{

	@Autowired
	private MemberDAO dao;
	
	@Override
	public UserDetails loadUserByUsername(String username) {
		MemberDetails user = null;
		try {
			user = dao.selectUserById(username);
			if (user == null) {
				throw new UsernameNotFoundException(username);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
}

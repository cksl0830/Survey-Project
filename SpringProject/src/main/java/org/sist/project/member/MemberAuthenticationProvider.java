package org.sist.project.member;

import java.util.Collection;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;

public class MemberAuthenticationProvider implements AuthenticationProvider  {
	private static final Logger logger = LoggerFactory.getLogger(MemberAuthenticationProvider.class); 

	@Autowired
	UserDetailsService userService;
	
	@Autowired
	PasswordEncoder passwordEncoder;

	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName();
		String password = (String) authentication.getCredentials(); 
		String hashedPassword = passwordEncoder.encode(password); 

		UserDetails user = userService.loadUserByUsername(username);
		logger.info("username : " + user.getUsername() + " / password : " + user.getPassword()); 
		Collection<? extends GrantedAuthority> authorities = 
				user.getAuthorities();
		if (!hashedPassword.equals(user.getPassword())) 
			throw new BadCredentialsException("비밀번호가 일치하지 않습니다."); 

		return new UsernamePasswordAuthenticationToken(user, password, authorities);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		// TODO Auto-generated method stub
		return false;
	}

}

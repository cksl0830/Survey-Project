package org.sist.project.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class ControllerExcpetionAdvice {
	private static final Logger logger = LoggerFactory.getLogger(ControllerExcpetionAdvice.class);
	@ExceptionHandler
	public String errorModelAndView(Exception e) {
		if (e instanceof DuplicateKeyException) {
			logger.warn("User id Duplicate Error!");
			return "redirect:/survey/join";
		}
		logger.warn(e.toString());
		return "error.error_common";
	}
}
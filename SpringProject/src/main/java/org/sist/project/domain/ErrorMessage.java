package org.sist.project.domain;

public class ErrorMessage {
	private int type;
	private String message;
	
	public ErrorMessage(int type, String message) {
		this.type = type;
		this.message = message;
	}
	public int getType() {
		return type;
	}
	public void setType(int type) {
		this.type = type;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	@Override
	public String toString() {
		return "ErrorMessage [type=" + type + ", message=" + message + "]";
	}
	
}

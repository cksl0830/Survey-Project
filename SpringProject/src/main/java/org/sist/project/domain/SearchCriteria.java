package org.sist.project.domain;

import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

public class SearchCriteria extends Criteria {
	private String type;
	private String progressing;
	private String search;

	@Override
	public String toString() {
		return "SearchCriteria [type=" + type + ", progressing=" + progressing + ", search=" + search + "]";
	}
	public String makeSearch() {
		UriComponents uriComponents = UriComponentsBuilder.newInstance()
			.queryParam("perPageNum", this.getPerPageNum())
			.queryParam("type", this.getType())
			.queryParam("progressing", this.getProgressing())
			.queryParam("search", this.getSearch())
			.build();
		return uriComponents.toUriString();
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getProgressing() {
		if (progressing == null || progressing.isEmpty()) {
			return "1";
		}
		return progressing;
	}
	public void setProgressing(String progressing) {
		this.progressing = progressing;
	}
	public String getSearch() {
		return search;
	}
	public void setSearch(String search) {
		this.search = search;
	}
}

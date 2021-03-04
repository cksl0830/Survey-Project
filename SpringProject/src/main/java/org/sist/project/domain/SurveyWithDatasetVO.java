package org.sist.project.domain;

import java.util.List;

public class SurveyWithDatasetVO extends SurveyWithItemVO {
	private List<ResultDataSet> dataset;

	public SurveyWithDatasetVO(SurveyWithItemVO surveyWithItemVO) {
		super(surveyWithItemVO);
	}
	public List<ResultDataSet> getDataset() {
		return dataset;
	}

	public void setDataset(List<ResultDataSet> dataset) {
		this.dataset = dataset;
	}
}

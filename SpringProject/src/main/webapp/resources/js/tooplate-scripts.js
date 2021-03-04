const width_threshold = 480;

var randColorList = [
	"#F7604D", //Red: 
	"#A8D582", //Green: 
	"#4ED6B8", //Aqua: 
	"#9D66CC", //Purple: 
	"#D7D768", //Yellow: 
	"#3889FC", //Blue: 
	"#DB9C3F" //Orange: 
	]
var resultList = [{
	"age": 20,
	"gender": 1,
	"name": "고지용",
	"survey_item_seq": 21
}, {
	"age": 20,
	"gender": 1,
	"name": "함치영",
	"survey_item_seq": 21
}, {
	"age": 20,
	"gender": 0,
	"name": "문소민",
	"survey_item_seq": 23
}, {
	"age": 20,
	"gender": 0,
	"name": "신예나",
	"survey_item_seq": 24
}];
var itemList = [{
	"survey_item_seq": 21,
	"survey_seq": 6,
	"content": "전지현"
}, {
	"survey_item_seq": 22,
	"survey_seq": 6,
	"content": "고아라"
}, {
	"survey_item_seq": 23,
	"survey_seq": 6,
	"content": "한예슬"
}, {
	"survey_item_seq": 24,
	"survey_seq": 6,
	"content": "김지원"
}];


var itemSeqList = itemList.map(function(elt, i, array) {return elt.survey_item_seq;});



function drawLineChart(dataset, itemList) {
	if ($("#lineChart").length) {
		ctxLine = document.getElementById("lineChart").getContext("2d");
		optionsLine = {
				scales: {
					yAxes: [
						{
							scaleLabel: {
								display: true,
								labelString: "투표수"
							}
						}
						]
				}
		};

		// Set aspect ratio based on window width
		optionsLine.maintainAspectRatio =
			$(window).width() < width_threshold ? false : true;

		configLine = {
				type: "line",
				data: {
					labels: itemList.map(function(elt, i, array) {return i+1 + ". " + elt.content;}),
					datasets: [
						{
							lineTension: 0,
							label: "남자",
							data: getGenderResultList(dataset, itemList, 1),
							fill: false,
							borderColor: "rgb(75, 192, 192)",
							cubicInterpolationMode: "monotone",
							pointRadius: 0,

							pointBorderColor: 'rgb(75, 192, 192)',
							pointBackgroundColor: 'rgb(75, 192, 192)',
							pointRadius: 5,
							pointHoverRadius: 10,
							pointHitRadius: 30,
							pointBorderWidth: 2,
							pointStyle: 'rectRounded'
						},
						{
							lineTension: 0,
							label: "여자",
							data: getGenderResultList(dataset, itemList, 0),
							fill: false,
							borderColor: "rgba(255,178,217)",
							cubicInterpolationMode: "monotone",
							pointRadius: 0,

							pointBorderColor: 'rgba(255,178,217)',
							pointBackgroundColor: 'rgba(255,178,217)',
							pointRadius: 5,
							pointHoverRadius: 10,
							pointHitRadius: 30,
							pointBorderWidth: 2,
							pointStyle: 'rectRounded'
						}
						]
				},
				options: optionsLine
		};

		lineChart = new Chart(ctxLine, configLine);
	}
}

function drawBarChart(dataset, itemList) {
	if ($("#barChart").length) {
		ctxBar = document.getElementById("barChart");

		optionsBar = {
				responsive: true,
				scales: {
					xAxes: [
						{
							barPercentage: 0.5, //두께
							ticks: {
								beginAtZero: true
							},
							scaleLabel: {
								display: true,
								labelString: "Hits"
							}
						}
						]
				}
		};

		configBar = {
				type: "bar",
				data: {
					labels: itemList.map(function(elt, i, array) {return i+1 + ". " + elt.content;}),
					datasets: [
						{
							label: "10대",
							data: getAgeCountList(dataset, itemList, 10),
							backgroundColor: [
								"#A8D582", "#A8D582","#A8D582","#A8D582"
								],
						},
						{
							label: "20대",
							data: getAgeCountList(dataset, itemList, 20),
							backgroundColor: [
								"#00D8FF", "#00D8FF","#00D8FF","#00D8FF"
								]
						},
						{
							label: "30대",
							data: getAgeCountList(dataset, itemList, 30),
							backgroundColor: [
								"#F15F5F", "#F15F5F","#F15F5F","#F15F5F"
								]
						},
						{
							label: "기타",
							data: getAgeCountList(dataset, itemList, 0),
							backgroundColor: [
								"#CC723D", "#CC723D","#CC723D","#CC723D"
								]
						}
						]
				},
				options: optionsBar
		};

		barChart = new Chart(ctxBar, configBar);
	}
}

function drawPieChart(dataset, itemList) {
	if ($("#pieChart").length) {
		var chartHeight = 300;

		$("#pieChartContainer").css("height", chartHeight + "px");

		ctxPie = document.getElementById("pieChart").getContext("2d");

		optionsPie = {
				responsive: true,
				maintainAspectRatio: false,
				layout: {
					padding: {
						left: 10,
						right: 10,
						top: 10,
						bottom: 10
					}
				},
				legend: {
					position: "top"
				}
		};

		configPie = {
				type: "pie",
				data: {
					datasets: [
						{
							data: getTotalCountList(dataset, itemList),
							backgroundColor: ["#F7604D", "#4ED6B8", "#D7D768", "#DB9C3F"],
							label: "총 투표 현황"
						}
						],
						labels: itemList.map(function(elt, i, array) {return i+1 + ". " + elt.content;}),
				},
				options: optionsPie
		};

		pieChart = new Chart(ctxPie, configPie);
	}
}

function updateLineChart() {
	if (lineChart) {
		lineChart.options = optionsLine;
		lineChart.update();
	}
}

function updateBarChart() {
	if (barChart) {
		barChart.options = optionsBar;
		barChart.update();
	}
}
function updatePieChart() {
	if (pieChart) {
		pieChart.options = optionsPie;
		pieChart.update();
	}
}
function getGenderResultList(dataset, itemList, gender) {
	var result = [];
	var itemSeqList = itemList.map(obj => obj.survey_item_seq);
	for (var i = 0; i < itemSeqList.length; i++) {
		result[i] = dataset.filter(surveyObj => surveyObj.gender==gender && surveyObj.survey_item_seq==itemSeqList[i]).length;
	}
	return result;
}
function getTotalCountList(dataset, itemList) {
	var result = [];
	var itemSeqList = itemList.map(obj => obj.survey_item_seq);
	for (var i = 0; i < itemSeqList.length; i++) {
		result[i] = dataset.filter(surveyObj => surveyObj.survey_item_seq==itemSeqList[i]).length;
	}
	return result;
}
function getAgeCountList(dataset, itemList, age) {
	var result = [];
	var itemSeqList = itemList.map(obj => obj.survey_item_seq);
	if (age == 0) {
		for (var i = 0; i < itemSeqList.length; i++) {
			result[i] = dataset.filter(surveyObj => (surveyObj.age< 10 || surveyObj.age > 30) && surveyObj.survey_item_seq==itemSeqList[i]).length;
		}
	}
	else {
		for (var i = 0; i < itemSeqList.length; i++) {
			result[i] = dataset.filter(surveyObj => surveyObj.age==age && surveyObj.survey_item_seq==itemSeqList[i]).length;
		}
	}
	return result;
}
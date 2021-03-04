function createPagination(page, totalPage, displayPageNum, link) {
	var location = link;
	var page_ul = $(".pagination");
	var curPage = page;
	var totalPage = totalPage;
	var displayPageNum = displayPageNum;

	var startPage = Math.floor((curPage - 1) / displayPageNum) * displayPageNum + 1;
	var endPage = (curPage - 1) / displayPageNum * displayPageNum + displayPageNum;
	if (endPage > totalPage) {
		endPage = totalPage;
	}
	var li = $("<li>", {class:'page-link'});
	var a = $("<a>", {class:'page-btn', href: location + "&page="+(startPage-1), html: "«"});
	li.append(a);
	page_ul.append(li);
	if (startPage == 1) {
		li.addClass("disabled");
		a.attr("href", "#")
	}

	for (var i = startPage; i <= endPage; i++) {
		var li = $("<li>", {class:'page-link'});
		if (i == curPage) {
			li.addClass("active");
		}
		var a = $("<a>", {class:'page-btn', href: location + "&page="+i, html: i});
		li.append(a);
		page_ul.append(li);
	}

	var li = $("<li>", {class:'page-link'});
	var a = $("<a>", {class:'page-btn', href: location + "&page="+(endPage+1), html: "»"});
	li.append(a);
	page_ul.append(li);
	if (endPage >= totalPage) {
		li.addClass("disabled");
		a.attr("href", "#")
	}
}
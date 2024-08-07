/**
 * 날짜 튜닝하기
 * - 오늘 날짜라면 hh시 mm분
 * - 이번 년도이지만, 오늘 날짜가 아니라면 mm월 dd일
 * - 이번 년도가 아니라면 yyyy년 mm월 dd일
 *
 * - 시, 분, 월, 일은 10 이하에서는 한 자리만 뜨고 10이상일 땐 두 자리가 뜬다. 
 */
function getBdateStr(bdate) {
	// 오늘 날짜를 "yyyy-MM-dd" 형식으로 가져오기
	let today = new Date().toISOString().split('T')[0];

	// 입력 문자열에서 날짜와 시간을 분리
	let parts = bdate.split(" ", 2);
	if (parts.length < 2) {
		return bdate; // 형식이 맞지 않으면 원래 문자열 반환
	}

	let datePart = parts[0];
	let timePart = parts[1];

	// 날짜가 오늘과 일치하는지 확인
	if (datePart === today) {
		// 시간을 "HH:mm" 형식으로 변환
		let time = mTuning(timePart.substring(0, 2)) + "시 ";
		if (timePart.substring(3, 5) !== "00") {
			time += timePart.substring(3, 5) + "분";
		}
		return time;
	} else if (datePart.substring(0, 4) === today.substring(0, 4)) {
		// 연도를 뺀 날짜 반환
		let time = mTuning(datePart.substring(5, 7)) + "월 "
				+ datePart.substring(8) + "일 "
				+ mTuning(timePart.substring(0, 2)) + "시 "
				+ timePart.substring(3, 5) + "분";
		return time;
	} else {
		// 날짜 반환
		let time = datePart.substring(0, 4) + "년 "
				+ mTuning(datePart.substring(5, 7)) + "월 "
				+ datePart.substring(8) + "일";
		return time;
	}
}

function mTuning(time) {
	let m = parseInt(time, 10);
	return m.toString();
}


// 해당 jsp 파일에서만 텍스트 영역의 스크롤바를 없애고 내용에 따라 높이를 조정해 줄 예정
// srollHeight : 컨텐츠가 차지하는 공간 높이. 제이쿼리로는 접근을 못해서, DOM 객체로 변환 후 접근해야 함.
// $('#board_textarea')[0] : 해당 제이쿼리 객체에서 첫 번째 DOM 요소로 접근한다는 것을 의미.
function textareaAutoHeight(textarea){
	var $this = $(textarea);

	// 최소 높이 설정
	var minHeight = parseInt($this.css('min-height'));

	if ($this[0].scrollHeight > minHeight) {
		$this.css('height', 'auto');
		if ($this[0].scrollHeight > $this.height()) {
			$this.height($this[0].scrollHeight);
		}
	} else {
		$this.height(minHeight);
	}
}

function formatDates(){
	$('.date_str').each(function() {
		let bdateStr = $(this).text();
		let formattedDate = getBdateStr(bdateStr);
		$(this).text(formattedDate);
	});
}

$(document).ready(function() {    
	formatDates();

	// textarea 높이조절 기능(작성자)
	$('#board_textarea').on('input', function() {
		textareaAutoHeight(this);
	});

	// textarea 높이조절 기능(관리자 답변)
	$('.board-textarea.form-control').on('input',function(){
		textareaAutoHeight(this);
	});


	$('.board-form').on('submit', function(e){
		let contextPath = "${pageContext.request.contextPath}";
	    let modifyViewUrl = contextPath + "/board/modify_view";
	    
	    // form의 action이 특정 값과 일치할 경우
	    if ($("form").attr("action") === modifyViewUrl) {
	    	this.submit();
	    }else{
	    	e.preventDefault();

			if($('input[name="btitle"]').val().trim() == ""){
				alert("제목을 작성해 주십시오.");
				return;
			}else if($('input[name="btitle"]').val().length < 5){
				alert("제목은 최소 5글자 이상 작성하시기 바랍니다.");
				return;
			}else if(typeof $('textarea[name="bcontent"]').val() == 'undefined' || $('textarea[name="bcontent"]').val().trim == ""){
				alert("내용을 작성해 주십시오.");
				return;
			}else if($('textarea[name="bcontent"]').val().length < 20){
				alert("내용이 너무 짧습니다. 좀 더 길게 작성하십시오.");
				return;
			}else{
				this.submit();
			}
	    }		
	});
});
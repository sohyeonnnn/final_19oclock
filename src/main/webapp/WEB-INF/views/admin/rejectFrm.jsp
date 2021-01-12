<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>19시(관리자) :: 서비스 승인 거절 이유</title>
<script src="https://code.jquery.com/jquery-3.5.1.js"
	integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc="
	crossorigin="anonymous"></script>
</head>
<style>
.r-wrap {
	text-align: center;
}

fieldset {
	text-align: left;
	padding: 15px;
	padding-left: 80px;
}

fieldset input {
	margin: 2px;
	margin-left:90px;
}
</style>

<body>
	<div class="r-wrap">
		<img src="img/logo/logo_white.png" width="200px;">
		<fieldset>
			<b>서비스 :</b> ${service.STitle } (${service.MId })<br> <b>거절
				이유 :</b><br> 
				<input type="radio" name="reason" id="r1"> <label for="r1">카테고리 선택이 잘못되었습니다.</label><br> 
				<input type="radio" name="reason" id="r2"> <label for="r2">서비스 설명이 부족합니다.</label><br> 
				<input type="radio" name="reason" id="r3"> <label for="r3">부적절한 서비스입니다.</label><br> 
				<input type="radio" name="reason" id="r4" checked> <label for="r4">관리자에게 문의하세요.</label>
		</fieldset>
		<br> 위의 이유로 서비스 등록을 거절합니다.<br> <br>
		<button id="submit" onclick="">확인</button>
		<button id="close" onclick="window.close();">닫기</button>
	</div>
	<script>
		$("#submit").click(
				function() {

					// 현재 시간 구하기
					var now = new Date();
					var year = now.getFullYear();
					var month = now.getMonth() + 1;
					if (month < 10) {
						month = "0" + month;
					}
					var day = now.getDate();
					if (day < 10) {
						day = "0" + day;
					}
					var hour = now.getHours();
					var minute = now.getMinutes();
					if (minute < 10 & minute > 0) {
						minute = "0" + minute;
					}
					var ampm;
					if (hour < 12) {
						ampm = "오전 ";
						if (hour < 10) {
							hour = "0" + hour;
						}
					} else {
						ampm = "오후 ";
						if (hour > 12) {
							hour = hour - 12;
							if (hour < 10) {
								hour = "0" + hour;
							}
						}
					}

					var date = year + "년 " + month + "월 " + day + "일";
					var time = ampm + hour + ":" + minute; //보낸 시간
					var mNo = "${mNo}";
					mNo = Number(mNo);
					var userId = "${service.MId }";
					var freeId = "admin";
					//선택한 이유
					var content = $("input[type=radio]:checked").next().html(); 
					content="서비스 등록이 거절되었습니다.(이유 : "+content+")";
					
					//admin과 회원간의 채팅방 생성
					//거절이유보내기
					//adminApproval='n'
					$.ajax({
						url : "/makeRoom.do",
						type : "post",
						async : false,
						data : {
							sNo : 0,
							userId : userId,
							freeId : freeId,
							mNo : mNo
						},
						success : function(data) {
							console.log("111111");
							//방만들기 성공했을때
							var cNo = data.cNo; //방번호 
							cNo = Number(cNo);
							console.log(freeId);
							console.log(date);
							console.log(time);
							console.log(content);
							//거절이유 보내기
							$.ajax({
								url : "/insertChat.do",
								type : "post",
								async : false,
								data : {
									cNo:cNo,
									myId:freeId,
									date:date,
									time:time,
									content:content
								},
								success : function(data) {
									//adminApproval='n'
									console.log("22222222");
									var sNo = "${service.SNo}";
									sNo = Number(sNo);
									console.log(sNo);
									$.ajax({
										url : "/rejectService.do",
										type : "post",
										async : false,
										data : {
											sNo:sNo
										},
										success : function(data) {
											console.log("3333333");
										/*  window.close();   */
										},
										error : function() {

										}
									}); 
								},
								error : function() {

								}
							}); 
						},
						error : function() {

						}
					}); 
					
					
					
				/*  	$.ajax({
						url : "/makeRoom.do",
						type : "post",
						async : false,
						data : {
							sNo : 0,
							userId : userId,
							freeId : freeId,
							mNo : mNo
						},
						success : function(data) {
							var cNo = data.cNo; //방번호 
							cNo = Number(cNo);
							console.log(freeId);
							console.log(date);
							console.log(time);
							console.log(content);
							location.href = "/insertChat.do?cNo=" + cNo
									+ "+&myId=" + freeId + "&date=" + date
									+ "&time=" + time + "&content=" + content;
							 window.close();   
						},
						error : function() {

						}
					});  */

				});
	</script>
</body>
</html>
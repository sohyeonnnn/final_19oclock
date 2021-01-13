<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="/SE2/js/HuskyEZCreator.js" charset="utf-8"></script>
<script type="text/javascript" src="//code.jquery.com/jquery-1.11.0.min.js"></script>

<style>
   .page-wrap{
        width: 911px;
        height:1000px;
        margin: 0 auto;
        margin-top: 45px;
    }
	.text-box{
		height : 332px;
        padding-left: 30px;
		background-color: rgba(224, 224, 224, 0.5);
	}
    .text-box>div:first-child{
        height: 30px;
        padding-top: 30px;
    }
    .text-box>div:last-child{
        padding-top: 70px;
        font-size: 30px;
    }
    .form-control{
        float: left;
        margin-top: 13px;
        margin-right: 20px;
    }
    .back-btn{
        width: 103px;
        height: 40px;
        float: right;
        margin-top: 20px;
        margin-left : 15px;
        color: rgb(49, 76, 131);
        background-color: white;
        border-radius: 5px;
        border: 2px solid rgb(49, 76, 131);
        font-weight: bold;
    }

    .board-box{
        margin-top: 30px;
        border-bottom: 2px solid rgb(49, 76, 131);
    }

    .board-box>div:first-child{
        height: 500px;
        padding: 0 0px 20px 20px;
    }
    .title-box{
        background-color: rgba(224, 224, 224, 0.5);
    }
    .contact-user{
        width: 124px;
        height: 26px;
        font-size: 12px;
        color: rgb(49, 76, 131);
        border-radius: 5px;
        border: 2px solid rgb(49, 76, 131);
    }
    #title{
        width: 100%;
        height: 31px;
        border-radius: 3px;
        border: 1px solid rgb(204, 204, 204);
        background-color: white;
    }
    .save{
        color: white;
        border-radius: 5px;
        background-color:  rgb(49, 76, 131);
        border: 2px solid rgb(49, 76, 131);
    }
    
    .save:hover,
    .Listbtn:hover {
        border: 2px solid rgb(49, 76, 131);
        background-color: transparent;
        color: rgb(49, 76, 131);
        text-decoration: none;
    }
    
    .Listbtn{
    	width: 103px;
        height: 40px;
        float: right;
        margin-top: 20px;
        margin-left : 15px;
    	color: white;
        border-radius: 5px;
        background-color :rgb(49, 76, 131);
        text-align: center;
        line-height: 40px;
        font-weight: bold;
    }

    
</style>


</head>
<body>
<div class="header">
		<%@ include file="/WEB-INF/views/common/header.jsp"%>
	</div>
	 <div class="page-wrap">
        <div class="text-box">
            <div>홈 > 게시판 > 공지사항 > 수정하기</div>
            <div>공지사항_수정</div>
        </div>
         <div class="board-box">
        <form id="reqForm" action="/updateNotice.do?nNo=${n.NNo }" method="post" enctype="multipart/form-data">
            <table class="table title-box">
                <tr>
                    <th style="width: 10%;border-top: 2px solid rgb(49, 76, 131);text-align: center;line-height: 31px;">제목</th>
                    <th style="width: 75%;border-top: 2px solid rgb(49, 76, 131);">
                    	<%-- <input type="hidden" name="nNo" value="${n.NNo }"> --%>
                        <input type="text" name="nTitle" id="title" value="${n.NTitle }">
                    </th>
                    <th style="width: 15%;border-top: 2px solid rgb(49, 76, 131);text-align: center;"></th>
                </tr>
                <tr>
                    <th style="border-top: 0px;text-align: center;">첨부파일</th>
                    <th style="border-top: 0px">
                    	<input type="file" name="filename" value="찾기" multiple> 
                    </th>
                    <th style="border-top: 0px"></th>
                </tr>
            </table>
            <div>
				<table style="width:100%;height:500px;">
			        <tr>
			            <td>
			                <textarea id="smartEditor" name="nContent" style=" height:500px; ">
			                	 ${n.NContent }
			                </textarea>
			            </td>
			        </tr>
				</table>
            </div>
         
            <div>
            	<button class="back-btn save" id="savebutton">수정완료</button>
            	<a href="/noticeList.do" class="Listbtn">수정취소</a>
            </div>
            </form>
        </div>
         <br><br><br>
         
    <jsp:include page="/WEB-INF/views/common/footer.jsp" />
        
	</div>
	
	 <script type="text/javascript">
	    var oEditors = [];
	    nhn.husky.EZCreator.createInIFrame({ 
	    	oAppRef : oEditors, elPlaceHolder : "smartEditor", 
	    	sSkinURI : "SE2/SmartEditor2Skin.html", 
	    	fCreator : "createSEditor2", 
	    	htParams : { 
	    		bUseToolbar : true, 
	    		bUseVerticalResizer : false, 
	    		bUseModeChanger : false 
	    		} 
	    }); 
	    
	     $(function() { 
	    	$("#savebutton").click(function() { 
	    		oEditors.getById["smartEditor"].exec("UPDATE_CONTENTS_FIELD", []); 
	    		
	    		var title = $("#title").val(); 
	    		var content = document.getElementById("smartEditor").value; 
	    		if (title == null || title == "") { 
	    			alert("제목을 입력해주세요."); 
	    			$("#title").focus(); 
	    			return; 
	    			} 
	    		if(content == "" || content == null || content == '&nbsp;' || content == '<br>' || content == '<br/>' || content == '<p>&nbsp;</p>'){ 
	    			alert("본문을 작성해주세요."); 
	    			oEditors.getById["smartEditor"].exec("FOCUS"); 
	    			return; 
	    			} 
	    		
	    		var result = confirm("수정 하시겠습니까?"); 
	    		if(result){
	    			$("#reqForm").submit(); 
	   			}
	    		else{ 
	    			return; 
	    			} 
	    		}); 
	    	}) 
    </script>
	
	


</body>
</html>
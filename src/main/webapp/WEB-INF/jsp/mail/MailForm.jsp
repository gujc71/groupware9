<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

    <title><s:message code="common.pageTitle"/></title>
    <link href="css/sb-admin/bootstrap.min.css" rel="stylesheet">
    <link href="css/sb-admin/metisMenu.min.css" rel="stylesheet">
    <link href="css/sb-admin/sb-admin-2.css" rel="stylesheet">
    <link href="css/sb-admin/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

    <script src="js/jquery-2.2.3.min.js"></script>
    <script src="css/sb-admin/bootstrap.min.js"></script>
    <script src="css/sb-admin/metisMenu.min.js"></script>
    <script src="css/sb-admin/sb-admin-2.js"></script>
	<script src="js/project9.js"></script>    
	<script src="js/ckeditor/ckeditor.js"></script>

<script>
window.onload =function() {
	  CKEDITOR.replace( 'emcontents', { 'filebrowserUploadUrl': 'upload4ckeditor'});
}	  

function fn_formSubmit(){
	if ( ! chkInputValue("#strTo", "받는 사람 이메일 주소")) return false;
	if ( ! chkInputValue("#emsubject", "제목")) return false;

	CKEDITOR.instances["emcontents"].updateElement();
	if ( ! chkInputValue("#emcontents", "내용")) return false;
	
	$("#form1").submit();
} 
</script>
    
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-envelope-o fa-fw"></i> 메일작성</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row"> 
            	<form id="form1" name="form1" role="form" action="mailSave" method="post" onsubmit="return fn_formSubmit();" >
            		<input type="hidden" name="emno" value="<c:out value="${mailInfo.emno}"/>">
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                            <label class="col-lg-2">보내는  사람</label>
	                            <div class="col-lg-4">
		                           	<select id="emfrom" name="emfrom" class="form-control">
		                            	<c:forEach var="listview" items="${mailInfoList}" varStatus="status">
			                           		<option value="${listview.emino}">${listview.usernm} &lt;${listview.emiuser}&gt; </option>
									 	</c:forEach>
									</select>						
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-2">받는 사람</label>
	                            <div class="col-lg-10">
	                            	<input type="text" class="form-control" id="strTo" name="strTo">
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-2">참조</label>
	                            <div class="col-lg-10">
	                            	<input type="text" class="form-control" id="strCc" name="strCc">
	                            </div>
	                        </div>
	                    	<div class="row form-group"> 
	                            <label class="col-lg-2">숨은 참조</label>
	                            <div class="col-lg-10">
	                            	<input type="text" class="form-control" id="strBcc" name="strBcc">
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-2">제목</label>
	                            <div class="col-lg-10">
	                            	<input type="text" class="form-control" id="emsubject" name="emsubject" maxlength="255" value="<c:out value="${mailInfo.emsubject}"/>">
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <div class="col-lg-12">
	                            	<textarea class="form-control" id="emcontents" name="emcontents"><c:out value="${mailInfo.emcontents}"/></textarea>
	                            </div>
	                        </div>
	                    </div>
	                </div>
			        <button class="btn btn-outline btn-primary">보내기</button>
				</form>	
                
            </div>
            <!-- /.row -->
        </div> 
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>

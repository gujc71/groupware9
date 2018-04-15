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

<script>

function fn_formSubmit(){
	if (!confirm("저장 하시겠습니까?")) return;
	if ( ! chkInputValue("#emiimap", "IMAP 서버주소")) return false;
	if ( ! chkInputValue("#emiimapport", "IMAP 서버 포트")) return false;
	if ( ! chkInputValue("#emismtp", "SMTP 서버주소")) return false;
	if ( ! chkInputValue("#emismtpport", "SMTP 서버 포트")) return false;
	if ( ! chkInputValue("#emiuser", "계정 정보")) return false;
	if ( ! chkInputValue("#emipw", "비밀번호")) return false;
	
	$("#form1").submit();
} 

function fn_delete(){
	if (!confirm("삭제 하시겠습니까?")) return;
	$("#form1").attr("action", "mailInfoDelete");
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
                    <h1 class="page-header"><i class="fa fa-envelope-o fa-fw"></i> 메일정보관리</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
             
            <!-- /.row -->
            <div class="row">
            	<form id="form1" name="form1" role="form" action="mailInfoSave" method="post" >
            		<input type="hidden" name="emino" value="<c:out value="${mailInfoInfo.emino}"/>">
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                    		<label class="col-lg-6">연동할 메일서버 정보를 입력하세요. <br/> 
	                    		입력한 정보를 저장하시면, 해당 서버에서 메일을 가져오는데 시간이 걸릴 수 있습니다.</label>
	                            
	                        </div>  
	                    	<div class="row form-group"> 
	                            <label class="col-lg-2">IMAP 서버주소</label>
	                            <div class="col-lg-4">
	                            	<input type="text" class="form-control" id="emiimap" name="emiimap" maxlength="30"  value="<c:out value="${mailInfoInfo.emiimap}"/>">
	                            </div>
	                            <label class="col-lg-1">포트</label>
	                            <div class="col-lg-1">
	                            	<input type="text" class="form-control" id="emiimapport" name="emiimapport" maxlength="5" value="<c:out value="${mailInfoInfo.emiimapport}"/>">
	                            </div>
	                        </div> 
	                    	<div class="row form-group">
	                            <label class="col-lg-2">SMTP 서버주소</label>
	                            <div class="col-lg-4">
	                            	<input type="text" class="form-control" id="emismtp" name="emismtp" maxlength="30" value="<c:out value="${mailInfoInfo.emismtp}"/>">
	                            </div>
	                            <label class="col-lg-1">포트</label>
	                            <div class="col-lg-1">
	                            	<input type="text" class="form-control" id="emismtpport" name="emismtpport" maxlength="5"  value="<c:out value="${mailInfoInfo.emismtpport}"/>">
	                            </div>
	                        </div> 
	                    	<div class="row form-group">
	                            <label class="col-lg-2">계정</label>
	                            <div class="col-lg-4">
	                            	<input type="text" class="form-control" id="emiuser" name="emiuser" maxlength="50" value="<c:out value="${mailInfoInfo.emiuser}"/>">
	                            </div>
	                        </div> 
	                    	<div class="row form-group">
	                            <label class="col-lg-2">비밀번호</label>
	                            <div class="col-lg-4">
	                            	<input type="password" class="form-control" id="emipw" name="emipw" maxlength="20" value="<c:out value="${mailInfoInfo.emipw}"/>">
	                            </div>
	                        </div> 
	                    </div>
	                </div>
				</form>	
		        <button class="btn btn-outline btn-primary" onclick="fn_formSubmit()"><s:message code="common.btnSave"/></button>
		        <c:if test="${mailInfoInfo.emino!=null}">
		        	<button class="btn btn-outline btn-primary" onclick="fn_delete()"><s:message code="common.btnDelete"/></button>
		        </c:if>
            </div>
            <!-- /.row -->
        </div> 
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>

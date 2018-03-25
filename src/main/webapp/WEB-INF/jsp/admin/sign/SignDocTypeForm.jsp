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
	  CKEDITOR.replace( 'dtcontents', { 'filebrowserUploadUrl': 'upload4ckeditor'});
}	  

function fn_formSubmit(){
	CKEDITOR.instances["dtcontents"].updateElement();
	
	if ( ! chkInputValue("#dttitle", "문서양식명")) return false;
	
	$("#form1").submit();
} 
</script>
</head> 
<body>

    <div id="wrapper">

		<jsp:include page="../../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-edit fa-fw"></i> 결재문서양식</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
            	<form id="form1" name="form1" role="form" action="adSignDocTypeSave" method="post">
            		<input type="hidden" name="dtno" value="<c:out value="${signInfo.dtno}"/>">
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                            <label class="col-lg-2">문서양식명</label>
	                            <div class="col-lg-8">
	                            	<input type="text" class="form-control" id="dttitle" name="dttitle" maxlength="255" 
	                            	value="<c:out value="${signInfo.dttitle}"/>">
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-2">문서양식내용</label>
	                            <div class="col-lg-8">
	                            	<textarea class="form-control" id="dtcontents" name="dtcontents"><c:out value="${signInfo.dtcontents}"/></textarea>
	                            </div>
	                        </div>
	                    </div>
	                </div>
				</form>	
			        <button class="btn btn-outline btn-primary" onclick="fn_formSubmit();"><s:message code="common.btnSave"/></button>
			        <c:if test="${signInfo.dtno!=null}">
			        	<button class="btn btn-outline btn-primary" onclick="fn_moveToURL('adSignDocTypeDelete?dtno=<c:out value="${signInfo.dtno}"/>', '<s:message code="common.btnDelete"/>')" ><s:message code="common.btnDelete"/></button>
			        </c:if>
            </div>
            <!-- /.row -->
        </div> 
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>

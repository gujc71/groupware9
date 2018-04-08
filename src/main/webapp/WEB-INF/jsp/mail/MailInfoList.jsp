<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<link href="js/dynatree/ui.dynatree.css" rel="stylesheet" id="skinSheet"/>

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
	document.form1.submit();	
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
                <div class="col-lg-12">
		            <button type="button" class="btn btn-default pull-right" onclick="fn_moveToURL('mailInfoForm')">
		            <i class="fa fa-edit fa-fw"></i> 서버정보추가</button>      
				</div>
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-8">
            				<div class="table-responsive table-bordered">
                                <table class="table">
                                    <thead>
                                        <tr>
                                            <th>No.</th>
                                            <th>IMAP</th>
                                            <th>SMTP</th>
                                            <th>계정</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    	<c:forEach var="listview" items="${listview}" varStatus="status">
											<c:url var="link" value="mailInfoForm">
												<c:param name="emino" value="${listview.emino}" />
											</c:url> 
                                    	
	                                        <tr style="text-align:center">
	                                            <td><c:out value="${status.index+1}"/></td>
	                                            <td><a href="${link}"><c:out value="${listview.emiimap}"/></a></td>
	                                            <td><a href="${link}"><c:out value="${listview.emismtp}"/></a></td>
	                                            <td><a href="${link}"><c:out value="${listview.emiuser}"/></a></td>
	                                        </tr>
                                        </c:forEach>
                                    </tbody>
                                </table> 
                            </div>
				</div>                            
			</div>                                        
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>

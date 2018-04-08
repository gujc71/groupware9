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
</script>    
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-envelope-o fa-fw"></i> 받은 메일</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
				<div class="panel panel-default">
					<div class="panel-heading"><c:out value="${mailInfo.emsubject}"/></div>
	                <div class="panel-body">
						<div class="list-group">
							<div class="list-group-item"><label>보낸 사람</label> &nbsp;&nbsp;&nbsp;<c:out value="${mailInfo.emfrom}"/> <c:out value="${mailInfo.entrydate}"/></div>
							<div class="list-group-item"><label>받는 사람</label> &nbsp;&nbsp;&nbsp;
								<c:forEach var="item" items="${mailInfo.emto}" varStatus="status">
									<c:out value="${item.eaaddress}"/><c:if test="${!status.last}">;</c:if>
								</c:forEach>
							</div> 
							<c:if test="${mailInfo.emcc.size() > 0}">
								<div class="list-group-item"><label>참조</label> &nbsp;&nbsp;&nbsp;
									<c:forEach var="item" items="${mailInfo.emcc}" varStatus="status">
										<c:out value="${item.eaaddress}"/><c:if test="${!status.last}">;</c:if>
									</c:forEach>
								</div> 
							</c:if>
							<c:if test="${mailInfo.embcc.size() > 0}">
								<div class="list-group-item"><label>숨은 참조</label> &nbsp;&nbsp;&nbsp;
									<c:forEach var="item" items="${mailInfo.embcc}" varStatus="status">
										<c:out value="${item.eaaddress}"/><c:if test="${!status.last}">;</c:if>
									</c:forEach>
								</div> 
							</c:if>							
							<c:if test="${mailInfo.files.size() > 0}">
								<div class="list-group-item"><label>파일</label> &nbsp;&nbsp;&nbsp;
									<c:forEach var="item" items="${mailInfo.files}" varStatus="status">
										<a href="fileDownload?filename=<c:out value="${item.filename}"/>&downname=<c:out value="${item.realname }"/>"> 							 
										<c:out value="${item.filename}"/></a> <c:out value="${item.size2String()}"/>
									</c:forEach>
								</div> 
							</c:if>							
			            </div> 
			            <div class="col-lg-12">		
		                	<c:out value="${mailInfo.emcontents}" escapeXml="false"/>
		                </div>
	                </div> 
                </div>
                <button class="btn btn-outline btn-primary" onclick="fn_moveToURL('receiveMails')" ><s:message code="common.btnList"/></button>
                <button class="btn btn-outline btn-primary" onclick="fn_moveToURL('receiveMailDelete?emno=<c:out value="${mailInfo.emno}"/>', '<s:message code="common.btnDelete"/>')" ><s:message code="common.btnDelete"/></button>
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>

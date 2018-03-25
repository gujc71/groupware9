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
                <div class="col-lg-12">
		            <button type="button" class="btn btn-default pull-right" onclick="fn_moveToURL('adSignDocTypeForm')">
		            <i class="fa fa-edit fa-fw"></i> 양식추가</button>      
				</div>
            </div>
            <!-- /.row -->
            <div class="panel panel-default"> 
            	<div class="panel-body">
					<div class="listHead">
						<div class="listHiddenField pull-left field60"><s:message code="board.no"/></div>
						<div class="listTitle">문서종류명</div>
					</div>
					
					<c:if test="${listview.size()==0}">
						<div class="listBody height200">
						</div>
					</c:if>
					
					<c:forEach var="listview" items="${listview}" varStatus="status">
						<c:url var="link" value="adSignDocTypeForm">
							<c:param name="dtno" value="${listview.dtno}" />
						</c:url>
					
						<div class="listBody">
							<div class="listHiddenField pull-left field60 textCenter"><c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/></div>
							<div class="listTitle" title="<c:out value="${listview.dttitle}"/>">
								<a href="${link}"><c:out value="${listview.dttitle}"/></a>
							</div>
						</div>
					</c:forEach>	
					
					<br/>
					<form role="form" id="form1" name="form1"  method="post">
					    <jsp:include page="../../common/pagingforSubmit.jsp" />
				    
					</form>	
            	</div>    
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>

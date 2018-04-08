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

window.onload =function() {
	$.ajax({
		url: "getReceiveMail",
		type:"post", 
		dataType: "json",
		success: function(result){
			
		}
	})			    
}	  

function fn_formSubmit(){
	document.form1.submit();	
}

function fnCheckAll() {
	var	chk = $("#chkall").is(":checked");
	$('input:checkbox[name="checkRow"]').each(function() {
		this.checked = chk; 
	})	
}


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
                <div class="col-lg-12">
		            <button type="button" class="btn btn-default pull-right" onclick="form2.submit()">
		            <i class="fa fa-times fa-fw"></i> <s:message code="common.btnDelete"/></button>      
				</div>
            </div>
            <!-- /.row -->
            <div class="panel panel-default"> 
            	<div class="panel-body">
					<div class="listHead">
						<div class="listHiddenField pull-right field130">받은 날짜</div>
						<div class="listHiddenField pull-right field130">보낸 사람</div>
						<div class="listHiddenField pull-left">
							<input id="chkall" name="chkall" title="모두선택" onclick="fnCheckAll()" type="checkbox">
						</div>
						<div class="listTitle">제목</div>
					</div> 
					 
					<c:if test="${listview.size()==0}">
						<div class="listBody height200">
						</div>
					</c:if>
					
					<form role="form" id="form2" name="form2"  method="post" action="receiveMailsDelete">
					<c:forEach var="listview" items="${listview}" varStatus="status">
						<c:url var="link" value="receiveMailRead">
							<c:param name="emno" value="${listview.emno}" />
						</c:url> 
					
						<div class="listBody">
							<div class="listHiddenField pull-right field130 textCenter"><c:out value="${listview.entrydate}"/></div>
							<div class="listHiddenField pull-right field130 textCenter"><c:out value="${listview.emfrom}"/></div>
							<div class="listTitle" title="<c:out value="${listview.emsubject}"/>">
								<input type="checkbox" name="checkRow" value="<c:out value="${listview.emno}"/>"/> &nbsp;
								<a href="${link}"><c:out value="${listview.emsubject}"/></a>
							</div>
						</div>
					</c:forEach>
					</form>	
					
					<br/>
					<form role="form" id="form1" name="form1"  method="post">
					    <jsp:include page="../common/pagingforSubmit.jsp" />
				    
						<div class="form-group">
							<div class="checkbox col-lg-3 pull-left">
							 	<label class="pull-right">
							 		<input type="checkbox" name="searchType" value="emsubject" <c:if test="${fn:indexOf(searchVO.searchType, 'emsubject')!=-1}">checked="checked"</c:if>/>
		                        	제목
		                        </label>
							 	<label class="pull-right">
							 		<input type="checkbox" name="searchType" value="emcontents" <c:if test="${fn:indexOf(searchVO.searchType, 'emcontents')!=-1}">checked="checked"</c:if>/>
		                        	내용
		                        </label>
		                   </div>
		                   <div class="input-group custom-search-form col-lg-3">
	                                <input class="form-control" placeholder="Search..." type="text" name="searchKeyword" 
	                                	   value='<c:out value="${searchVO.searchKeyword}"/>' >
	                                <span class="input-group-btn">
	                                <button class="btn btn-default" onclick="fn_formSubmit()">
	                                    <i class="fa fa-search"></i>
	                                </button>
	                            </span>
	                       </div>
						</div>
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

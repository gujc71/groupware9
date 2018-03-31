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
		
		<form role="form" id="form1" name="form1"  method="post">
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-edit fa-fw"></i> 결제 받을(은) 문서</h1>
                </div>
            </div>

            <div class="row">
                <div class="col-lg-12">
				 	<label><input name="searchExt1" id="searchExt1" type="radio" value="" onclick="fn_formSubmit()" <c:if test='${searchVO.searchExt1==""}'>checked</c:if>> 전체</label>
				 	<label><input name="searchExt1" id="searchExt1" type="radio" value="0" onclick="fn_formSubmit()" <c:if test='${searchVO.searchExt1=="0"}'>checked</c:if>> 임시저장</label>
				 	<label><input name="searchExt1" id="searchExt1" type="radio" value="2" onclick="fn_formSubmit()" <c:if test='${searchVO.searchExt1=="2"}'>checked</c:if>> 진행중</label>
				 	<label><input name="searchExt1" id="searchExt1" type="radio" value="4" onclick="fn_formSubmit()" <c:if test='${searchVO.searchExt1=="4"}'>checked</c:if>> 완료</label>
				 	<label><input name="searchExt1" id="searchExt1" type="radio" value="3" onclick="fn_formSubmit()" <c:if test='${searchVO.searchExt1=="3"}'>checked</c:if>> 반려</label>
                </div>
            </div>
            
            <!-- /.row -->
            <div class="panel panel-default"> 
            	<div class="panel-body">
					<div class="listHead">
						<div class="listHiddenField pull-left field60"><s:message code="board.no"/></div>
						<div class="listHiddenField pull-right field100">종류</div>
						<div class="listHiddenField pull-right field100"><s:message code="crud.crdate"/></div>
						<div class="listHiddenField pull-right field100"><s:message code="crud.usernm"/></div>
						<div class="listHiddenField pull-right field100">상태</div>
						<div class="listTitle"><s:message code="crud.crtitle"/></div>
					</div>
					
					<c:if test="${listview.size()==0}">
						<div class="listBody height200">
						</div>
					</c:if>
					
					<c:forEach var="listview" items="${listview}" varStatus="status">
						<c:url var="link" value="signDocRead">
							<c:param name="docno" value="${listview.docno}" />
						</c:url>
					
						<div class="listBody">
							<div class="listHiddenField pull-left field60 textCenter"><c:out value="${searchVO.totRow-((searchVO.page-1)*searchVO.displayRowCount + status.index)}"/></div>
							<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.dttitle}"/></div>
							<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.updatedate}"/></div>
							<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.usernm}"/></div>
							<div class="listHiddenField pull-right field100 textCenter"><c:out value="${listview.docstatus}"/></div>
							<div class="listTitle" title="<c:out value="${listview.doctitle}"/>">
								<a href="${link}"><c:out value="${listview.doctitle}"/></a>
							</div>
						</div>
					</c:forEach>	
					
					<br/>
					    <jsp:include page="../common/pagingforSubmit.jsp" />
				    
						<div class="form-group">
							<div class="checkbox col-lg-3 pull-left">
							 	<label class="pull-right">
							 		<input type="checkbox" name="searchType" value="doctitle" <c:if test="${fn:indexOf(searchVO.searchType, 'doctitle')!=-1}">checked="checked"</c:if>/>
		                        	제목
		                        </label>
							 	<label class="pull-right">
							 		<input type="checkbox" name="searchType" value="doccontents" <c:if test="${fn:indexOf(searchVO.searchType, 'doccontents')!=-1}">checked="checked"</c:if>/>
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
            	</div>    
            </div>
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->
		</form>	

    </div>
    <!-- /#wrapper -->
</body>

</html>

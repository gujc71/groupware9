<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

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

var oldno = null;
function calendarDayMouseover(event, ssno, cddate){
	if (!ssno) {
		return;
	}
	
	$(".calendarTooltip").css({left: event.x+"px", top: event.y+"px"});
	$(".calendarTooltip").show();
	if (oldno===ssno) return;
	oldno=ssno;
    $.ajax({
    	url: "schRead4Ajax",
    	cache: false,
    	data: { ssno : ssno, cddate:cddate },
	    success: function(result){
	    	$(".calendarTooltip").html(result);
		}    
    });	
}

function calendarDayMouseout(){
	$(".calendarTooltip").hide();
}
</script>
    
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-calendar fa-fw"></i> 월간 일정</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            
            <!-- /.row -->
			<div class="row"> 
			     <div class="col-lg-10">
			         <h1>
			         <a href="#" onclick="fn_moveToURL('schList?year=<c:out value="${searchVO.year}"/>&month=<c:out value="${searchVO.month-1}"/>', '')"><i class="fa fa-angle-left fa-fw"></i></a>
			         
			         <c:out value="${searchVO.year}"/>년 <c:out value="${searchVO.month}"/>월
			         <a href="#" onclick="fn_moveToURL('schList?year=<c:out value="${searchVO.year}"/>&month=<c:out value="${searchVO.month+1}"/>', '')"><i class="fa fa-angle-right fa-fw"></i></a>
			         </h1>
			     </div>
			     <div class="col-lg-2">
	                	<button class="btn btn-outline btn-primary" style="margin-top:20px;" onclick="fn_moveToURL('schForm', '')" >일정추가</button>
			     </div>
            </div>
            <!-- /.row -->
			<div class="calendarRow" >
				<c:forTokens var="item" items="일,월,화,수,목,금,토" delims=",">
	             	<div class="calendarColumnHead">${item}</div>
				</c:forTokens>
			</div> 
			<div class="calendarRow">
					<c:forEach begin="1" end="${dayofweek}">
			             <div class="calendarColumnBox">
			             	<div class="calendarColumnDay">
			             	</div>
			             </div> 
				 	</c:forEach>	
				 	
					<c:forEach var="listview" items="${listview}" varStatus="status">
						<c:set var="cddayofweek" value="${listview.cddayofweek}"/>
						<c:if test='${cddayofweek=="1"}'> 
							</div>
							<div class="calendarRow">
						</c:if>  
						 
			             <div class="calendarColumnBox">
			             	<div class="calendarColumnDay <c:if test='${listview.cddayofweek=="1"}'>calendarColumnSunDay</c:if>">
			             		<a href="schForm?cddate=<c:out value="${listview.cddate}"/>"><c:out value="${listview.cddd}"/></a>
			             	</div>
							<c:forEach var="items" items="${listview.list}" varStatus="status">
				             	<div class="calendarDay" onmouseover="calendarDayMouseover(event, '<c:out value="${items.ssno}"/>', '<c:out value="${listview.cddate}"/>')" onmouseout="calendarDayMouseout()">
					             	<c:if test='${items.userno==sessionScope.userno}'> 
					             		<a href="schForm?ssno=<c:out value="${items.ssno}"/>&sdseq=<c:out value="${items.sdseq}"/>"><c:out value="${items.sstitle}"/></a>
				             		</c:if>
					             	<c:if test='${items.ssno!=null and items.userno!=sessionScope.userno}'> 
					             		<a href="schRead?ssno=<c:out value="${items.ssno}"/>&sdseq=<c:out value="${items.sdseq}"/>"><c:out value="${items.sstitle}"/></a>
				             		</c:if>
					             	<c:if test='${items.ssno==null}'> 
					             		<span style="color:<c:out value="${items.fontcolor}"/>"><c:out value="${items.sstitle}"/></span>
				             		</c:if>
				             	</div>
				             </c:forEach>
			             </div>
					</c:forEach> 
					<c:forEach begin="${cddayofweek}" end="6">
			             <div class="calendarColumnBox">
			             	<div class="calendarColumnDay">
			             	</div>
			             </div> 
				 	</c:forEach>	
			</div>	
			<p>&nbsp;</p>
			<p>&nbsp;</p>
			<p>&nbsp;</p> 
            <!-- /.row -->
        </div>
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    <div class="calendarTooltip"></div>
</body>

</html>

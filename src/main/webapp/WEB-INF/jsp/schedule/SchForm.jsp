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
	<link href="js/datepicker/datepicker.css" rel="stylesheet" type="text/css">
    
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
    <script src="js/datepicker/bootstrap-datepicker.js"></script>

<script>

window.onload = function() {
    $('#ssstartdate').datepicker().on('changeDate', function(ev) {
        if (ev.viewMode=="days"){
            $('#ssstartdate').datepicker('hide');
        }
    });
    $('#ssenddate').datepicker().on('changeDate', function(ev) {
        if (ev.viewMode=="days"){
            $('#ssenddate').datepicker('hide');
        }
    });
}

function fn_formSubmit(){
	if ( ! chkInputValue("#sstitle", "일정명")) return false;
	if ( ! chkInputValue("#crmemo", "내용")) return false;
	
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
                    <h1 class="page-header"><i class="fa fa-gear fa-fw"></i> <s:message code="crud.title"/></h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
            	<form id="form1" name="form1" role="form" action="schSave" method="post" onsubmit="return fn_formSubmit();" >
            		<input type="hidden" name="ssno" value="<c:out value="${schInfo.ssno}"/>">
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                            <label class="col-lg-1">일정명</label>
	                            <div class="col-lg-8">
	                            	<input type="text" class="form-control" id="sstitle" name="sstitle" maxlength="50" 
	                            	value="<c:out value="${schInfo.sstitle}"/>">
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">구분</label>
	                            <div class="col-lg-8">
									<c:forEach var="listview" items="${sstypelist}" varStatus="status">
		                            	<label style="margin-right: 5px"><input type="radio"  <c:if test='${listview.codecd==schInfo.sstype}'>checked</c:if> 
		                            		 id="sstype" name="sstype" value="<c:out value="${listview.codecd}"/>"> <c:out value="${listview.codenm}"/></label>
		                            </c:forEach>
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">일시</label>
	                            <div class="col-lg-2">
	                            	<input class="form-control" size="16" id="ssstartdate" name="ssstartdate" value="<c:out value="${schInfo.ssstartdate}"/>" readonly>
	                            </div>
	                            <div class="col-lg-1">
		                           	<select id="ssstarthour" name="ssstarthour" class="form-control">
										<c:forEach var="item" begin="1" end="24">
			                           		<option value="${item}" <c:if test='${item==schInfo.ssstarthour}'>selected</c:if>>${item}</option>
									 	</c:forEach>
									</select>						
								 </div>
	                            <div class="col-lg-1">
		                           	<select id="ssstartminute" name="ssstartminute" class="form-control">
										<c:forEach var="item" begin="00" end="50" step="10">
			                           		<option value="${item}" <c:if test='${item==schInfo.ssstartminute}'>selected</c:if>>${item}</option>
									 	</c:forEach>
									</select>						
								 </div>		            
	                             <div class="col-lg-2">
	                            	<input class="form-control" size="16" id="ssenddate" name="ssenddate" value="<c:out value="${schInfo.ssstartdate}"/>" readonly>
	                             </div> 
	                            <div class="col-lg-1">
		                           	<select id="ssendhour" name="ssendhour" class="form-control">
										<c:forEach var="item" begin="1" end="24">
			                           		<option value="${item}" <c:if test='${item==schInfo.ssendhour}'>selected</c:if>>${item}</option>
									 	</c:forEach>
									</select>						
								 </div>
	                            <div class="col-lg-1">
		                           	<select id="ssendminute" name="ssendminute" class="form-control">
										<c:forEach var="item" begin="00" end="50" step="10">
			                           		<option value="${item}" <c:if test='${item==schInfo.ssendminute}'>selected</c:if>>${item}</option>
									 	</c:forEach>
									</select>						
								 </div>		                            
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">반복</label>
	                            <div class="col-lg-2">
		                           	<select id="ssrepeattype" name="ssrepeattype" class="form-control">
		                           		<option value="1" <c:if test='${schInfo.ssrepeattype==1}'>selected</c:if>>반복없음</option>
		                           		<option value="2" <c:if test='${schInfo.ssrepeattype==2}'>selected</c:if>>주간반복</option>
		                           		<option value="3" <c:if test='${schInfo.ssrepeattype==3}'>selected</c:if>>월간반복</option>
									</select>						
	                            </div> 
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">공개</label>
	                            <div class="col-lg-8">
	                            	<label style="margin-right: 5px"><input type="radio" <c:if test='${schInfo.ssisopen=="Y"}'>checked</c:if> 
	                            		 id="ssisopen" name="ssisopen" value="Y"> 공개</label>
	                            	<label style="margin-right: 5px"><input type="radio" <c:if test='${schInfo.ssisopen=="N"}'>checked</c:if> 
	                            		 id="ssisopen" name="ssisopen" value="N"> 비공개</label>
	                            </div>
	                        </div> 
	                    	<div class="row form-group">
	                            <label class="col-lg-1"><s:message code="crud.crmemo"/></label>
	                            <div class="col-lg-8">
	                            	<textarea class="form-control" id="sscontents" name="sscontents"><c:out value="${schInfo.sscontents}"/></textarea>
	                            </div> 
	                        </div>
	                    </div>
	                </div>
			        <button class="btn btn-outline btn-primary"><s:message code="common.btnSave"/></button>
				</form>	
                
            </div>
            <!-- /.row -->
        </div> 
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
</body>

</html>

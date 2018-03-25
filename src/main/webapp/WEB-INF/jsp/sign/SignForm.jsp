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
	<link href="js/dynatree/ui.dynatree.css" rel="stylesheet"/> 
    <link href="css/sign.css" rel="stylesheet" type="text/css">

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

    <script src="js/jquery-ui.js"></script>
    <script src="js/dynatree/jquery.dynatree.js"></script>
<script>                        
window.onload =function() {
	  CKEDITOR.replace( 'doccontents', { 'filebrowserUploadUrl': 'upload4ckeditor'});
}	  

function fn_formSubmit(){
	CKEDITOR.instances["doccontents"].updateElement();

	if ( ! chkInputValue("#doctitle", "<s:message code="crud.crtitle"/>")) return false;
	if ( ! chkInputValue("#doccontents", "<s:message code="crud.crmemo"/>")) return false;
	
	$("#form1").submit();
} 
// 결재 경로
function fn_signPath(){
    $.ajax({
        url: "popupUsers4SignPath",
        type: "post"        
    }).success(function(result){
                $("#popupUsers").html(result);
                set_Users($("#docsignpath").val()); 
    });
    $("#popupUsers").modal("show");
}
function deptTreeInUsersActivate(node) {
    if (node==null || node.data.key==0) return;
    
    $.ajax({
        url: "popupUsers4Users",
        type:"post", 
        data: { deptno : node.data.key }        
    }).success(function(result){
                $("#userlist4Users").html(result);
    });
}

function fn_selectUsers(docsignpath) {
    $("#docsignpath").val(docsignpath);
    $("#popupUsers").modal("hide");
    
    var signPath = $("#signPath");
    signPath.empty();
     
	var typearr = ["기안", "합의", "결재"];
	var nos = docsignpath.split("||"); 
	for (var i in nos) {
		if (nos[i]==="") continue;
		var arr = nos[i].split(",");	// 사번, 이름, 기안/합의/결제, 직책 
	    var signArea = $("<div class='signArea'>");
	    signPath.append(signArea);
	    var signAreaTop = $("<div class='signAreaTop'>" + arr[3] + "</div>").appendTo(signArea);
	    var signAreaTop = $("<div class='signAreaCenter'>").appendTo(signArea);
	    var signAreaTop = $("<div class='signAreaBottom'>" + arr[1] +"</div>").appendTo(signArea);
	}
}

</script>
   
</head>

<body>

    <div id="wrapper">

		<jsp:include page="../common/navigation.jsp" />
		
        <div id="page-wrapper">
            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header"><i class="fa fa-edit fa-fw"></i> 기안하기</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
			        <button class="btn btn-outline btn-primary pull-right" onclick="fn_formSubmit()">결재상신</button>
			        <button class="btn btn-outline btn-primary pull-right" onclick="fn_signPath()">결재경로</button>
			    </div>
			</div>
            <div class="row" style="margin-top: 10px">
				<div id="signPath" class="signPath">
					<div class="signArea">
						<div class="signAreaTop">기안</div>
						<div class="signAreaCenter"> &nbsp; </div>
						<div class="signAreaBottom">구자철 </div>
					</div>				
				</div>
				<div class="signTitle"><br>결<br><br>재</div>
			</div>			            
            <div class="row" style="margin-top: 10px">
            	<form id="form1" name="form1" role="form" action="signSave" method="post" >
            		<input type="hidden" name="docno" value="<c:out value="${signInfo.docno}"/>">
            		<input type="hidden" name="dtno" value="<c:out value="${signInfo.dtno}"/>">
				    <input type="hidden" name="docsignpath" id="docsignpath"  value="<c:out value="${signInfo.docsignpath}"/>">
					<div class="panel panel-default">
	                    <div class="panel-body">
	                    	<div class="row form-group">
	                            <label class="col-lg-1">제목</label>
	                            <div class="col-lg-11">
	                            	<input type="text" class="form-control" id="doctitle" name="doctitle" maxlength="50" 
	                            	value="<c:out value="${signInfo.doctitle}"/>">
	                            </div>
	                        </div>
	                    	<div class="row form-group">
	                            <label class="col-lg-1">내용</label>
	                            <div class="col-lg-11">
	                            	<textarea class="form-control" id="doccontents" name="doccontents"><c:out value="${signInfo.doccontents}"/></textarea>
	                            </div>
	                        </div>
	                    </div>
	                </div>
				</form>	
            </div> 
            <!-- /.row -->
        </div> 
        <!-- /#page-wrapper -->

    </div>
    <!-- /#wrapper -->
    
  <div id="popupUsers" class="modal fade bs-example-modal-lg" tabindex="-1" role="dialog" 
    aria-labelledby="myLargeModalLabel"></div>    
</body>

</html>

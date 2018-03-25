<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

<script>
var selectedNode = null;

$(function(){
	$("#deptTree4Users").dynatree({
		children: <c:out value="${treeStr}" escapeXml="false"/>,
		onActivate: deptTreeInUsersActivate
	});
    $("#deptTree4Users").dynatree("getRoot").visit(function(node){
        node.expand(true);
    });
});

function set_Users(usernos) {
	if (usernos==="") {
		addRow(0, '<c:out value="${sessionScope.userno}"/>', '<c:out value="${sessionScope.usernm}"/>', '');
		return;
	}
	var nos = usernos.split("||");
	for (var i in nos) { 
		if (nos[i]==="") continue;
		var arr = nos[i].split(","); // 사번, 이름, 기안/합의/결제, 직책 
		addRow(arr[2], arr[0], arr[1], arr[3]);
	}
}

function fn_search4Users() {
	if ( ! chkInputValue("#keyword4Users", "<s:message code="common.keyword"/>")) return false;
	
    $.ajax({
    	url: "popupUsers4Users",
		type: "post", 
    	data: { searchKeyword : $("#keyword4Users").val() }    	
    }).success(function(result){
    			$("#userlist4Users").html(result);
		}    		
    );
}
function fn_addUser(userno, usernm, deptnm, userpos) {
    
    var chk = document.getElementById("tr"+userno);
    if (chk) {
    	alert("<s:message code="msg.err.existUser"/>");
    	return;
    }
    addRow(2, userno, usernm, userpos);
}

function addRow(optionIndex, userno, usernm, userpos) {
	var tr = $("<tr id='tr" + userno +"'>");
	$("#seletedUsers > tbody").append(tr);

	var td = $("<TD>");
	tr.append(td);
	
	var typearr = ["기안", "합의", "결재"];
	var select = $("<select>");
	td.append(select);
	for (var i=0; i<typearr.length;i++) {
		var option = $("<option value='"+ i + "'>" + typearr[i] + "</option>");
		select.append(option);
		select.val(optionIndex);
	}

	var td = $("<TD>");
	tr.append(td);
	td.text(usernm);
	
	td = $("<TD>");
	tr.append(td);
	td.html("<a href='javascript:fn_UserDelete(" + userno +")'><i class='fa fa-times fa-fw'></i></a>");
	
	if (userpos==="") userpos = typearr[optionIndex];
	td = $("<TD>");
	tr.append(td);
	td.html(userpos);
	td.css({"display": "none"});
}

function fn_UserDelete(userno) {
	$("#tr"+userno).remove();
}

function fn_closeUsers() {
	var ret = "";
	$("#seletedUsers > tbody  > tr").each(function() {
		if (!this.id) return; 
		var userno = this.id.replace("tr","");
		var usernm = $(this).find('td:eq(1)').text();
		var select = $(this).find('td:eq(0) > select').val();
		var userpos = $(this).find('td:eq(3)').text();
		ret += userno + "," +usernm + "," + select + "," + userpos + "||";
	});
	
	fn_selectUsers(ret)
}

</script>    

	  	<div class="modal-dialog modal-lg" role="document">
		    <div class="modal-content">
                <div class="modal-header">
                    <button type="button" id="closeX" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
	                <div class="col-lg-3 pull-right">
		                   	<div class="input-group custom-search-form">
	                        	<input class="form-control" type="text" id="keyword4Users" name="keyword4Users" onkeydown="if(event.keyCode == 13) { fn_search4Users();}">
	                            <span class="input-group-btn">
	                            	<button class="btn btn-default" onclick="fn_search4Users()"><i class="fa fa-search"></i></button>
	                            </span>
	                       	</div>
					</div>
                    <h4 class="modal-title" id="myModalLabel"><s:message code="memu.user"/></h4>
                </div>
                
                <div class="modal-body">
		            <!-- /.row -->
		            <div class="row">
		            	<div class="col-lg-4" >
			            	<div class="panel panel-default" >
			            		<div class="panel-heading">
			                            <s:message code="common.deptList"/>
			                    </div>
			                    <div class="maxHeight400">
							    	<div id="deptTree4Users">
									</div>
								</div>
							</div>
		                </div> 
		            	<div class="col-lg-4" >
			            	<div class="panel panel-default" >
			            		<div class="panel-heading">
			            			<s:message code="common.userList"/>
			                    </div>
			                    <div class="panel-body maxHeight400" id="userlist4Users">
							    </div>    
							</div>
						</div>	
		            	<div class="col-lg-4" >
			            	<div class="panel panel-default" >
			            		<div class="panel-heading">
			            			<s:message code="common.selectedUser"/>
			                    </div>
			                    <div class="panel-body maxHeight400">
									 <table  id="seletedUsers" class="table table-striped table-bordered table-hover">
										<colgroup>
											<col width='30%' />
											<col width='60%' />
											<col width='10%' />
										</colgroup>
										<thead>
											<tr>
												<th></th> 
												<th><s:message code="common.name"/></th>
												<th></th> 
												<th style="display:none"></th> 
											</tr>
										</thead>
										<tbody>
										</tbody>
									</table>
							    </div>    
							</div>
						</div>	
		            </div>
            		<!-- /.row -->                
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal" id="close"><s:message code="common.btnClose"/></button>
                    <button type="button" class="btn btn-primary" onclick="fn_closeUsers()"><s:message code="common.btnOK"/></button>
                </div>
		    </div>
	  	</div>
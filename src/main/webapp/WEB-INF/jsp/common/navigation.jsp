<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

        <nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
            <div class="navbar-header">
                <a class="navbar-brand" href="index"><s:message code="common.projectTitle"/></a>
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

	            <ul class="nav navbar-top-links navbar-right">
	                <!-- /.dropdown -->
                    <c:if test="${alertcount>0}">
		                <li class="dropdown">
		                    <a class="dropdown-toggle" data-toggle="dropdown" href="#" onclick="showAlertList()">
		                        <i class="fa fa-bell fa-fw"></i>  <i class="fa fa-caret-down"></i>
		                        	<div class="msgAlert"><c:out value="${alertcount}"/></div>
		                    </a>
		                    <script>
		                    	function showAlertList(){
		                    		$.ajax({
		                    			url: "alertList4Ajax", 
		                    			dataType: "html",
		                    			type:"post", 
		                    			success: function(result){
		                    				if (result!=="") {
		                    					$("#alertlist").html(result);
		                    				}
		                    			}
		                    		})		                    		
		                    	}
		                    </script>
		                    <ul id="alertlist" class="dropdown-menu dropdown-alerts">
		                    </ul>
		                    <!-- /.dropdown-alerts -->
		                </li>
                    </c:if>
	                <!-- /.dropdown -->
	                <li class="dropdown">
	                    <a class="dropdown-toggle" data-toggle="dropdown" href="#">
	                        <i class="fa fa-user fa-fw"></i>  <i class="fa fa-caret-down"></i>
	                    </a>
	                    <ul class="dropdown-menu dropdown-user">
	                        <li><a href="memberForm"><i class="fa fa-user fa-fw"></i> <c:out value="${sessionScope.usernm}"/></a></li>
	                        <li><a href="searchMember"><i class="fa fa-users fa-fw"></i> <s:message code="memu.users"/></a></li>
	                        <li class="divider"></li>
	                        <li><a href="memberLogout"><i class="fa fa-sign-out fa-fw"></i> Logout</a>
	                        </li>
	                    </ul>
	                    <!-- /.dropdown-user -->
	                </li>
	                <!-- /.dropdown -->
	            </ul>
	            <!-- /.navbar-top-links -->
            </div>
            <!-- /.navbar-header -->

            <div class="navbar-default sidebar" role="navigation">
                <div class="sidebar-nav navbar-collapse">
                    <ul class="nav" id="side-menu">
                        <li class="sidebar-search">
                           	<form id="searchForm" name="searchForm"  method="post" action="boardList">
                                <input type="hidden" name="searchType" value="brdtitle,brdmemo">
								<div class="input-group custom-search-form">
	                                <input class="form-control" type="text" name="globalKeyword" id="globalKeyword" placeholder="Search...">
	                                <span class="input-group-btn">
	                                    <button class="btn btn-default" type="button" onclick="fn_search()">
	                                        <i class="fa fa-search"></i>
	                                    </button>
	                                </span>
	                            </div>                           	
                            </form>
	                                <script>
	                                	function fn_search(){
	                                		if ($("#globalKeyword").val()!=="") {
		                                		$("#searchForm").submit();
	                                		}
	                                	}
	                                </script>                            <!-- /input-group -->
                        </li>
                        <li>
                            <a href="boardList"><i class="fa fa-files-o fa-fw"></i> <s:message code="board.boardName"/></a>
                        </li>
                        <li>
                            <a href="#"><i class="fa fa-edit fa-fw"></i> 전자결재<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
                                <li>
                                    <a href="signDocTypeList">기안하기</a>
                                </li>
                                <li>
		                            <a href="signListTobe">결재 받을(은) 문서 </a>
                                </li>
                                <li>
		                            <a href="signListTo">결재 할(한) 문서</a>
                                </li>
	                        </ul>                             
                        </li>                        
                        <li>
                            <a href="schList"><i class="fa fa-calendar fa-fw"></i> 일정관리</a>
                        </li>                        
                        <li>
                            <a href="#"><i class="fa fa-envelope-o fa-fw"></i> 메일<span class="fa arrow"></span></a>
							<ul class="nav nav-second-level">
                                <li>
                                    <a href="mailForm">새메일</a> 
                                </li>
                                <li>
		                            <a href="receiveMails">받은 메일</a>
                                </li>
                                <li>
		                            <a href="sendMails">보낸 메일</a>
                                </li>
	                        </ul>                             
                        </li>                        
                       
                        <c:if test='${sessionScope.userrole == "A"}'>
	                        <li>
	                            <a href="#"> <s:message code="memu.admin"/></a>
	                        </li>
	                        <li>
	                            <a href="adBoardGroupList"><i class="fa fa-files-o fa-fw"></i> <s:message code="memu.board"/></a>
	                        </li>
	                        <li>
	                            <a href="#"><i class="fa fa-sitemap fa-fw"></i> <s:message code="memu.organ"/><span class="fa arrow"></span></a>
	                            <ul class="nav nav-second-level">
	                                <li>
	                                    <a href="adDepartment"><s:message code="memu.dept"/></a>
	                                </li>
	                                <li>
	                                    <a href="adUser"><s:message code="memu.user"/></a>
	                                </li>
	                            </ul>
	                        </li>
                             <li>
                                 <a href="adSignDocTypeList"><i class="fa fa-edit fa-fw"></i> 결재문서양식</a>
                             </li>
	                	</c:if>	        
                    </ul>
                </div>
                <!-- /.sidebar-collapse -->
            </div>
            <!-- /.navbar-static-side -->
        </nav>


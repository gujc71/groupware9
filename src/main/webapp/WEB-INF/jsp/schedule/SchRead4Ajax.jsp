<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>

		<div class="panel panel-default">
             <div class="panel-body">
             	<div class="row form-group">
                     <label class="col-lg-2">일정명</label>
                     <div class="col-lg-10"><c:out value="${schInfo.sstitle}"/></div>
                 </div>
             	<div class="row form-group">
                     <label class="col-lg-2">구분</label>
                     <div class="col-lg-10"><c:out value="${schInfo.sstype}"/></div>
                 </div>
             	<div class="row form-group">
                     <label class="col-lg-2">일시</label>
                     <div class="col-lg-10"><c:out value="${schInfo.ssstartdate}"/> <c:out value="${schInfo.ssstarthour}"/>:<c:out value="${schInfo.ssstartminute}"/>
                     	~ <c:out value="${schInfo.ssstartdate}"/> <c:out value="${schInfo.ssendhour}"/>:<c:out value="${schInfo.ssendminute}"/>
                      </div> 
                 </div>
             	<div class="row form-group">
                     <label class="col-lg-2">반복</label>
                     <div class="col-lg-10"><c:out value="${schInfo.ssrepeattype}"/></div>
                 </div>
             	<div class="row form-group">
                     <label class="col-lg-2">공개</label>
                     <div class="col-lg-10"><c:out value="${schInfo.ssisopen}"/></div>
                 </div> 
             	<div class="row form-group">
                     <label class="col-lg-2">내용</label>
                     <div class="col-lg-10" style="max-height:100px; overflow:hidden"><c:out value="${schInfo.sscontents}"/></div> 
                 </div>
             </div>
         </div>

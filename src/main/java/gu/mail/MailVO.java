package gu.mail;

import java.util.ArrayList;

import gu.common.FileVO;

public class MailVO {
    private String  emno,
    			    emtype,		// 받은 / 보낸 메일
    				emfrom, 	//제목
    				emsubject,	// 제목
    				emcontents,	// 내용
    				entrydate,	// 날짜
    				userno,
    				usernm,
    				emino
    				;

    private String  strTo,
					strCc,
					strBcc;

    private ArrayList<String> emto = new ArrayList<String>();
    private ArrayList<String> emcc = new ArrayList<String>();
    private ArrayList<String> embcc = new ArrayList<String>();

    private ArrayList<FileVO> files = new ArrayList<FileVO>();

	public String getEmno() {
		return emno;
	}

	public void setEmno(String emno) {
		this.emno = emno;
	}

	public String getEmtype() {
		return emtype;
	}

	public void setEmtype(String emtype) {
		this.emtype = emtype;
	}

	public String getEmfrom() {
		return emfrom;
	}

	public void setEmfrom(String emfrom) {
		this.emfrom = emfrom;
	}

	public ArrayList<String> getEmto() {
		return emto;
	}

	public void setEmto(ArrayList<String> emto) {
		this.emto = emto;
	}

	public ArrayList<String> getEmcc() {
		return emcc;
	}

	public void setEmcc(ArrayList<String> emcc) {
		this.emcc = emcc;
	}

	public ArrayList<String> getEmbcc() {
		return embcc;
	}

	public void setEmbcc(ArrayList<String> embcc) {
		this.embcc = embcc;
	}

	public String getEmsubject() {
		return emsubject;
	}

	public void setEmsubject(String emsubject) {
		this.emsubject = emsubject;
	}

	public String getEmcontents() {
		return emcontents;
	}

	public void setEmcontents(String emcontents) {
		this.emcontents = emcontents;
	}

	public String getEntrydate() {
		return entrydate;
	}

	public void setEntrydate(String entrydate) {
		this.entrydate = entrydate;
	}

	public String getUserno() {
		return userno;
	}

	public void setUserno(String userno) {
		this.userno = userno;
	}

	public String getUsernm() {
		return usernm;
	}

	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}

	public ArrayList<FileVO> getFiles() {
		return files;
	}

	public void setFiles(ArrayList<FileVO> files) {
		this.files = files;
	}

	public String getStrTo() {
		return strTo;
	}

	public String getStrCc() {
		return strCc;
	}

	public String getStrBcc() {
		return strBcc;
	}

	public void setStrTo(String strTo) {
		this.strTo = strTo;
	}

	public void setStrCc(String strCc) {
		this.strCc = strCc;
	}

	public void setStrBcc(String strBcc) {
		this.strBcc = strBcc;
	}

	public String getEmino() {
		return emino;
	}

	public void setEmino(String emino) {
		this.emino = emino;
	}
    
}
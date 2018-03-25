package gu.sign;

public class SignVO {

    private String docno,
				    doctitle,
				    doccontents,
				    docstatus,		// 문서 상태
				    docstep,		// 결재 단
				    dtno,			// 양식번호
				    dttitle,		// 양식명
				    userno,
				    usernm,
				    deptnm,
				    updatedate
				    ;

	public String getDocno() {
		return docno;
	}

	public String getDoctitle() {
		return doctitle;
	}

	public String getDoccontents() {
		return doccontents;
	}

	public String getDocstatus() {
		return docstatus;
	}

	public String getDocstep() {
		return docstep;
	}

	public String getDtno() {
		return dtno;
	}

	public String getUserno() {
		return userno;
	}

	public String getUsernm() {
		return usernm;
	}

	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}

	public String getDeptnm() {
		return deptnm;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public void setDoctitle(String doctitle) {
		this.doctitle = doctitle;
	}

	public void setDoccontents(String doccontents) {
		this.doccontents = doccontents;
	}

	public void setDocstatus(String docstatus) {
		this.docstatus = docstatus;
	}

	public void setDocstep(String docstep) {
		this.docstep = docstep;
	}

	public void setDtno(String dtno) {
		this.dtno = dtno;
	}

	public String getDttitle() {
		return dttitle;
	}

	public void setDttitle(String dttitle) {
		this.dttitle = dttitle;
	}

	public void setUserno(String userno) {
		this.userno = userno;
	}

	public void setDeptnm(String deptnm) {
		this.deptnm = deptnm;
	}

	public String getUpdatedate() {
		return updatedate;
	}

	public void setUpdatedate(String updatedate) {
		this.updatedate = updatedate;
	} 
    
}

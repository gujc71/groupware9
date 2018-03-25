package gu.admin.sign;

public class SignDocTypeVO {

    private String  dtno,    	// 번호
    				dttitle,    // 제목
    				dtcontents	// 양식 내용
    ;

	public String getDtno() {
		return dtno;
	}

	public String getDttitle() {
		return dttitle;
	}

	public String getDtcontents() {
		return dtcontents;
	}

	public void setDtno(String dtno) {
		this.dtno = dtno;
	}

	public void setDttitle(String dttitle) {
		this.dttitle = dttitle;
	}

	public void setDtcontents(String dtcontents) {
		this.dtcontents = dtcontents;
	}
}

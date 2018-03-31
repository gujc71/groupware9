package gu.sign;

public class SignVO {

    private String  ssno,		// 결재번호
					docno,		// 문서번호
					ssstep, 	// 결재단계
					sstype,		// 결재종류
					ssresult,	// 결재결과
					sscomment,	// 코멘트
					receivedate,
					signdate,
					userno,
					usernm,
					userpos;	// 직위

	public String getSsno() {
		return ssno;
	}

	public String getDocno() {
		return docno;
	}

	public String getSsstep() {
		return ssstep;
	}

	public String getSstype() {
		return sstype;
	}

	public String getSsresult() {
		return ssresult;
	}

	public String getSscomment() {
		return sscomment;
	}

	public String getReceivedate() {
		return receivedate;
	}

	public String getSigndate() {
		return signdate;
	}

	public String getUserno() {
		return userno;
	}

	public void setSsno(String ssno) {
		this.ssno = ssno;
	}

	public void setDocno(String docno) {
		this.docno = docno;
	}

	public void setSsstep(String ssstep) {
		this.ssstep = ssstep;
	}

	public void setSstype(String sstype) {
		this.sstype = sstype;
	}

	public void setSsresult(String ssresult) {
		this.ssresult = ssresult;
	}

	public void setSscomment(String sscomment) {
		this.sscomment = sscomment;
	}

	public void setReceivedate(String receivedate) {
		this.receivedate = receivedate;
	}

	public void setSigndate(String signdate) {
		this.signdate = signdate;
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

	public String getUserpos() {
		return userpos;
	}

	public void setUserpos(String userpos) {
		this.userpos = userpos;
	}
    
}

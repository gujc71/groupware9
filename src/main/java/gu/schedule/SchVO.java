package gu.schedule;

public class SchVO {

    private String  ssno,				//일정번호
				    sstitle,			//일정명
				    sstype,				//구분
				    ssstartdate,		//시작일
				    ssstarthour,		//시작일-시간
				    ssstartminute,		//시작일-분
				    ssenddate,			//종료일
				    ssendhour,			//종료일-시간
				    ssendminute,		//종료일-분
				    ssrepeattype,		//반복
				    ssrepeattypenm,
				    ssrepeatoption,		//반복 옵션- 주
				    ssrepeatend,		//반복종료
				    sscontents,			//내용
				    ssisopen,			//공개여부
				    userno,				//사용자번호
				    usernm				
    ;

	public String getSsno() {
		return ssno;
	}

	public String getSstitle() {
		return sstitle;
	}

	public String getSstype() {
		return sstype;
	}

	public String getSsstartdate() {
		return ssstartdate;
	}

	public String getSsstarthour() {
		return ssstarthour;
	}

	public String getSsstartminute() {
		return ssstartminute;
	}

	public String getSsenddate() {
		return ssenddate;
	}

	public String getSsendhour() {
		return ssendhour;
	}

	public String getSsendminute() {
		return ssendminute;
	}

	public String getSsrepeattype() {
		return ssrepeattype;
	}

	public String getSsrepeatend() {
		return ssrepeatend;
	}

	public String getSscontents() {
		return sscontents;
	}

	public String getSsisopen() {
		return ssisopen;
	}

	public String getUserno() {
		return userno;
	}

	public void setSsno(String ssno) {
		this.ssno = ssno;
	}

	public void setSstitle(String sstitle) {
		this.sstitle = sstitle;
	}

	public void setSstype(String sstype) {
		this.sstype = sstype;
	}

	public void setSsstartdate(String ssstartdate) {
		this.ssstartdate = ssstartdate;
	}

	public void setSsstarthour(String ssstarthour) {
		this.ssstarthour = ssstarthour;
	}

	public void setSsstartminute(String ssstartminute) {
		this.ssstartminute = ssstartminute;
	}

	public void setSsenddate(String ssenddate) {
		this.ssenddate = ssenddate;
	}

	public void setSsendhour(String ssendhour) {
		this.ssendhour = ssendhour;
	}

	public void setSsendminute(String ssendminute) {
		this.ssendminute = ssendminute;
	}

	public void setSsrepeattype(String ssrepeattype) {
		this.ssrepeattype = ssrepeattype;
	}

	public String getSsrepeattypenm() {
		return ssrepeattypenm;
	}

	public void setSsrepeattypenm(String ssrepeattypenm) {
		this.ssrepeattypenm = ssrepeattypenm;
	}

	public void setSsrepeatend(String ssrepeatend) {
		this.ssrepeatend = ssrepeatend;
	}

	public void setSscontents(String sscontents) {
		this.sscontents = sscontents;
	}

	public void setSsisopen(String ssisopen) {
		this.ssisopen = ssisopen;
	}

	public void setUserno(String userno) {
		this.userno = userno;
	}

	public String getSsrepeatoption() {
		return ssrepeatoption;
	}

	public void setSsrepeatoption(String ssrepeatoption) {
		this.ssrepeatoption = ssrepeatoption;
	}

	public String getUsernm() {
		return usernm;
	}

	public void setUsernm(String usernm) {
		this.usernm = usernm;
	}    
}

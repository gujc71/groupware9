package gu.mail;


public class MailAddressVO {
    private String  emno,
    				eatype,
    				eaaddress;   
    private Integer easeq;
    
	public String getEmno() {
		return emno;
	}
	
	public void setEmno(String emno) {
		this.emno = emno;
	}
	
	public String getEatype() {
		return eatype;
	}
	
	public void setEatype(String eatype) {
		this.eatype = eatype;
	}
	
	public String getEaaddress() {
		return eaaddress;
	}
	
	public void setEaaddress(String eaaddress) {
		this.eaaddress = eaaddress;
	}
	
	public Integer getEaseq() {
		return easeq;
	}
	
	public void setEaseq(Integer easeq) {
		this.easeq = easeq;
	} 
} 
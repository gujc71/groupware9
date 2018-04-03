package gu.schedule;

import java.util.List;

public class CalendarVO {

    private String  cddate;    	//  날짜
    private Integer cddd;
    private Integer cddayofweek;
    private List<?> list;
    
	public String getCddate() {
		return cddate;
	}
	
	public List<?> getList() {
		return list;
	}
	
	public Integer getCddd() {
		return cddd;
	}

	public void setCddd(Integer cddd) {
		this.cddd = cddd;
	}

	public void setCddate(String cddate) {
		this.cddate = cddate;
	}
	
	public Integer getCddayofweek() {
		return cddayofweek;
	}

	public void setCddayofweek(Integer cddayofweek) {
		this.cddayofweek = cddayofweek;
	}

	public void setList(List<?> list) {
		this.list = list;
	}
    
    
}
 
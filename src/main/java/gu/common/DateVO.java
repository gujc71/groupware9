package gu.common;

import java.util.List;

public class DateVO {
    private int year;
    private int month;
    private int day;
    private String date, week;
    private boolean istoday = false;
    private List<?> list; 
    
    public int getYear() {
        return year;
    }
    
    public void setYear(int year) {
        this.year = year;
    }
    
    public int getMonth() {
        return month;
    }
    
    public void setMonth(int month) {
        this.month = month;
    }
    
    public int getDay() {
        return day;
    }
    
    public void setDay(int day) {
        this.day = day;
    }
    
    public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}

	public String getWeek() {
        return week;
    }
    
    public void setWeek(String week) {
        this.week = week;
    }
    
    public boolean isIstoday() {
        return istoday;
    }
    
    public void setIstoday(boolean istoday) {
        this.istoday = istoday;
    }

	public List<?> getList() {
		return list;
	}

	public void setList(List<?> list) {
		this.list = list;
	}
   
   
}
package gu.mail;

import java.util.ArrayList;

public class ImportMailVO {
    private String from;
    private ArrayList<String> to = new ArrayList<String>();
    private ArrayList<String> cc = new ArrayList<String>();
    private ArrayList<String> bcc = new ArrayList<String>();
    private ArrayList<String> file = new ArrayList<String>();
    
    private String  subject,
    				conents,
    				entrydate
    				;

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public ArrayList<String> getTo() {
		return to;
	}

	public void setTo(ArrayList<String> to) {
		this.to = to;
	}

	public ArrayList<String> getCc() {
		return cc;
	}

	public void setCc(ArrayList<String> cc) {
		this.cc = cc;
	}

	public ArrayList<String> getBcc() {
		return bcc;
	}

	public void setBcc(ArrayList<String> bcc) {
		this.bcc = bcc;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getConents() {
		return conents;
	}

	public void setConents(String conents) {
		this.conents = conents;
	}

	public String getEntrydate() {
		return entrydate;
	}

	public void setEntrydate(String entrydate) {
		this.entrydate = entrydate;
	}

	public ArrayList<String> getFile() {
		return file;
	}

	public void setFile(ArrayList<String> file) {
		this.file = file;
	}

    
}
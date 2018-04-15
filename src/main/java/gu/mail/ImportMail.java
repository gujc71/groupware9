package gu.mail;

import java.util.*;

import javax.servlet.http.HttpSession;

import gu.common.Field3VO;
import gu.common.LocaleMessage;
import gu.mail.MailVO;

public class ImportMail  implements Runnable {
	private MailSvc mailSvc;
	private String userno;
	private HttpSession session;
	
	public ImportMail(MailSvc mailSvc, String userno, HttpSession session) {
        this.mailSvc = mailSvc;
        this.userno = userno;
        this.session = session;
    }
	
	public void run() {
	 	Imap mail = new Imap();
	 	List<?> list = mailSvc.selectMailInfoList(userno);
        try {
        	for (int i=0; i<list.size();i++) {
        		MailInfoVO mivo = (MailInfoVO) list.get(i);
            	String lastdate = mailSvc.selectLastMail(mivo.getEmino());
             	
        	 	mail.connect(mivo.getEmiimap(), mivo.getEmiuser(), mivo.getEmipw());
        	 	Integer total = mail.patchMessage(lastdate);
        	 	
        	 	int cnt = 0;
        	 	while (cnt < total) {
        	     	ArrayList<MailVO> msgList = mail.getMail(cnt);
        	     	mailSvc.insertMails(msgList, userno, mivo.getEmino());
        	     	cnt += msgList.size();
        	 	}
        	 	mail.disconnect();        		
        	}
        }catch(Exception e) {
        }
	 	session.removeAttribute("mail"); // 중복 실행 방지
    }

	public MailSvc getMailSvc() {
		return mailSvc;
	}

	public void setMailSvc(MailSvc mailSvc) {
		this.mailSvc = mailSvc;
	}

	public String getUserno() {
		return userno;
	}

	public void setUserno(String userno) {
		this.userno = userno;
	}

	public HttpSession getSession() {
		return session;
	}

	public void setSession(HttpSession session) {
		this.session = session;
	}
	
}

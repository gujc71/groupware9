package gu.mail;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.common.SearchVO;
import gu.etc.EtcSvc;

@Controller 
public class MailCtr {

    @Autowired
    private MailSvc mailSvc;
    
    @Autowired
    private EtcSvc etcSvc; 
    
    static final Logger LOGGER = LoggerFactory.getLogger(MailCtr.class);
    
    /**
     * 리스트.
     */
    @RequestMapping(value = "/receiveMails")
    public String receiveMails(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        List<?> mailInfoList = mailSvc.selectMailInfoList(userno);
    	if (mailInfoList.size()==0) return "mail/MailInfoGuide";
    	
        // 페이지 공통: alert
        Integer alertcount = etcSvc.selectAlertCount(userno);
        modelMap.addAttribute("alertcount", alertcount);
    	
        // 
        searchVO.setSearchExt1("R");
        searchVO.pageCalculate( mailSvc.selectReceiveMailCount(searchVO) ); // startRow, endRow
        List<?> listview  = mailSvc.selectReceiveMailList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "mail/ReceiveMails";
    }
    
    @RequestMapping(value = "/sendMails")
    public String sendMails(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        List<?> mailInfoList = mailSvc.selectMailInfoList(userno);
    	if (mailInfoList.size()==0) return "mail/MailInfoGuide";

    	// 페이지 공통: alert
        Integer alertcount = etcSvc.selectAlertCount(userno);
        modelMap.addAttribute("alertcount", alertcount);
    	
        // 
        searchVO.setSearchExt1("S");
        searchVO.pageCalculate( mailSvc.selectReceiveMailCount(searchVO) ); // startRow, endRow
        List<?> listview  = mailSvc.selectReceiveMailList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "mail/SendMails";
    }
    
    /** 
     * 쓰기. 
     */
    @RequestMapping(value = "/mailForm")
    public String mailForm(HttpServletRequest request, MailVO mailInfo, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
        List<?> mailInfoList = mailSvc.selectMailInfoList(userno);
    	if (mailInfoList.size()==0) return "mail/MailInfoGuide";
        
        // 페이지 공통: alert
        Integer alertcount = etcSvc.selectAlertCount(userno);
        modelMap.addAttribute("alertcount", alertcount);
    	
        // 
        modelMap.addAttribute("mailInfoList", mailInfoList);
        
        if (mailInfo.getEmno() != null) {
            mailInfo = mailSvc.selectReceiveMailOne(mailInfo);
        
            modelMap.addAttribute("mailInfo", mailInfo);
        }
        
        return "mail/MailForm";
    }
    
    /**
     * 저장.
     */
    @RequestMapping(value = "/mailSave")
    public String mailSave(HttpServletRequest request, MailVO mailInfo) {
        String userno = request.getSession().getAttribute("userno").toString();

    	mailInfo.setUserno(userno);
    	mailInfo.setEmtype("S");
    	
        mailSvc.insertMail(mailInfo);

        return "redirect:/sendMails";
    }

    /**
     * 읽기.
     */
    @RequestMapping(value = "/receiveMailRead")
    public String receiveMailRead(HttpServletRequest request, MailVO mailVO, ModelMap modelMap) {
    	mailRead(request, mailVO, modelMap);
        
        return "mail/ReceiveMailRead";
    }
    
    @RequestMapping(value = "/sendMailRead")
    public String sendMailRead(HttpServletRequest request, MailVO mailVO, ModelMap modelMap) {
    	
    	mailRead(request, mailVO, modelMap);
    	
        return "mail/SendMailRead";
    }
    
    private void mailRead(HttpServletRequest request, MailVO mailVO, ModelMap modelMap) {
        // 페이지 공통: alert
    	String userno = request.getSession().getAttribute("userno").toString();
        
        Integer alertcount = etcSvc.selectAlertCount(userno);
        modelMap.addAttribute("alertcount", alertcount);
    	
        // 
        
        MailVO mailInfo = mailSvc.selectReceiveMailOne(mailVO);

        modelMap.addAttribute("mailInfo", mailInfo);
    }
    
    /**
     * 삭제.
     */
    @RequestMapping(value = "/receiveMailDelete")
    public String receiveMailDelete(HttpServletRequest request, MailVO mailVO) {

        mailSvc.deleteMail(mailVO);
        
        return "redirect:/receiveMails";
    }
    @RequestMapping(value = "/receiveMailsDelete")
    public String receiveMailsDelete(HttpServletRequest request, String[] checkRow) {

        mailSvc.deleteMails(checkRow);
        
        return "redirect:/receiveMails";
    }

    @RequestMapping(value = "/sendMailDelete")
    public String sendMailDelete(HttpServletRequest request, MailVO mailVO) {

        mailSvc.deleteMail(mailVO);
        
        return "redirect:/sendMails";
    }
    @RequestMapping(value = "/sendMailsDelete")
    public String sendMailsDelete(HttpServletRequest request, String[] checkRow) {

        mailSvc.deleteMails(checkRow);
        
        return "redirect:/sendMails";
    }
    /**
     * 
     */
    @RequestMapping(value = "/getReceiveMail")
    public String importMail(HttpServletRequest request, ModelMap modelMap) {
        HttpSession session = request.getSession();
        
        if ( session.getAttribute("mail")!=null)return "";
        
        session.setAttribute("mail", "ing");
        
    	String userno = session.getAttribute("userno").toString();
 	
        Thread t = new Thread(new ImportMail(mailSvc, userno, session) );
        t.start();
        
	    return "";
    }
     
}

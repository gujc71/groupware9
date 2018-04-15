package gu.mail;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.mail.MessagingException;

import org.mybatis.spring.SqlSessionTemplate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionException;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import gu.common.FileVO;
import gu.common.SearchVO;

@Service
public class MailSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;

    static final Logger LOGGER = LoggerFactory.getLogger(MailSvc.class);
    
    /**
     * 리스트.
     */
    public Integer selectReceiveMailCount(SearchVO param) {
        return sqlSession.selectOne("selectReceiveMailCount", param);
    }
    
    public List<?> selectReceiveMailList(SearchVO param) {
        return sqlSession.selectList("selectReceiveMailList", param);
    }
    
    /**
     * 읽기.
     */
    public MailVO selectReceiveMailOne(MailVO param) {
    	MailVO mail = sqlSession.selectOne("selectReceiveMailOne", param);
    	if (mail!=null) {
    		MailAddressVO mavo = new gu.mail.MailAddressVO();
    		mavo.setEmno(param.getEmno());
    		mavo.setEatype("t");
        	ArrayList <?> a = (ArrayList<?>) sqlSession.selectList("selectMailAddressList", mavo);
        	mail.setEmto( (ArrayList<String>) a );
    		mavo.setEatype("c");
        	a = (ArrayList<?>) sqlSession.selectList("selectMailAddressList", mavo);
        	mail.setEmcc( (ArrayList<String>) a );
    		mavo.setEatype("b");
        	a = (ArrayList<?>) sqlSession.selectList("selectMailAddressList", mavo);
        	mail.setEmbcc( (ArrayList<String>) a );

        	a = (ArrayList<?>) sqlSession.selectList("selectMailFileList", mavo);
        	mail.setFiles( (ArrayList<FileVO>) a );
        	
    	}
        return mail;
    }

    /**
     * 삭제.
     */
    public void deleteMail(MailVO param) {
        sqlSession.update("deleteMail", param);
    }

    /**
     * 삭제.
     */
    public void deleteMails(String[] param) {
    	HashMap hm = new HashMap();
    	hm.put("list", param) ;

    	sqlSession.insert("deleteMails", hm);
    }
    
    /*
     * 
     */

    public void insertMails(ArrayList<MailVO> param, String userno, String emino) {
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);

        try {
	    	for (int i=0; i<param.size(); i++) {
	    		MailVO mail = param.get(i);
	    		mail.setUserno(userno);
	    		mail.setEmtype("R");
	    		mail.setEmino(emino);
	    		insertMailOne(mail); 
	    	}
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertMails");
        }        
    }
    
    public void insertMail(MailVO param) {
    	DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);

    	String[] to = param.getStrTo().split(";");
    	String[] cc = {};
    	String[] bcc = {};
    	if (!"".equals(param.getStrCc())) cc = param.getStrCc().split(";");
    	if (!"".equals(param.getStrBcc())) bcc = param.getStrBcc().split(";");
    	
    	param.setEmto( new ArrayList<String>( Arrays.asList(to) ) );
    	param.setEmcc( new ArrayList<String>( Arrays.asList(cc) ) );
    	param.setEmbcc( new ArrayList<String>( Arrays.asList(bcc) ) );
    	
        try {
        	MailInfoVO fromVO = sqlSession.selectOne("selectMailInfoOne", param.getEmfrom());
        	param.setEmino(param.getEmfrom());
        	param.setEmfrom(fromVO.getEmiuser());
        	insertMailOne(param);

    		SendMail sm = new SendMail(fromVO.getEmismtp(), fromVO.getEmismtpport(), fromVO.getEmiuser(), fromVO.getUsernm(), fromVO.getEmipw());
   			sm.send(true, to, cc, bcc, param.getEmsubject(), param.getEmcontents());//
        	
	        txManager.commit(status);
	    } catch (TransactionException | MessagingException ex) {
	        txManager.rollback(status);
	        LOGGER.error("insertMail");
	    }           	
    }
    
    public void insertMailOne(MailVO mail) {
		MailAddressVO mavo = new MailAddressVO();
        sqlSession.insert("insertMail", mail);
        
		mavo.setEmno(mail.getEmno());
		mavo.setEatype("t");	// to
        insertMailAddress(mail.getEmto(), mavo);
		mavo.setEatype("c");	// cc
        insertMailAddress(mail.getEmcc(), mavo);
		mavo.setEatype("b");	// bcc
        insertMailAddress(mail.getEmbcc(), mavo);

        ArrayList<FileVO> files = mail.getFiles();
    	for (int j=0; j<files.size(); j++) {
    		FileVO fvo = files.get(j);
    		fvo.setParentPK(mail.getEmno());
        	sqlSession.insert("insertMailFile", fvo);
    	}
    }
    
    public void insertMailAddress(ArrayList<String> list, MailAddressVO mavo) {
    	for (int j=0; j<list.size(); j++) {
    		String str = list.get(j);
    		if ("".equals(str) || str == null) continue;
    		mavo.setEaseq(j);
    		mavo.setEaaddress(list.get(j));
        	sqlSession.insert("insertMailAddress", mavo);
    	}
    }

    public String selectLastMail(String param) {
        return sqlSession.selectOne("selectLastMail", param);
    }
    
    
    /** ==============================================================
     * 메일 정보 리스트.
     */
    public Integer selectMailInfoCount(SearchVO param) {
        return sqlSession.selectOne("selectMailInfoCount", param);
    }
    
    public List<?> selectMailInfoList(String param) {
        return sqlSession.selectList("selectMailInfoList", param);
    }
    
    /**
     * 메일 정보 저장.
     */
    public void insertMailInfo(MailInfoVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getEmino()==null || "".equals(param.getEmino())) {
                sqlSession.insert("insertMailInfo", param);
            } else {
                sqlSession.update("updateMailInfo", param);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertMailInfo");
        }            
    }

    /**
     * 읽기.
     */
    public MailInfoVO selectMailInfoOne(MailInfoVO param) {
        return sqlSession.selectOne("selectMailInfoOne", param);
    }

    /**
     * 메일 정보  삭제.
     */
    public void deleteMailInfo(MailInfoVO param) {
        sqlSession.update("deleteMailInfo", param);
    }
    
}

package gu.sign;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.admin.sign.SignDocSvc;
import gu.admin.sign.SignDocTypeVO;
import gu.common.SearchVO;
import gu.etc.EtcSvc;

@Controller 
public class SignCtr {

    @Autowired
    private SignSvc signSvc;

    @Autowired
    private SignDocSvc signDocSvc;
    
    @Autowired
    private EtcSvc etcSvc; 
    
    static final Logger LOGGER = LoggerFactory.getLogger(SignCtr.class);
    
    /**
     * 결제 할 문서 리스트.
     */
    @RequestMapping(value = "/signListTobe")
    public String signListTobe(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 
        searchVO.setUserno(userno);
        searchVO.pageCalculate( signSvc.selectSignDocCount(searchVO) ); // startRow, endRow
        List<?> listview  = signSvc.selectSignDocList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "sign/SignList";
    }

    /**
     * 결제 할 문서 리스트.
     */
    @RequestMapping(value = "/signListTo")
    public String signListTo(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 
        searchVO.setUserno(userno);
        searchVO.pageCalculate( signSvc.selectSignDocCount(searchVO) ); // startRow, endRow
        List<?> listview  = signSvc.selectSignDocList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "sign/SignList";
    }
    
    /** 
     * 기안하기. 
     */
    @RequestMapping(value = "/signDocTypeList")
    public String signDocTypeList(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        List<?> listview  = signDocSvc.selectSignDocTypeList(searchVO);
        
        modelMap.addAttribute("listview", listview);
        
        return "sign/SignDocTypeList";
    }
    
    @RequestMapping(value = "/signForm")
    public String signForm(HttpServletRequest request, SignDocVO signInfo, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 개별 작업
        if (signInfo.getDocno() != null) {
            signInfo = signSvc.selectSignDocOne(signInfo);
        } else {
        	SignDocTypeVO docType = signDocSvc.selectSignDocTypeOne(signInfo.getDtno());
        	signInfo.setDtno(docType.getDtno());
        	signInfo.setDoccontents(docType.getDtcontents());
        }
        modelMap.addAttribute("signInfo", signInfo);
        
        return "sign/SignForm";
    }
    
    /**
     * 저장.
     */
    @RequestMapping(value = "/signSave")
    public String signSave(HttpServletRequest request, SignDocVO signInfo, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
    	signInfo.setUserno(userno);
    	
        signSvc.insertSignDoc(signInfo);

        return "redirect:/signListTobe";
    }

    /**
     * 읽기.
     */
    @RequestMapping(value = "/signRead")
    public String signRead(HttpServletRequest request, SignDocVO SignDocVO, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 개별 작업
        
        SignDocVO signInfo = signSvc.selectSignDocOne(SignDocVO);

        modelMap.addAttribute("signInfo", signInfo);
        
        return "sign/SignRead";
    }
    
    /**
     * 삭제.
     */
    @RequestMapping(value = "/signDelete")
    public String signDelete(HttpServletRequest request, SignDocVO SignDocVO) {

        signSvc.deleteSignDoc(SignDocVO);
        
        return "redirect:/signList";
    }
   
}

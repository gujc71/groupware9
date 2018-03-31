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
     * 결제 받을 문서 리스트.
     */
    @RequestMapping(value = "/signListTobe")
    public String signListTobe(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 
        searchVO.setUserno(userno);
        searchVO.pageCalculate( signSvc.selectSignDocTobeCount(searchVO) ); // startRow, endRow
        List<?> listview  = signSvc.selectSignDocTobeList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "sign/SignDocListTobe";
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
        if (searchVO.getSearchExt1()==null || "".equals(searchVO.getSearchExt1())) searchVO.setSearchExt1("sign");
        searchVO.setUserno(userno);
        searchVO.pageCalculate( signSvc.selectSignDocCount(searchVO) ); // startRow, endRow
        List<?> listview  = signSvc.selectSignDocList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "sign/SignDocList";
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
    
    @RequestMapping(value = "/signDocForm")
    public String signDocForm(HttpServletRequest request, SignDocVO signDocInfo, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 개별 작업
        List<?> signlist = null;
        if (signDocInfo.getDocno() == null) {	// 신규
        	signDocInfo.setDocstatus("1");
        	SignDocTypeVO docType = signDocSvc.selectSignDocTypeOne(signDocInfo.getDtno());
        	signDocInfo.setDtno(docType.getDtno());
        	signDocInfo.setDoccontents(docType.getDtcontents());
        	signDocInfo.setUserno(userno);
        	// 사번, 이름, 기안/합의/결제, 직책
            signlist = signSvc.selectSignLast(signDocInfo);
            String signPath = "";
            for (int i=0; i<signlist.size();i++){
            	SignVO svo = (SignVO) signlist.get(i);
            	signPath += svo.getUserno() + "," + svo.getUsernm() + "," + svo.getSstype() + "," + svo.getUserpos() + "||";  
            }
            signDocInfo.setDocsignpath(signPath);
        } else {								// 수정
            signDocInfo = signSvc.selectSignDocOne(signDocInfo);
            signlist = signSvc.selectSign(signDocInfo.getDocno());
        }
        modelMap.addAttribute("signDocInfo", signDocInfo);
        modelMap.addAttribute("signlist", signlist);
        
        return "sign/SignDocForm";
    }
    
    /**
     * 저장.
     */
    @RequestMapping(value = "/signDocSave")
    public String signDocSave(HttpServletRequest request, SignDocVO signDocInfo, ModelMap modelMap) {
        String userno = request.getSession().getAttribute("userno").toString();
    	signDocInfo.setUserno(userno);
    	
        signSvc.insertSignDoc(signDocInfo);

        return "redirect:/signListTobe";
    }

    /**
     * 읽기.
     */
    @RequestMapping(value = "/signDocRead")
    public String signDocRead(HttpServletRequest request, SignDocVO SignDocVO, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 개별 작업
        
        SignDocVO signDocInfo = signSvc.selectSignDocOne(SignDocVO);
        List<? >signlist = signSvc.selectSign(signDocInfo.getDocno());
        String signer = signSvc.selectCurrentSigner(SignDocVO.getDocno());
        
        modelMap.addAttribute("signDocInfo", signDocInfo);
        modelMap.addAttribute("signlist", signlist);
        modelMap.addAttribute("signer", signer);
        
        return "sign/SignDocRead";
    }
    
    /**
     * 삭제.
     */
    @RequestMapping(value = "/signDocDelete")
    public String signDocDelete(HttpServletRequest request, SignDocVO SignDocVO) {

        signSvc.deleteSignDoc(SignDocVO);
        
        return "redirect:/signList";
    }

    /**
     * 결재.
     */
    @RequestMapping(value = "/signSave")
    public String signSave(HttpServletRequest request, SignVO signInfo) {

        signSvc.updateSign(signInfo);
        
        return "redirect:/signListTo";
    }
    /**
     * 회수.
     */
    @RequestMapping(value = "/signDocCancel")
    public String signDocCancel(HttpServletRequest request, String docno) {
        signSvc.updateSignDocCancel(docno);
        
        return "redirect:/signListTobe";
    }
}

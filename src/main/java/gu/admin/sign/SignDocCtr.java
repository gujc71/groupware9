package gu.admin.sign;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import gu.common.SearchVO;
import gu.etc.EtcSvc;

@Controller 
public class SignDocCtr {

    @Autowired
    private SignDocSvc signDocSvc;
    
    @Autowired
    private EtcSvc etcSvc; 
    
    static final Logger LOGGER = LoggerFactory.getLogger(SignDocCtr.class);
    
    /**
     * 리스트.
     */
    @RequestMapping(value = "/adSignDocTypeList")
    public String signDocTypeList(HttpServletRequest request, SearchVO searchVO, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        searchVO.pageCalculate( signDocSvc.selectSignDocTypeCount(searchVO) ); // startRow, endRow
        List<?> listview  = signDocSvc.selectSignDocTypeList(searchVO);
        
        modelMap.addAttribute("searchVO", searchVO);
        modelMap.addAttribute("listview", listview);
        
        return "admin/sign/SignDocTypeList";
    }
    
    /** 
     * 쓰기. 
     */
    @RequestMapping(value = "/adSignDocTypeForm")
    public String signDocTypeForm(HttpServletRequest request, SignDocTypeVO signInfo, ModelMap modelMap) {
        // 페이지 공통: alert
        String userno = request.getSession().getAttribute("userno").toString();
        
        etcSvc.setCommonAttribute(userno, modelMap);
    	
        // 개별 작업
        if (signInfo.getDtno() != null) {
            signInfo = signDocSvc.selectSignDocTypeOne(signInfo.getDtno());
        
            modelMap.addAttribute("signInfo", signInfo);
        }
        
        return "admin/sign/SignDocTypeForm";
    }
    
    /**
     * 저장.
     */
    @RequestMapping(value = "/adSignDocTypeSave")
    public String signDocTypeSave(HttpServletRequest request, SignDocTypeVO signInfo, ModelMap modelMap) {
    	
        signDocSvc.insertSignDocType(signInfo);

        return "redirect:/adSignDocTypeList";
    }

    /**
     * 삭제.
     */
    @RequestMapping(value = "/adSignDocTypeDelete")
    public String signDocTypeDelete(HttpServletRequest request, SignDocTypeVO signVO) {

        signDocSvc.deleteSignDocType(signVO);
        
        return "redirect:/adSignDocTypeList";
    }
   
}

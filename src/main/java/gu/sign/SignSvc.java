package gu.sign;

import java.util.List;

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

import gu.common.SearchVO;

@Service
public class SignSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;

    static final Logger LOGGER = LoggerFactory.getLogger(SignSvc.class);
    
    /**
     * 결제 받을 문서 리스트.
     */
    public Integer selectSignDocTobeCount(SearchVO param) {
        return sqlSession.selectOne("selectSignDocTobeCount", param);
    }
    
    public List<?> selectSignDocTobeList(SearchVO param) {
        return sqlSession.selectList("selectSignDocTobeList", param);
    }
    /**
     * 결제 할 문서 리스트.
     */
    public Integer selectSignDocCount(SearchVO param) {
        return sqlSession.selectOne("selectSignDocCount", param);
    }
    
    public List<?> selectSignDocList(SearchVO param) {
        return sqlSession.selectList("selectSignDocList", param);
    }
    /**
     * 저장.
     */
    public void insertSignDoc(SignDocVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getDocno()==null || "".equals(param.getDocno())) {
                sqlSession.insert("insertSignDoc", param);
            } else {
                sqlSession.update("updateSignDoc", param);
            }
            
            sqlSession.delete("deleteSign", param.getDocno());
        	String docsignpath = param.getDocsignpath();
        	String[] users = docsignpath.split("\\|\\|");
        	for (int i=0; i<users.length; i++) { 
        		if ("".equals(users[i])) continue;
        		String[] arr = users[i].split(","); // 사번, 이름, 기안/합의/결제, 직책
        		SignVO param2 = new SignVO();
        		param2.setSsstep(Integer.toString(i));
        		param2.setDocno(param.getDocno());
        		param2.setUserno(arr[0]);
        		param2.setSstype(arr[2]);
        		param2.setUserpos(arr[3]);
        		if ("0".equals(arr[2])) {
        			param2.setSsresult("1");
        		} else {
        			param2.setSsresult("0");
        		}
        		
                sqlSession.insert("insertSign", param2);
        	}
        	
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertSignDoc");
        }            
    }

    /**
     * 읽기.
     */
    public SignDocVO selectSignDocOne(SignDocVO param) {
        return sqlSession.selectOne("selectSignDocOne", param);
    }
    
    public String selectCurrentSigner(String param) {
        return sqlSession.selectOne("selectCurrentSigner", param);
    }
    
    /**
     * 결재 경로.
     */
    public List<?> selectSign(String param) {
        return sqlSession.selectList("selectSign", param);
    }
    /**
     * 마지막 결재 경로.
     */
    public List<?> selectSignLast(SignDocVO param) {
        return sqlSession.selectList("selectSignLast", param);
    }
    
    /**
     * 삭제.
     */
    public void deleteSignDoc(SignDocVO param) {
        sqlSession.delete("deleteSignDoc", param);
    }

    /**
     * 결재.
     */
    public void updateSign(SignVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
	        sqlSession.update("updateSign", param);
	        
	        // signdoc의 상태 변경: docstatus 변수를 사용해야 하나 그냥 ssresult로 사용
	        if ("2".equals(param.getSsresult())){	// 반려 - 결재 종료
        		param.setSsresult("3");
	        } else {
	        	String chk = sqlSession.selectOne("selectChkRemainSign", param);
	        	if (chk!=null) { // 다음 심사가 있으면 심사 단계 설정
	        		param.setSsstep("1");
	        		param.setSsresult("2");
	        	} else {
	        		param.setSsresult("4");
	        	}
	        }
        	sqlSession.update("updateSignDocStatus", param);
        	
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("updateSign");
        }            
    }
    
    public void updateSignDocCancel(String param) {
        sqlSession.update("updateSignDocCancel", param);
    }
}

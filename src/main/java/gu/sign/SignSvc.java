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
     * 리스트.
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
        		param2.setUserpos(arr[3]);
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

    /**
     * 삭제.
     */
    public void deleteSignDoc(SignDocVO param) {
        sqlSession.update("deleteSignDoc", param);
    }

}

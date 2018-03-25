package gu.admin.sign;

import java.util.HashMap;
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
public class SignDocSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;

    static final Logger LOGGER = LoggerFactory.getLogger(SignDocSvc.class);
    
    /**
     * 리스트.
     */
    public Integer selectSignDocTypeCount(SearchVO param) {
        return sqlSession.selectOne("selectSignDocTypeCount", param);
    }
    
    public List<?> selectSignDocTypeList(SearchVO param) {
        return sqlSession.selectList("selectSignDocTypeList", param);
    }
    
    /**
     * 저장.
     */
    public void insertSignDocType(SignDocTypeVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getDtno()==null || "".equals(param.getDtno())) {
                sqlSession.insert("insertSignDocType", param);
            } else {
                sqlSession.update("updateSignDocType", param);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertSignDocType");
        }            
    }

    /**
     * 읽기.
     */
    public SignDocTypeVO selectSignDocTypeOne(String param) {
        return sqlSession.selectOne("selectSignDocTypeOne", param);
    }

    /**
     * 삭제.
     */
    public void deleteSignDocType(SignDocTypeVO param) {
        sqlSession.update("deleteSignDocType", param);
    }

}

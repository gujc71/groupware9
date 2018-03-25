package gu.sign;

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
public class SignSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;

    static final Logger LOGGER = LoggerFactory.getLogger(SignSvc.class);
    
    /**
     * 리스트.
     */
    public Integer selectSignCount(SearchVO param) {
        return sqlSession.selectOne("selectSignCount", param);
    }
    
    public List<?> selectSignList(SearchVO param) {
        return sqlSession.selectList("selectSignList", param);
    }
    
    /**
     * 저장.
     */
    public void insertSign(SignVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getDocno()==null || "".equals(param.getDocno())) {
                sqlSession.insert("insertSign", param);
            } else {
                sqlSession.update("updateSign", param);
            }
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertSign");
        }            
    }

    /**
     * 읽기.
     */
    public SignVO selectSignOne(SignVO param) {
        return sqlSession.selectOne("selectSignOne", param);
    }

    /**
     * 삭제.
     */
    public void deleteSign(SignVO param) {
        sqlSession.update("deleteSign", param);
    }

}

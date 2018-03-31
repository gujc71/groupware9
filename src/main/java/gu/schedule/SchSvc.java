package gu.schedule;

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

import gu.common.Field3VO;
import gu.common.SearchVO;

@Service
public class SchSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
    @Autowired
    private DataSourceTransactionManager txManager;

    static final Logger LOGGER = LoggerFactory.getLogger(SchSvc.class);
    
    public List<?> selectCalendar(MonthVO param) {
    	List<?> list = sqlSession.selectList("selectCalendar", param);
        
    	for (int i=0; i<list.size(); i++){
    		CalendarVO cvo = (CalendarVO) list.get(i);
    		cvo.setList( sqlSession.selectList("selectSchList4Calen", cvo.getCddate()) );
    	}
        return list;
    }
     
    /** 
     * 리스트.
     */
    public Integer selectSchCount(SearchVO param) {
        return sqlSession.selectOne("selectSchCount", param);
    }
    
    public List<?> selectSchList(SearchVO param) {
        return sqlSession.selectList("selectSchList", param);
    }
    
    /**
     * 저장.
     */
    public void insertSch(SchVO param) {
        DefaultTransactionDefinition def = new DefaultTransactionDefinition();
        def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
        TransactionStatus status = txManager.getTransaction(def);
        
        try {
            if (param.getSsno()==null || "".equals(param.getSsno())) {
                sqlSession.insert("insertSch", param);
            } else {
                sqlSession.update("updateSch", param);
            }
            
            sqlSession.insert("deleteSchDetail", param.getSsno());

            SchDetailVO param2 = new SchDetailVO();
            param2.setSsno(param.getSsno());
            param2.setSdseq(1);
            param2.setSddate(param.getSsstartdate());
            param2.setSdhour(param.getSsstarthour());
            param2.setSdminute(param.getSsstartminute());
            
            
            sqlSession.insert("insertSchDetail", param2);
            
            txManager.commit(status);
        } catch (TransactionException ex) {
            txManager.rollback(status);
            LOGGER.error("insertSch");
        }            
    }

    /**
     * 읽기.
     */
    public SchVO selectSchOne(SchVO param) {
        return sqlSession.selectOne("selectSchOne", param);
    }

    /**
     * 삭제.
     */
    public void deleteSch(SchVO param) {
        sqlSession.update("deleteSch", param);
    }

    /**
     * 저장.
     */
    public void deleteChk(String[] param) {
    	HashMap hm = new HashMap();
    	hm.put("list", param) ;

    	sqlSession.insert("deleteChk", hm);
    }
}

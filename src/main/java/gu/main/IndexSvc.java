package gu.main;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import gu.common.Field3VO;

@Service
public class IndexSvc {

    @Autowired
    private SqlSessionTemplate sqlSession;    
        

    public List<?> selectRecentNews() {
        return sqlSession.selectList("selectRecentNews");
    }
    
    public List<?> selectTimeLine() {
        return sqlSession.selectList("selectTimeLine");
    }
    
    public List<?> selectNoticeListTop5() {
        return sqlSession.selectList("selectNoticeListTop5");
    }
    
    public List<?> selectSchList4Calen(Field3VO param) {
        return sqlSession.selectList("selectSchList4Calen", param);
    }
    
}

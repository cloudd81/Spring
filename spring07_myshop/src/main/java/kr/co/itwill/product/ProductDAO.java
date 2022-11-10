package kr.co.itwill.product;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository // 스프링 컨테이너에서 자동으로 객체화를 시켜줌
public class ProductDAO {

	public ProductDAO() {
		System.out.println("------ProductDAO() 객체 생성됨");
	} // end
	
	// 스프링 빈으로 생성된 객체를 가져와서 연결하기
	@Autowired
	SqlSession sqlSession;
	// Spring07MyshopApplication.java에서 설정한 @Bean을 연결.
	// 오류시 setSqlSession(), getSqlSession() 에러가 뜸.
	// 우리는 이 sqlSession을 사용하여 MyBatis Framework로 DB 작업을 한다.
	
	public List<Map<String, Object>> list() {
		return sqlSession.selectList("product.list");
	} // list() end
	
	public void insert(Map<String, Object> map) {
		sqlSession.insert("product.insert", map);
	} // insert() end
	
} // class end

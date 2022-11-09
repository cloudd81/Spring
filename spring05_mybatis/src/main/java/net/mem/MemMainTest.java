package net.mem;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MemMainTest {

	public static void main(String[] args) {
		// MyBatis Framework  기반 JDBC 연습
		
		try {
			//factory 공장
			// -> 어떤 특정 정보를 주면 객체로 생성해줌
			// -> 객체 생성 : new연산자(POJO방식), Bean
			
			// 1)  DB연결 환경설정 파일 가져오기
			String resource = "config/jdbc.xml";
			InputStream is = Resources.getResourceAsStream(resource);
			
			// 2) DB에 연결하기 위한 팩토리빈(factory bean) 생성
			//		DBOpen + DAO
			SqlSessionFactory ssf = new SqlSessionFactoryBuilder().build(is);
			System.out.println("--------- DB 연결 성공");
			
			// 3) 쿼리문 생성 및 변환
			//	-> PreparedStatement와 비슷한 기능
			SqlSession sql = ssf.openSession(true);
			////////////////////////////////////////////////////////
			
			// 4) 쿼리문 실행
			//	① 행 추가
			/*
			 * int result = sql.insert("mem.insertRow", new MemDTO("손흥민", 31));
			 * System.out.println("행추가 결과 : " + result);
			 */
			
			// ③ 행 수정
			//	-> num이 3인 행의 이름과 나이 수정하기
			/*
			 * int result = sql.update("mem.updateRow", new MemDTO(4, "구로구", 10));
			 * System.out.println("행 수정 결과 : " + result);
			 */
			
			// ④ 행 삭제
			//	-> 나이가 30 초과인 행 삭제
			/*
			 * int result = sql.delete("mem.deleteRow", 30);
			 * System.out.println("행 삭제 결과 : " + result);
			 */
			
			// ② 전체 행 조회
//			List<MemDTO> list = sql.selectList("mem.selectALL");
//			for(int i=0; i<list.size(); i++) {
//				MemDTO dto = list.get(i);
//				System.out.print(dto.getNum() + " ");
//				System.out.print(dto.getName() + " ");
//				System.out.print(dto.getAge() + " ");
//				System.out.println();
//			} // for end
			
			// ⑤ 검색
			// -> 이름에 '로' 글자가 있는 행 조회
//			List<MemDTO> list = sql.selectList("mem.search", "로");
//			for(int i=0; i<list.size(); i++) {
//				MemDTO dto = list.get(i);
//				System.out.print(dto.getNum() + " ");
//				System.out.print(dto.getName() + " ");
//				System.out.print(dto.getAge() + " ");
//				System.out.println();
//			} // for end
			
			 //  ⑥ 검색
            //  -> num=12 행 상세보기
            MemDTO dto=sql.selectOne("mem.selectRead", 4);
            System.out.print(dto.getNum() + " ");
            System.out.print(dto.getName() + " ");
            System.out.print(dto.getAge() + " ");
            System.out.println();
            
            //  ⑦전체 행 갯수
            System.out.println("전체 행 갯수 : " + sql.selectOne("mem.rowCount"));
			
		} catch (Exception e) {
			System.out.println("실패 : " + e);
		} // 둥
		
		
	} // main() end
} // class end

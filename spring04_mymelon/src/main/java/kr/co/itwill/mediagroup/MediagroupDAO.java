package kr.co.itwill.mediagroup;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.stereotype.Service;

// @Service
@Repository
public class MediagroupDAO {

	@Autowired
	private JdbcTemplate jt;
	
	StringBuilder sql = null;
	
	public MediagroupDAO() {
		System.out.println("-----------MediagroupDAO() 객체 생성됨");
	} // end
	
	// 비지니스 로직 구현
	public int create(MediagroupDTO dto) {
		int cnt = 0;
		
		try {
			sql = new StringBuilder();
			sql.append(" INSERT INTO mediagroup(mediagroupno, title) ");
			sql.append(" VALUES (mediagroup_seq.nextval, ?) ");
			cnt = jt.update(sql.toString(), dto.getTitle());
			
		} catch (Exception e) {
			System.out.println("미디어그룹 등록 실패 : " + e);
		} // end
		
		return cnt;
	} // create() end
	
	public int totalRowCount() {
		int cnt = 0;
		try {
			sql = new StringBuilder();
			sql.append(" SELECT COUNT(*) FROM mediagroup ");
			cnt = jt.queryForObject(sql.toString(), Integer.class);
		} catch (Exception e) {
			System.out.println("전체 행 개수 조회 실패 : " + e);
		} 
		return cnt;
	} // totalRowCount() end
	
	public List<MediagroupDTO> list() {
		List<MediagroupDTO> list = null;
		try {
			sql = new StringBuilder();
			sql.append(" SELECT mediagroupno, title ");
			sql.append(" FROM mediagroup ");
			sql.append(" ORDER BY mediagroupno DESC ");
			
			RowMapper<MediagroupDTO> rowMapper = new RowMapper<MediagroupDTO>() {
				@Override
				public MediagroupDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
					MediagroupDTO dto = new MediagroupDTO();
					dto.setMediagroupno(rs.getInt("mediagroupno"));
					dto.setTitle(rs.getString("title"));
					return dto;
				} // mapRow() end
			}; // end
			
			list = jt.query(sql.toString(), rowMapper);
			
		} catch (Exception e) {
			System.out.println("목록 불러오기 실패 : " + e);
		}
		
		return list;
	} // list() end

	public List<MediagroupDTO> list2(int start, int end) { // 페이징
		List<MediagroupDTO> list = null;
		try {
			sql = new StringBuilder();
			sql.append(" SELECT AA.* ");
			sql.append(" FROM ( ");
			sql.append(" 	SELECT ROWNUM as RNUM, BB.* ");
			sql.append(" 	FROM ( ");
			sql.append(" 		SELECT mediagroupno, title ");
			sql.append(" 		FROM mediagroup ");
			sql.append(" 		ORDER BY mediagroupno DESC ");
			sql.append(" 	) BB ");
			sql.append(" ) AA ");
			sql.append(" WHERE AA.RNUM >=" + start + " AND AA.RNUM <= " + end );
			
			RowMapper<MediagroupDTO> rowMapper = new RowMapper<MediagroupDTO>() {
				@Override
				public MediagroupDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
					MediagroupDTO dto = new MediagroupDTO();
					dto.setMediagroupno(rs.getInt("mediagroupno"));
					dto.setTitle(rs.getString("title"));
					return dto;
				} // mapRow() end
			}; // end
			
			list = jt.query(sql.toString(), rowMapper);
			
		} catch (Exception e) {
			System.out.println("목록 불러오기 실패 : " + e);
		}
		
		return list;
	} // list2() end
	
} // class end

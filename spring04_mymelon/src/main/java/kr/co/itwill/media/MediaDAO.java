package kr.co.itwill.media;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import kr.co.itwill.mediagroup.MediagroupDTO;

@Repository
public class MediaDAO {
	
	@Autowired
	private JdbcTemplate jt;
	private StringBuilder sql = null;
	private ResultSet rs = null;
	
	public MediaDAO () {
		System.out.println("--------MediaDAO() 객체 생성됨");
	} // end
	
	public List<MediaDTO> list(int mediagroupno) {
		List<MediaDTO> list = null;
		try {
			sql = new StringBuilder();
			sql.append(" SELECT mediano, title, poster, filename, filesize, mview, rdate, mediagroupno ");
			sql.append(" FROM media ");
			sql.append(" WHERE mview = 'Y' AND mediagroupno = " + mediagroupno);
			sql.append(" ORDER BY mediano DESC ");
			
			RowMapper<MediaDTO> rowMapper = new RowMapper<MediaDTO>() {
				@Override
				public MediaDTO mapRow(ResultSet rs, int rowNum) throws SQLException {
					MediaDTO dto = new MediaDTO();
					dto.setMediano(rs.getInt("mediano"));
					dto.setTitle(rs.getString("title"));
					dto.setRdate(rs.getString("rdate"));
					dto.setPoster(rs.getString("poster"));
					dto.setFilename(rs.getString("filename"));
					dto.setFilesize(rs.getLong("filesize"));
					dto.setMview(rs.getString("mview"));
					dto.setMediagroupno(rs.getInt("mediagroupno"));
					return dto;
				} // mapRow() end
			}; // rowMapper end
			
			list = jt.query(sql.toString(), rowMapper);
			
		} catch (Exception e) {
			System.out.println("목록 불러오기 실패 : " + e);
		}
		return list;
	} // list() end
	
	public int create(MediaDTO dto) {
		int cnt = 0;
		
		try {
			sql = new StringBuilder();
			sql.append(" INSERT INTO media(mediano, title, poster, filename, filesize, mediagroupno, rdate) ");
			sql.append(" VALUES (media_seq.nextval, ?, ?, ?, ?, ?, sysdate) ");
			cnt = jt.update(sql.toString(), dto.getTitle(), dto.getPoster(), dto.getFilename(), dto.getFilesize(), dto.getMediagroupno());
			
		} catch (Exception e) {
			System.out.println("미디어그룹 등록 실패 : " + e);
		} // end
		
		return cnt;
	} // create() end
	
} // class end

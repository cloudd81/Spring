package kr.co.itwill.media;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data // lombok으로 기본생성자, getter, setter, toString() 만들기
public class MediaDTO {
	private int mediano;
	private	String title;
	private String poster;
	private String filename;
	private long filesize;
	private String mview;
	private String rdate;
	private int mediagroupno;
	
	// <input type="file" name='posterMF' size='50'>
	private MultipartFile posterMF;
	// <input type="file" name='filenameMF' size='50'>
	private MultipartFile filenameMF;
} // class end

package kr.co.itwill.media;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import net.utility.UploadSaveManager;

@Controller
public class MediaCont {
	
	@Autowired
	private MediaDAO dao;
	
	public MediaCont() {
		System.out.println("---------MediaCont() 객체 생성됨");
	} // end

	@RequestMapping("/media/list.do")
	public ModelAndView list(int mediagroupno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("media/list");
		mav.addObject("list", dao.list(mediagroupno));
		mav.addObject("mediagroupno", mediagroupno); // 부모 글 번호
		return mav;
	} // list() end
	
	@RequestMapping(value = "/media/create.do", method = RequestMethod.GET)
	public ModelAndView createForm(int mediagroupno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("media/createForm");
		mav.addObject("mediagroupno", mediagroupno); // 부모 글 번호
		return mav;
	} // createForm() end
	
	@RequestMapping(value = "create.do", method = RequestMethod.POST)
	public ModelAndView createProc(MediaDTO dto, HttpServletRequest req) {
								// (String title, MultipartFile posterMF, MultipartFile filenameMF)
		ModelAndView mav = new ModelAndView();
		mav.setViewName("media/msgView");
		
		////////////////////////////////////////////////////////////////
		// 첨부된 파일 처리
		// -> 실제 파일은 /storage 폴더에 저장
		// -> 저장된 파일과 관련된 정보는 media 테이블에 저장
		
		// 파일 저장 폴더의 실제 물리적인 경로 가져오기
		String basePath = req.getRealPath("/storage");
				
		// 1) 사진파일 저장 : <input type="file" name='posterMF' size='50'>
		MultipartFile posterMF = dto.getPosterMF(); // 파일 가져오기
		
		// /storage 폴더에 파일을 저장하고 리네임된 파일명 반환하기
		String poster = UploadSaveManager.saveFileSpring30(posterMF, basePath);
		dto.setPoster(poster);
		
		// 2) 미디어파일 저장 : <input type="file" name='filenameMF' size='50'>
		MultipartFile filenameMF = dto.getFilenameMF(); // 파일 가져오기
		
		// /storage 폴더에 파일을 저장하고 리네임된 파일명과 파일크기 반환하기
		String filename = UploadSaveManager.saveFileSpring30(filenameMF, basePath);
		dto.setFilename(filename);
		dto.setFilesize(filenameMF.getSize());
		////////////////////////////////////////////////////////////////
		
		int cnt = dao.create(dto);
		if(cnt==0) {
			String msg1 = "<p>음원 등록 실패</p>";
			String img = "<img src='../images/fail.png' style='width: 50%;'>";
			String link1 = "<input type='button' value='다시시도' onclick='javascript:history.back()'>";
			String link2 = "<input type='button' value='목록으로' onclick='javascript:location.href=\"list.do?mediagroupno=" + dto.getMediagroupno() + "\"'>";
			mav.addObject("msg1", msg1);
			mav.addObject("img", img);
			mav.addObject("link1", link1);
			mav.addObject("link2", link2);
		} else {
			String msg1 = "<p>음원 등록 성공</p>";
			String img = "<img src='../images/kiss.png' style='width: 20%;'>";
			String link1 = "<input type='button' value='그룹으로' onclick='javascript:location.href=\"list.do?mediagroupno=" + dto.getMediagroupno() + "\"'>";
			mav.addObject("msg1", msg1);
			mav.addObject("img", img);
			mav.addObject("link1", link1);
		} // if end
		
		return mav;
	} // createForm() end
	
	
} // class end

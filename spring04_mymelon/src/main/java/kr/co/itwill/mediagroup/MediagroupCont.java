package kr.co.itwill.mediagroup;

import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import net.utility.Utility;

@Controller
public class MediagroupCont {

	@Autowired
	private MediagroupDAO dao; // DBOpen dbopen = new DBOpen() 과 같은 형태
	
	public MediagroupCont() {
		System.out.println("--------MediagroupCont() 객체 생성됨");
	} // MediagroupCont() end
	
	// 미디어그룹 쓰기 페이지 호출
	// http://localhost:9095/mediagroup/create.do
	@RequestMapping(value = "mediagroup/create.do", method = RequestMethod.GET)
	public String createForm() {
		return "mediagroup/createForm";
	} // createForm() end
	
	@RequestMapping(value = "mediagroup/create.do", method = RequestMethod.POST)
	public ModelAndView createProc(@ModelAttribute MediagroupDTO dto) {
		ModelAndView mav = new ModelAndView();
		
		int cnt = dao.create(dto);
		if(cnt==0) {
			mav.setViewName("mediagroup/msgView");
			String msg = "<p>미디어 그룹 등록 실패</p>";
			String img = "<img src='../images/fail.png' style='width: 50%;'>";
			String link1 = "<input type='button' value='다시시도' onclick='javascript:history.back()'>";
			String link2 = "<input type='button' value='그룹목록' onclick='javascript:location.href=\"list.do\"'>";
			mav.addObject("msg1", msg);
			mav.addObject("img", img);
			mav.addObject("link1", link1);
			mav.addObject("link2", link2);
		} else {
			mav.setViewName("redirect:/mediagroup/list.do");
		} // if end
		return mav;
	} // createProc() end
	
//	1) 페이징 없는 목록	
//	@RequestMapping("mediagroup/list.do")
//	public ModelAndView list() {
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("mediagroup/list");
//		
//		int totalRowCount = dao.totalRowCount();
//		List<MediagroupDTO> list = dao.list();
//		
//		mav.addObject("list", list);
//		mav.addObject("count", totalRowCount);
//		return mav;
//	} // list() end
	
//	2) 페이징 있는 목록
	@RequestMapping("mediagroup/list.do") // list.do 명령어는 mediagroup/list.jsp 페이지를 불러옴(73행)
	public ModelAndView list(HttpServletRequest req) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mediagroup/list");
		
		int totalRowCount = dao.totalRowCount(); // 총 글개수
		
		// 1. 페이징
		int numPerPage = 5; // 한 페이지당 레코드 개수를 계산하기 위한 변수
		int pagePerBlock = 10; // 페이지 리스트를 출력하기 위한 변수
		
		String pageNum = req.getParameter("pageNum"); // 현재 페이지의 번호를 String 값으로 저장(페이징 번호를 구현하기 위해서 문자열로 저장)
		if(pageNum==null) {
			pageNum="1"; // 받아온 페이지 번호가 없다면(목록에 처음 들어왔다면) 1페이지 저장
		} // if end
		
		int currentPage = Integer.parseInt(pageNum); // 현재 페이지의 번호가 담긴 문자열을 정수형으로 변환
		// 페이지에 담길 글의 수를 조정함
		// 예) 내가 지금 1페이지라면 글번호가 1번부터 5번까지인 게시글을 가져와야함		2페이지의 경우 6~10까지
		//		startRow	= ((1-0)*5)+1	= 1											= ((2-1)*5)+1	= 6
		//		endRow		= 1*5			= 5											= 2*5			= 10
		//	startRow 변수와 endRow변수를 활용하여 SQL문에서 rownum으로 접근
		int startRow	= (currentPage-1)*numPerPage+1; // 시작 행번호
		int endRow		= currentPage*numPerPage;		// 끝 행번호
		
		// 2. 페이지 목록
		// 총 글 개수에 맞춰서 페이징으로 페이지를 어디까지 띄울 지 조정한다.(pagePerBlock 변수 활용)
		//
		// 1)
		// 우선 총 글개수를 미리 정해둔 페이지당 출력되는 레코드 수로 나누어준다.
		//	- 내 글은 총 6개이다. 한 페이지에는 5개의 글만 들어갈 수 있다. 내 글은 어디까지 들어갈까? 2페이지 일 것이다.
		//	- 내 글 개수 / 한 페이지에 들어갈 수 있는 글 개수 -> 6/5 = 1.2 -> 올림을 통해 2페이지까지 담아짐을 변수화
		//	- 만약 5/6의 결과값을 정수형으로 담으면 1만 출력된다. 그럼 내 글은 1페이지까지만 들어가기 때문에 double로 자료형을 선언해준다.
		double totcnt = (double)totalRowCount/numPerPage;	// 게시판의 글이 들어갈 페이지 수 계산(올림을 위해 소수점을 담음)
		int totalpage = (int)Math.ceil(totcnt);				// 소수점 올림을 통해 실제 게시판의 글들이 들어가있는 페이지 수를 변수로 담음 
		
		// 2)
		// 이번에는 총 글 개수를 미리 정해둔 페이지의 목록 수로 나누어준다.
		//	- 내 글은 총 6개이다. 페이지의 목록은 10페이지이다.
		//	- 만약 내 글이 50개가 넘어가면 
		//									내 글이 6개일 때			내 글이 12개일 때
		//	- 내 글 개수 / 페이지의 목록 수 -> 6/10 = 0.6					12/10 = 1.2
		//	- 올림을 한 후 1을 빼줌			-> 1-1 = 0						2-1 = 1
		//	- 시작 페이지를 설정해줌		-> 0*10 = 0						1*10 = 10
		//	- 페이지의 끝을 설정해줌		-> 0+10+1 = 11					10+10+1 = 21
		double d_page = (double)totalRowCount/pagePerBlock;
		int Pages	  = (int)Math.ceil(d_page)-1;
		int startPage = currentPage-1;				// 페이지의 시작 지점, 현재 페이지가 1일 때 0 | 2일 때 1 | 3일 때 2 이렇게 되어야 하지 않나?
		int endPage	  = currentPage+pagePerBlock;	// 페이지의 끝 지점, 현재 페이지가 1일 때 11 | 2일 때 12 | 3일 때 13 이렇게 되어야 하지 않나?
		
		List list = null;
		if(totalRowCount>0) {
			list = dao.list2(startRow, endRow); // 시작 행번호와 끝 행번호 저장
		} else {
			list = Collections.EMPTY_LIST; // 넘어온 값이 없다면 list를 비워주기
		} // if end
		
		int number = 0;
		number = totalRowCount-(currentPage-1)*numPerPage; // 
		
		mav.addObject("number", number);
		mav.addObject("pageNum", pageNum);
		mav.addObject("startRow", startRow);
		mav.addObject("endRow", endRow);
		mav.addObject("totalRowCount", totalRowCount);
		mav.addObject("pagePerBlock", pagePerBlock);
		mav.addObject("totalpage", totalpage);
		mav.addObject("startPage", startPage);
		mav.addObject("endPage", endPage);
		mav.addObject("list", list);
		mav.addObject("count", totalRowCount);			// 전체 글 개수
		return mav;
	} // list() end
	
	@RequestMapping(value = "mediagroup/delete.do", method = RequestMethod.GET)
	public ModelAndView deleteForm(int mediagroupno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mediagroup/deleteForm");
		mav.addObject("mediagroupno", mediagroupno);
		return mav;
	} // deleteForm() end
	
	@RequestMapping(value = "mediagroup/delete.do", method = RequestMethod.POST)
	public ModelAndView delete(int mediagroupno) {
		ModelAndView mav = new ModelAndView();
		
		int cnt = dao.delete(mediagroupno);
		if(cnt==0) {
			mav.setViewName("mediagroup/msgView");
			String img = "<img src='../images/fail.png' style='width: 50%;'>";
			String link1 = "<input type='button' value='다시시도' onclick='javascript:history.back()'>";
			String link2 = "<input type='button' value='그룹목록' onclick='javascript:location.href=\"list.do\"'>";
			mav.addObject("msg1", "<p>미디어 그룹 삭제 실패 !</p>");
			mav.addObject("img", img);
			mav.addObject("link1", link1);
			mav.addObject("link2", link2);
		} else {
			mav.setViewName("redirect:/mediagroup/list.do");
		} // if end
		return mav;
	} // delete() end
	
	@RequestMapping(value = "mediagroup/update.do", method = RequestMethod.GET)
	public ModelAndView updateForm(int mediagroupno) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("mediagroup/updateForm");
		mav.addObject("root", Utility.getRoot());
		mav.addObject("dto", dao.read(mediagroupno));
		return mav;
	} // updateForm() end
	
	@RequestMapping(value = "mediagroup/update.do", method = RequestMethod.POST)
	public ModelAndView update(MediagroupDTO dto) {
		ModelAndView mav = new ModelAndView();
		
		int cnt = dao.update(dto);
		if(cnt==0) {
			mav.setViewName("mediagroup/msgView");
			String img = "<img src='../images/fail.png' style='width: 50%;'>";
			String link1 = "<input type='button' value='다시시도' onclick='javascript:history.back()'>";
			String link2 = "<input type='button' value='그룹목록' onclick='javascript:location.href=\"list.do\"'>";
			mav.addObject("msg1", "<p>미디어 그룹 수정 실패 !</p>");
			mav.addObject("img", img);
			mav.addObject("link1", link1);
			mav.addObject("link2", link2);
		} else {
			mav.setViewName("redirect:/mediagroup/list.do");
		} // if end
		return mav;
	} // update() end
	
} // class end

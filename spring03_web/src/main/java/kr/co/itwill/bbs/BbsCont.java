package kr.co.itwill.bbs;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class BbsCont {

	public BbsCont() {
		System.out.println("-----------BbsCont() 객체 생성됨");
	} // end
	
	// 결과확인 http://localhost:9095/bbs/create.do GET 방식으로 호출
	@RequestMapping(value = "/bbs/create.do", method = RequestMethod.GET)
//	1)
//	public ModelAndView bbsForm() {
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("bbs/bbsForm");
//		return mav;
//	} // bbsForm() end
//	
//	2) 1번과 동일하게 페이지 이동이 가능하다
	public String bbsForm() {
		return "bbs/bbsForm";
	} // bbsForm()
	
	// 동일한 요청 명령어를 GET | POST 방식으로 구분해서 호출 가능하다
	@RequestMapping(value = "/bbs/create.do", method = RequestMethod.POST)
//	1) 매개변수가 HttpServletRequest 일 경우
//	public ModelAndView bbsIns(HttpServletRequest req) {
//		// 사용자가 입력 요청한 정보 가져오기
//		String wname	= req.getParameter("wname").trim();
//		String subject	= req.getParameter("subject").trim();
//		String content	= req.getParameter("content").trim();
//		String passwd	= req.getParameter("passwd").trim();
//		
//		ModelAndView mav = new ModelAndView();
//		mav.setViewName("bbs/bbsResult");
//		
//		mav.addObject("wname", wname);
//		mav.addObject("subject", subject);
//		mav.addObject("content", content);
//		mav.addObject("passwd", passwd);		
//		
//		return mav;
//	} // bbsIns() end
	
//	2) 매개변수가 DTO일 경우
// 	-> 해당 클래스(BbsDTO)에 반드시 폼 컨트롤 요소 이름으로 되어있는 멤버변수와 각 getter, setter의 변수가 동일해야한다.
//	@ModelAttribute는 생략이 가능하다
	public ModelAndView bbsIns(@ModelAttribute BbsDTO dto) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("bbs/bbsResult2");
		mav.addObject("dto", dto);
		return mav;		
	} // bbsIns() end
	
	
	
	
} // class end

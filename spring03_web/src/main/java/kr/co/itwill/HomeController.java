package kr.co.itwill;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

// URL에서 요청, 응답이 가능한 클래스 지정
@Controller
public class HomeController {
	
	public HomeController () {
		System.out.println("---------HomeController() 객체 생성됨");
	} // end
	
	// 결과 확인 http://localhost:9095/home.do
	
	// 요청 명령어를 등록하고 실행의 주체는 메서드(함수)
	@RequestMapping("/home.do")
	public ModelAndView home () {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("start");
		
		mav.addObject("message", "어서오세요");
		mav.addObject("img", "<img src='images/monkey.png'>");
		
		return mav;
		
	} // home() end	
	
} // class end

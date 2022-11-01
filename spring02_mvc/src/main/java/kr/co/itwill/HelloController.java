package kr.co.itwill;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import kr.co.yermi.josamoa.Josamoa;

// URL에서 요청한 명령어를 읽어서 처리해주는 클래스로 지정
// web.xml 에 ~~~.do 와 같은 명령어를 입력하지 말고 클래스로 구현을 하는 것
// HelloController 클래스는 컨트롤러 기능을 한다.
// 스프링 컨테이너(웹서버)가 자동으로 객체를 생성한다.
@Controller
public class HelloController {
	
	public HelloController() {
		System.out.println("----HelloController() 객체 생성됨");
	} // end
	
	// 결과확인 http://localhost:9095/hello.do
	// 요청 명령어 등록 후 실행의 주체는 메서드(함수)
	
	@RequestMapping("/hello.do")
	public ModelAndView hello() {
		
		ModelAndView mav = new ModelAndView();
		Josamoa js = new Josamoa();
		
		// application.properties 환경 설정 파일의 prefix와 suffix 값을 조합해서 뷰페이지를 완성시킨다.
		// /WEB-INF/views/hello.jsp
		mav.setViewName("hello");
		
		// 서로 다른 페이지들 간의 값을 공유하기 위해서
		// -> request, session, application 활용
		
		// request.setAttribute() 함수와 동일
		mav.addObject("message", "Welcome to MyHome");	
		
		String t1 = js.setJosa("T1", "은는");
		String drx = js.setJosa("DRX", "은는");
		String jdg = js.setJosa("JDG", "은는");
		String geng = js.setJosa("GEN-G", "은는");
		mav.addObject("t1", t1);
		mav.addObject("drx", drx);
		mav.addObject("jdg", jdg);
		mav.addObject("geng", geng);
		
		return mav;
		
	} // hello() end
	
} // class end

package kr.co.itwill.product;

import java.io.File;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping("/product")
public class ProductCont {

	public ProductCont() {
		System.out.println("-----------ProductCont() 객체 생성됨");
	} // end
	
	@Autowired
	ProductDAO productDao;
	
	@RequestMapping("/list")
	public ModelAndView list() {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/list");
		mav.addObject("list", productDao.list());
		return mav;
	} // list() end
	
	// 결과 확인 http://localhost:9095/product/write
	// 상품 업로드 시 리네임이 되지 않기 때문에 동일한 파일명은 업로드하면 안된다
	@RequestMapping("/write")
	public String write() {
		return "product/write";
	} // write() end
	
	@RequestMapping("/insert")
	public String insert(@RequestParam Map<String, Object> map
						,@RequestParam MultipartFile img
						,HttpServletRequest req) {
		
		String filename = "-";
		long filesize = 0;
		if(img != null && !img.isEmpty()) {
			filename = img.getOriginalFilename();
			filesize = img.getSize();
			try {
				ServletContext application = req.getSession().getServletContext();
				String path = application.getRealPath("/storage");
				img.transferTo(new File(path+"\\"+filename));
			} catch (Exception e) {
				System.out.print("파일 등록 실패 : ");
				e.printStackTrace(); // 에러 출력 메서드
			} // try end			
		} // if end
		
		map.put("filename", filename);
		map.put("filesize", filesize);
		productDao.insert(map);
		return "redirect:/product/list";
	} // insert() end
	
	
	
} // class end

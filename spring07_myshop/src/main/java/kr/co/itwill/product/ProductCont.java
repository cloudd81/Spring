package kr.co.itwill.product;

import java.io.File;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
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
	
	@RequestMapping("/search")
	public ModelAndView search(@RequestParam(defaultValue = "") String product_name) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/list");
		mav.addObject("list", productDao.search(product_name));
		mav.addObject("product_name", product_name);
		return mav;
	} // search() end
	
	@RequestMapping("/detail/{product_code}")
	public ModelAndView detail(@PathVariable String product_code) {
		ModelAndView mav = new ModelAndView();
		mav.setViewName("product/detail");
		mav.addObject("product", productDao.detail(product_code));
		return mav;
	} // detail() end
	/*
	 * @RequestParam
	 * 	http://192.168.0.1:9095?aaa=bbb&ccc=ddd
	 * 
	 * @PathVariable
	 * 	http://192.168.0.1:9095/bbb/ddd
	 */
	
	@RequestMapping("/update")
	public String update(@RequestParam Map<String, Object> map
						,@RequestParam MultipartFile img
						,HttpServletRequest req) {
		
		String filename = "-"; 
		long filesize = 0;
		String product_code = map.get("product_code").toString();
		Map<String, Object> product = productDao.detail(product_code);
		if(img != null && !img.isEmpty()) {
			filename = img.getOriginalFilename(); 
			filesize = img.getSize();
			try {
				ServletContext application = req.getSession().getServletContext();
				String path = application.getRealPath("/storage");
				
				// 기존 파일 삭제하기
				String oldFilename = product.get("FILENAME").toString();
				File file = new File(path+"\\"+oldFilename);
				if(file.exists()) {
					file.delete();
				} // if end
				
				img.transferTo(new File(path+"\\"+filename));
			} catch (Exception e) {
				System.out.print("파일 등록 실패 : ");
				e.printStackTrace(); // 에러 출력 메서드
			} // try end			
		} else {
			filename=product.get("FILENAME").toString();
			filesize=Long.parseLong(product.get("FILESIZE").toString());
			// filesize=(long)product.get("FILESIZE"); 오류
		}// if end
		
		map.put("filename", filename);
		map.put("filesize", filesize);
		productDao.update(map);
		return "redirect:/product/list";
	} // update() end
	
	@RequestMapping("/delete")
	public String delete(int product_code, HttpServletRequest req) {
		String filename = productDao.filename(product_code);
		if(filename != null && !filename.equals("-")) {
			ServletContext application = req.getSession().getServletContext();
			String path = application.getRealPath("/storage");
			File file = new File(path+"\\"+filename);
			if(file.exists()) {
				file.delete();
			} // if end
		} // if end
		productDao.delete(product_code); // 행삭제
		
		return "redirect:/product/list";
	} // delete() end
	
	
	
} // class end

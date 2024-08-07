package teamproject.ssja.controller.home;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import teamproject.ssja.dto.mainpage.MainPageDTO;
import teamproject.ssja.dto.product.ProductItemDto;
import teamproject.ssja.dto.product.SearchForm;
import teamproject.ssja.dto.product.SearchResultsWithConditionDTO;
import teamproject.ssja.service.Product.ProductService;
import teamproject.ssja.service.mainpage.MainPageService;

@RestController
@Slf4j
public class HomeRestController {

	@Autowired
	MainPageService mainPageService;
	@Autowired
	ProductService productService;

	@GetMapping("/home/event-banners")
	public ResponseEntity<?> eventTrans() {

			return ResponseEntity.ok("success");


	}
	@GetMapping("/home/mainpage/data")
	public ResponseEntity<MainPageDTO> mainPageData(@RequestParam("bestPageNum")int bestPageNum){
		//("bestPageNum {}", bestPageNum);
		MainPageDTO data = mainPageService.getMainPageData(bestPageNum);
		
		return ResponseEntity.ok(data);
	}
	
	@PostMapping("/search/items")
	public ResponseEntity<SearchResultsWithConditionDTO> searchitems(@RequestBody SearchForm form){
		try {
			
		//("fornm {}", form);
		
		SearchResultsWithConditionDTO data = productService.getSearchItems(form);
		
		return ResponseEntity.ok(data);
		
		} catch (Exception e) {
			
			return ResponseEntity.badRequest().body(null);
		}
	}
	
	
	

//	@PostMapping("/logout")
//	public ResponseEntity<String> logoutProcess() {
//		ResponseEntity<String> entity = null;
//		try {
//			//("로그아웃 통신 확인");
//			entity = new ResponseEntity<String>("success", HttpStatus.OK);
//
//		} catch (Exception e) {
//			//("실패");
//			entity = new ResponseEntity<String>(e.getMessage(), HttpStatus.BAD_REQUEST);
//		}
//		return entity;
//	}

}



package teamproject.ssja.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import lombok.extern.slf4j.Slf4j;
import teamproject.ssja.dto.BoardDto;
import teamproject.ssja.dto.ProductCategoryGroupDto;
import teamproject.ssja.dto.ProductDto;
import teamproject.ssja.dto.VendorSalesDto;
import teamproject.ssja.dto.VendorSearchDatasVO;
import teamproject.ssja.dto.vendor.TotalVendorInfoDto;
import teamproject.ssja.dto.vendor.VendorInfoDTO;
import teamproject.ssja.dto.vendor.VendorItemCondition;
import teamproject.ssja.page.Criteria;
import teamproject.ssja.page.Page10VO;
import teamproject.ssja.page.PageVO;
import teamproject.ssja.service.Product.ProductCategoryService;
import teamproject.ssja.service.Vendor.VendorService;

@Slf4j
@RestController
@RequestMapping("/api/vendor")
public class VendorRestController {

	@Autowired
	private VendorService vendorService;

	// 카테고리 작업도 여기서 함
	@Autowired
	private ProductCategoryService productCategoryService;

	

	// 판매자 정보 가져오기
	// @RequestMapping(value = "/vendorInfo", method = RequestMethod.POST)
	@PostMapping("/vendorInfo")
	public ResponseEntity<VendorInfoDTO> getInfo(@RequestParam("vendorData") long vendorNo) {
		try {
			VendorInfoDTO vendorInfo = vendorService.getVendor(vendorNo);
			//("vendorInfo: " + vendorInfo);
			return ResponseEntity.ok(vendorInfo);
		} catch (Exception e) {
			e.printStackTrace(); // 예외 스택 트레이스를 콘솔에 출력
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new VendorInfoDTO());
		}
	}

	// 판매자 정보 가져오기
	// @RequestMapping(value = "/category", method = RequestMethod.GET)
	@GetMapping("/category")
	public ResponseEntity<List<ProductCategoryGroupDto>> getPCSub(@RequestParam("categoryNo") long categoryNo) {
		try {
			List<ProductCategoryGroupDto> thePCSubs = productCategoryService.getPCSub(categoryNo);
			//("thePCSubs: " + thePCSubs);
			return ResponseEntity.ok(thePCSubs);
		} catch (Exception e) {
			e.printStackTrace(); // 예외 스택 트레이스를 콘솔에 출력
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
					.body(new ArrayList<ProductCategoryGroupDto>());
		}
	}

	@GetMapping("/totalInfo")
	public ResponseEntity<TotalVendorInfoDto> getTotalInfoVendor(@RequestParam String bizname) {

		//("판매자 명 : {}", bizname);
		try {

			TotalVendorInfoDto data = vendorService.getVendorTotalInfo(bizname, 1);
			return ResponseEntity.ok(data);

		} catch (Exception e) {

			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	@GetMapping("/items")
	public ResponseEntity<List<ProductDto>> getVendorItemList(@RequestParam("bizname") String bizname,
																@RequestParam("pageNum") int pageNum,
																@RequestParam("start") int start,
																@RequestParam("end") int end,
																@RequestParam("order") String order) {
		//("seller {}, page {} ,{} ~ {}, ordered {}", bizname, pageNum,start,end, order);
		VendorItemCondition condition =  new VendorItemCondition(bizname, pageNum,start,end, order);
		try {
			return ResponseEntity.ok(vendorService.getVendorItemList(condition));

		} catch (Exception e) {

			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(null);
		}
	}

	@GetMapping("/productcount")
	public long getProductCount(@ModelAttribute Criteria criteria){
		return vendorService.getProductCounts(criteria);
	}

	@GetMapping("/qnascount")
	public long getQnaCount(@ModelAttribute Criteria criteria){
		return vendorService.getProductCounts(criteria);
	}
	
	@GetMapping("/salesdata/{vno}")
	public ResponseEntity<List<VendorSalesDto>> getWeeklyData(@PathVariable("vno") long vno){
		try {
			List<VendorSalesDto> recentWeeklyData = vendorService.getWeeklySalesData(vno);
			return ResponseEntity.ok(recentWeeklyData);
		} catch (Exception e) {
			e.printStackTrace(); // 예외 스택 트레이스를 콘솔에 출력
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new ArrayList<VendorSalesDto>());
		}
	}
	
	@GetMapping("/total/{vno}")
	public ResponseEntity<VendorSalesDto> getTotalData(@PathVariable("vno") long vno){
		try {			
			VendorSalesDto totalData = vendorService.getTotalSalesData(vno);
			return ResponseEntity.ok(totalData);
		} catch (Exception e) {
			e.printStackTrace(); // 예외 스택 트레이스를 콘솔에 출력
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new VendorSalesDto());
		} 
	}
	
	// 판매자 검색
	@GetMapping("/search/QnA")
	public ResponseEntity<VendorSearchDatasVO> getSearchQnaList(Criteria criteria, 
			@RequestParam("option") String option, 
			@RequestParam("keyword") String keyword){
		try {
			List<BoardDto> totalData = vendorService.getQnaSearchLists(criteria, option, keyword);
			PageVO pageVO = new PageVO(vendorService.getQnaSearchCounts(criteria, option, keyword), criteria); 
			VendorSearchDatasVO vendorSearchDatasVO = new VendorSearchDatasVO(totalData, pageVO);
			return ResponseEntity.ok(vendorSearchDatasVO);
		} catch (Exception e) {
			e.printStackTrace(); // 예외 스택 트레이스를 콘솔에 출력
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new VendorSearchDatasVO());
		} 
	}
	
	// 판매자 검색
	@GetMapping("/search/product")
	public ResponseEntity<VendorSearchDatasVO> getSearchProductList(Criteria criteria, 
			@RequestParam("option") String option, 
			@RequestParam("keyword") String keyword){
		try {
			List<ProductDto> totalDataPro = vendorService.getSearchProducts(criteria, option, keyword);
			Page10VO page10VO = new Page10VO(vendorService.getSearchProductsCount(criteria, option, keyword), criteria); 
			VendorSearchDatasVO vendorSearchDatasVO = new VendorSearchDatasVO(totalDataPro,page10VO);
			return ResponseEntity.ok(vendorSearchDatasVO);
		} catch (Exception e) {
			e.printStackTrace(); // 예외 스택 트레이스를 콘솔에 출력
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(new VendorSearchDatasVO());
		} 
	}
}


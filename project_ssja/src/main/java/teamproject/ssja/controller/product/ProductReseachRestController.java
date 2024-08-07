package teamproject.ssja.controller.product;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import ch.qos.logback.core.pattern.util.RegularEscapeUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import teamproject.ssja.dto.product.ProductCondition;
import teamproject.ssja.dto.product.ProductItemDto;
import teamproject.ssja.dto.product.ProductWithConditionDTO;
import teamproject.ssja.service.Product.ProductService;

@RestController
@Slf4j
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductReseachRestController {
	
	private final ProductService productService;
	
	@PostMapping("/lists")
	ResponseEntity<ProductWithConditionDTO> transProductList(@RequestBody ProductCondition productCondition){
		ProductCondition conditionItems = productService.getTotalItemsCount(productCondition);
		ProductWithConditionDTO items = new ProductWithConditionDTO(conditionItems);
		items.setItemList(productService.getProductList(conditionItems));
		log.warn("productCondition is {}", productCondition);
		return ResponseEntity.ok().body(items);
	}
	
	
	@GetMapping("/best-mainpage")
	ResponseEntity<List<ProductItemDto>> mainPageBestItems(@RequestParam int page){
		
		List<ProductItemDto> bestItems = productService.bestItemsList(page);
		
		return ResponseEntity.ok().body(bestItems);
	}
	
	@GetMapping("/category-mainpage")
	ResponseEntity<List<ProductItemDto>> mainPageCategoryItems(@RequestParam("categoryNum") int categoryNum,
																@RequestParam("pageNum") int pageNum){
		
		//("category {}, pageNum {}", categoryNum, pageNum);
		List<ProductItemDto> list = productService.getCategoryItems(categoryNum, pageNum);
		//("list = {}", list);
		return ResponseEntity.ok(list);
	}

	
	
}

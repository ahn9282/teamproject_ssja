package teamproject.ssja.service.Admin;

import java.util.List;

import teamproject.ssja.dto.ProductReviewsDto;
import teamproject.ssja.dto.ProductDto;
import teamproject.ssja.dto.ProductReviewReplyDto;
import teamproject.ssja.dto.ProductsSearchDto;
import teamproject.ssja.page.Criteria;

public interface ProductListService {

	long getProductListTotalCount();
	List<ProductDto> getProductListWithPaging(Criteria cri);
	//검색리스트
	List<ProductsSearchDto> getProductsSearchList(String type, String keyword);
	
	ProductDto getProductId(int PRO_NO);

	void modifyProduct(ProductDto productDto);
	
	void removeProduct(ProductDto productDto);
	
	int addProduct(ProductDto productDto);
	
	List<ProductReviewsDto> getReviewsByProductId(int productId);
	List<ProductReviewReplyDto> getReplyReviewsByProductId(int productId);
	int removeReviewProduct(ProductReviewsDto productReviewsDto);
	int removeReplyReviewProduct(ProductReviewReplyDto productReviewReplyDto);

}

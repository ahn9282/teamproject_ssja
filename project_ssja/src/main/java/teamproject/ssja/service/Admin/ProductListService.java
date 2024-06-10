package teamproject.ssja.service.Admin;

import java.util.List;

import teamproject.ssja.dto.ProductDto;
import teamproject.ssja.dto.ProductsSearchDto;
import teamproject.ssja.page.Criteria;

public interface ProductListService {

	long getProductListTotalCount();
	List<ProductDto> getProductListWithPaging(Criteria cri);
	//검색리스트
	List<ProductsSearchDto> getProductsSearchList(String type, String keyword);

}

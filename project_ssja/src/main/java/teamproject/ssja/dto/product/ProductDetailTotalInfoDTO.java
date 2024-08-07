package teamproject.ssja.dto.product;

import java.util.Collections;
import java.util.List;
import java.util.stream.Collectors;

import lombok.Data;
import teamproject.ssja.dto.ProductImgDto;

@Data
public class ProductDetailTotalInfoDTO {

	private Long pro_no;
	private Long v_no;
	private int p_c_no;
	private int pro_quantity;
	private int pro_price;
	private String pro_bannerimg;
	private int pro_wish;
	private int pro_sellcount;
	private String pro_bizname;
	private String pro_name;
	private Double avgeval;
	private String v_license;
	private String m_name;
	private String m_address1;
	private String m_address2;
	private String m_email;
	private String m_phone;
	private int countrv;
	private String pro_img_path;
	private List<ProductImgDto> imgList;
	private String category1;
	private String category2;
	private int pro_hit;

	public Double formattingAvgEval() {
		if(avgeval==null) {
			return 0d;
		}
		return Math.ceil(avgeval * 100) / 100;
	}

	// npe 방지를 위한 Collection.emptyList()로 반환
	// db 상품 이미지 객체 중 cover(상세 - 상반부 이미지) 경로로 시작하는 것들로만 필터링을 거쳐 해당 경로의 list반환
	public List<String> findCoverImg() {
		if (this.imgList == null) {
			return Collections.emptyList();
		}
		List<String> list = imgList.stream()
				.filter(e -> e != null && e.getPiPath() != null &&
				(e.getPiPath().startsWith("/images/product_cover/") || e.getPiPath().startsWith("/home/ubuntu/images/product_cover")))
				.map(ProductImgDto::getPiPath).collect(Collectors.toList());

		return list.isEmpty() ? Collections.emptyList() : list;
	}

	//// db 상품 이미지 객체 중 details(상세-메인) 경로로 시작하는 것들로만 필터링을 거쳐 해당 경로의 list반환
	public List<String> findMainImg() {
		if (this.imgList == null) {
			return Collections.emptyList();
		}

		List<String> list = imgList.stream()
				.filter(e -> e != null && e.getPiPath() != null &&
				(e.getPiPath().startsWith("/images/product_details/") ||  e.getPiPath().startsWith("/home/ubuntu/images/product_details")))
				.map(ProductImgDto::getPiPath).collect(Collectors.toList());

		return list.isEmpty() ? Collections.emptyList() : list;
	}
}

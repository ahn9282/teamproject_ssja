package teamproject.ssja.service.Vendor;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import teamproject.ssja.dto.BoardDto;
import teamproject.ssja.dto.ProductDto;
import teamproject.ssja.dto.ProductImgDto;
import teamproject.ssja.dto.StatisticVO;
import teamproject.ssja.dto.VendorSalesDto;
import teamproject.ssja.dto.vendor.TotalVendorInfoDto;
import teamproject.ssja.dto.vendor.VendorEtcInfoDTO;
import teamproject.ssja.dto.vendor.VendorInfoDTO;
import teamproject.ssja.dto.vendor.VendorItemCondition;
import teamproject.ssja.dto.vendor.VendorProfitDTO;
import teamproject.ssja.mapper.VendorMapper;
import teamproject.ssja.page.Criteria;

@Slf4j
@Service
public class VendorServiceImpl implements VendorService{
	
	@Autowired
	VendorMapper vendorMapper;

	// 파일을 저장할 디렉터리 경로
//	private String productImgDir = System.getProperty("user.dir") + "/src/main/resources/static/images/";
	// 배포 시 경로에 문제가 있다면, 이는 아래 부분에 작성하도록 하기
	 private String productImgDir = "/home/ubuntu/images/";	
			
	// 폴더명
	private String bannerDir = "product_banner";
	private String coverDir = "product_cover";
	private String explainDir = "product_details";
	
	@Override
	public VendorInfoDTO getVendor(long mNo) {
		return vendorMapper.selectVendor(mNo);
	}

	// 배너
	@Override
	public void addProduct(ProductDto productDto, MultipartFile bannerFile) {
		//("addProduct()..");
		String bannerFileDir = productImgDir + bannerDir;
		
		
		// java.io
		// 디렉터리 생성
//		File directoryBanner = new File(bannerFileDir);
//		
//		if(!directoryBanner.exists()) {
//			directoryBanner.mkdirs();
//		}
		
		// 파일 처리
		fileTransferTo(bannerFileDir, bannerFile, 1);
		
		// /images/ 가져오기 
		String extracted = productImgDir.substring(productImgDir.length() - 8);
		
		// /images/product_banner/파일명.확장자
		productDto.setPRO_BANNERIMG(bannerFileDir + "/" + ssjaFileNameFormat(bannerFile.getOriginalFilename(),1));
		vendorMapper.insertProduct(productDto);
	}

	@Override
	public long getProNum(ProductDto productDto) {
		return vendorMapper.selectInsertedProNum(productDto);
	}
	
	@Override
	public void addProductImgs(List<MultipartFile> coverFile, List<MultipartFile> explainFile, long pro_no) {
		//("addProductImgs()..");
		String coverFileDir = productImgDir + coverDir;
		String explainFileDir = productImgDir + explainDir;
		
		// 디렉터리 파일
		File directoryCover = new File(coverFileDir);
		File directoryExplain = new File(explainFileDir);
		
		//("cover : " + directoryCover);
		//("explain : " + directoryExplain);
		
		// 디렉터리 파일을 담는 배열
		File[] productDirectorys = {directoryCover,directoryExplain};
		
//		// 디렉터리 파일 없으면 만드는 로직
//		Arrays.stream(productDirectorys).forEach(directory -> {
//			if(!directory.exists()) {
//				directory.mkdirs();
//			}
//		});

		//(coverFile.size() + "개의 커버 파일이 있음");
		
		for(int i=0; i < coverFile.size(); i++) {
			fileTransferTo(coverFileDir, coverFile.get(i), i+1);
			ProductImgDto pImgDto = new ProductImgDto();
			pImgDto.setPNo(pro_no);
			pImgDto.setPiPath(coverFileDir + "/" + ssjaFileNameFormat(coverFile.get(i).getOriginalFilename(),i+1));
			vendorMapper.insertProductImgs(pImgDto);
		}
		
		for(int i=0; i< explainFile.size(); i++) {
			fileTransferTo(explainFileDir, explainFile.get(i), i+1);
			ProductImgDto pImgDto = new ProductImgDto();
			pImgDto.setPNo(pro_no);
			pImgDto.setPiPath(explainFileDir + "/" + ssjaFileNameFormat(explainFile.get(i).getOriginalFilename(),i+1));
			vendorMapper.insertProductImgs(pImgDto);
		}
	}

	@Override
	public String isEmpty(MultipartFile bannerFile, List<MultipartFile> coverFile, List<MultipartFile> explainFile, Model model) {
		// 셋 중 하나라도 파일이 비어있을 때 진행하는 처리
		model.addAttribute("message", "파일을 업로드하시지 않았습니다. 홈 화면으로 돌아갑니다.");
		return "redirect:/vendor";
	}

	
	// 파일명 + 확장자가 나오는 originalFileName을 활용하여 이름 재설정
	@Override
	public String ssjaFileNameFormat(String originalFileName, int num) {
		// 확장자를 담을 변수
		String extension = "";
				
		// 구분자(.) 인덱스 
		int dotIndex = originalFileName.lastIndexOf('.');
		
		String formatFileName = "";
		
		if (dotIndex != -1 && dotIndex < originalFileName.length() - 1) {
			extension = originalFileName.substring(dotIndex);
			formatFileName = originalFileName.substring(0, dotIndex);
		}else {
			formatFileName = originalFileName;
		}

		return formatFileName + "_" + num + extension;
	}
	
	void fileTransferTo(String fileDir, MultipartFile file, int i) {		
		try {
			String originalFileName = file.getOriginalFilename();
			String formatBannerfileName = ssjaFileNameFormat(originalFileName, i);

			String filePath = fileDir + "/" + formatBannerfileName; 
			//("filePath : " + filePath);
			file.transferTo(new File(filePath));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	@Override
	public List<BoardDto> getQnaLists(Criteria criteria, Long bcno, Long bmno) {
		criteria.setBcno(bcno);
		criteria.setBmno(bmno);
		return vendorMapper.selectVendorQnas(criteria);
	}

	@Override
	public List<ProductDto> getProductList(Criteria criteria, Long vno) {
		criteria.setVno(vno);
		return vendorMapper.selectVendorProducts(criteria);
	}

	@Override
	public long getQnaCounts(Criteria criteria) {
		return vendorMapper.selectVendorQnaCount(criteria);
	}

	@Override
	public long getProductCounts(Criteria criteria) {
		// TODO Auto-generated method stub
		return vendorMapper.selectVendorProductsCount(criteria);
	}

	//회원의 판매자 조회
	@Override
	public TotalVendorInfoDto getVendorTotalInfo(String bizname, int pageNum) {
		TotalVendorInfoDto data = new TotalVendorInfoDto();
		data.setCommuList(vendorMapper.getVendorInfoCommu(bizname));
		VendorEtcInfoDTO info =vendorMapper.getVendorInfoEtc(bizname);
		data.setInfo(info);
		
		return data;
		
	}

	@Override
	public List<ProductDto> getVendorItemList(VendorItemCondition condition) {
		return vendorMapper.getVendorItemList(condition);
	}


	@Override
	public List<VendorSalesDto> getWeeklySalesData(long vno) {
		// TODO Auto-generated method stub
		return vendorMapper.selectVendorSalesInWeek(vno);
	}

	@Override
	public Map<String, List<VendorProfitDTO>> getDataForExcel(Long vno, String condition) {
		Map<String, List<VendorProfitDTO>> data = new HashMap<>();
		data.put("day", vendorMapper.getProfitStatistic(vno, "YY-MM-DD", condition));
		data.put("month", vendorMapper.getProfitStatistic(vno, "YYYY-MM", condition));
		data.put("year", vendorMapper.getProfitStatistic(vno, "YYYY", condition));
		
		return data;
	}
	
	public List<VendorSalesDto> getDaySalesData(StatisticVO statisticVO) {
		// TODO Auto-generated method stub
		return vendorMapper.selectVendorSalesInDay(statisticVO);
	}

	@Override
	public List<VendorSalesDto> getMonthSalesData(StatisticVO statisticVO) {
		// TODO Auto-generated method stub
		return vendorMapper.selectVendorSalesInMonth(statisticVO);
	}

	@Override
	public List<VendorSalesDto> getYearSalesData(StatisticVO statisticVO) {
		// TODO Auto-generated method stub
		return vendorMapper.selectVendorSalesInYear(statisticVO);
	}

	@Override
	public VendorSalesDto getTotalSalesData(long vno) {
		// TODO Auto-generated method stub
		return vendorMapper.selectVendorSalesTotal(vno);
	}

	@Override
	public List<BoardDto> getQnaSearchLists(Criteria criteria, String option, String keyword) {
		return vendorMapper.selectSearchVendorQnas(criteria, option, keyword);
	}

	@Override
	public long getQnaSearchCounts(Criteria criteria, String option, String keyword) {
		// TODO Auto-generated method stub
		return vendorMapper.selectSearchVendorQnaCount(criteria, option, keyword);
	}

	@Override
	public ProductDto getThisProduct(long proNo) {
		// TODO Auto-generated method stub
		return vendorMapper.selectUpdateProductData(proNo);
	}

	@Override
	public void modifyProduct(ProductDto productDto) {
		// TODO Auto-generated method stub
		vendorMapper.updateProduct(productDto);
	}

	@Override
	public List<ProductDto> getSearchProducts(Criteria criteria, String option, String keyword) {
		return vendorMapper.selectVendorSearchProducts(criteria, option, keyword);
	}

	@Override
	public long getSearchProductsCount(Criteria criteria, String option, String keyword) {
		return vendorMapper.selectVendorSearchProductsCount(criteria, option, keyword);
	}
}

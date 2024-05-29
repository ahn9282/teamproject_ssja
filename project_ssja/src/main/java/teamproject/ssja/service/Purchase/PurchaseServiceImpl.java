package teamproject.ssja.service.Purchase;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import teamproject.ssja.dto.OrdersDto;
import teamproject.ssja.dto.PurchaseDto;
import teamproject.ssja.mapper.MembersMapper;
import teamproject.ssja.mapper.OrdersMapper;
import teamproject.ssja.mapper.PurchaseMapper;

@Service
public class PurchaseServiceImpl implements PurchaseService {	

	@Autowired
	PurchaseMapper purchaseMapper;
	
	@Autowired
	OrdersMapper ordersMapper;
	
	@Autowired
	MembersMapper membersMapper;
	
//	@Autowired
//	UserInfoDTO userinfo;
	
	@Override
	public int Purchase(Map<String, Object> purchaseData) {
		PurchaseDto purchase;
		List<OrdersDto> orders= new ArrayList<>();
		int ordersCount=0;

		System.out.println(purchaseData);
		
		//http요청에서 point를 출력하는 부분
		membersMapper.subPoint(Long.valueOf((String) purchaseData.get("M_NO")), 
							   Long.valueOf((String) purchaseData.get("USE_POINT")));
		
//		userinfo.setM_Point((int)(userinfo.getM_Point()-Long.valueOf((String) purchaseData.get("USE_POINT"))));
		
		purchaseData.remove("USE_POINT");
		
		//http요청을 가공하여 purchase를 출력하는 부분
		purchase= new PurchaseDto(0,Long.valueOf((String) purchaseData.get("M_NO")),
									Long.valueOf((String)purchaseData.get("PUR_TOT")), 
									Long.valueOf((String)purchaseData.get("PUR_DC")), 
									Long.valueOf((String)purchaseData.get("PUR_PAY")), 
									(String)purchaseData.get("PUR_PAYMENT"), 
									"SYSDATE", 
									(String)purchaseData.get("PUR_DVADDRESS"), 
									(String)purchaseData.get("PUR_DV"));
		purchaseData.remove("M_NO");
		purchaseData.remove("PUR_TOT");
		purchaseData.remove("PUR_DC");
		purchaseData.remove("PUR_PAY");
		purchaseData.remove("PUR_PAYMENT");
		purchaseData.remove("PUR_DVADDRESS");
		purchaseData.remove("PUR_DV");
		
		purchaseMapper.insertPurchase(purchase);
		
		//http 요청을 가공하여 productlist를 출력하는 부분(제일 마지막에 들어가야함)
		for(int i=0; i<purchaseData.size()/6;i++) {
			orders.add(new OrdersDto(0L,purchase.getPUR_NO(),
										Long.valueOf((String)purchaseData.get("products["+i+"][product_no]")),
										Long.valueOf((String)purchaseData.get("products["+i+"][quantity]")),
										Double.valueOf((String)purchaseData.get("products["+i+"][discount]")).longValue(),
										Long.valueOf((String)purchaseData.get("products["+i+"][price]")),
										Double.valueOf((String)purchaseData.get("products["+i+"][pay]")).longValue(),
										Long.valueOf((String)purchaseData.get("products["+i+"][coupon]")),"결제완료"));
		}
		for (OrdersDto order : orders) {
			ordersCount+=ordersMapper.insertOrder(order);
		}
		System.out.println(ordersCount);

		return ordersCount; 
	}
	
}


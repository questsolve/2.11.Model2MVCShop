package com.model2.mvc.web.purchase;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {

	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productService;
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseService;
		
	
	
	public PurchaseRestController() {
		System.out.println("PurchaseController Default Constructor");
	}
	
//	@RequestMapping(value="addPurchase", method=RequestMethod.POST)
//	public String addPurchase(@ModelAttribute("purchase")Purchase purchase, 
//									   @RequestParam("buyerId")String buyerId, @RequestParam("prodNo") int prodNo, HttpServletRequest request) throws Exception {
//		
//		System.out.println("/addPurchase.do");
//		Product product = productService.getProduct(prodNo);
//		User user = userService.getUser(buyerId);
//		
//		purchase.setBuyer(user);
//		purchase.setPurchaseProd(product);
//		purchase.setDivyAddr(request.getParameter("receiverAddr"));
//		purchase.setDivyDate(request.getParameter("receiverDate"));
//		purchase.setDivyRequest(request.getParameter("receiverRequest"));
//		purchase.setPaymentOption(request.getParameter("paymentOption"));
//		purchase.setReceiverName(request.getParameter("receiverName"));
//		purchase.setReceiverPhone(request.getParameter("receiverPhone"));
//		purchase.setPurchaseCount(Integer.parseInt(request.getParameter("purchaseCount")));
//		
//		if( (purchase.getPurchaseProd().getProdInven()<purchase.getPurchaseCount() ) ){
//			request.setAttribute("purchase", purchase);
//			return "forward:/purchase/refusePurchase.jsp";
//		}
//		
//		purchaseService.addPurchase(purchase);
//		productService.updateProductCount(purchase.getPurchaseCount(), purchase.getPurchaseProd().getProdNo());
//		
//		return "forward:/purchase/addPurchase.jsp";
//	}
	
	@RequestMapping(value="json/addPurchase", method=RequestMethod.POST)
	public Purchase addPurchase(@RequestBody Purchase purchase) throws Exception {
		
		System.out.println("/addPurchase");
		Product product = productService.getProduct(purchase.getPurchaseProd().getProdNo());
		User user = userService.getUser(purchase.getBuyer().getUserId());
		
		purchase.setBuyer(user);
		purchase.setPurchaseProd(product);
		
		purchaseService.addPurchase(purchase);
		productService.updateProductCount(purchase.getPurchaseCount(), purchase.getPurchaseProd().getProdNo());
		
		ModelAndView mV = new ModelAndView(); 
		mV.addObject("purchase", purchase);	
		mV.setViewName("forward:/purchase/addPurchase.jsp");
		return purchase;
	}
		
	@RequestMapping(value="json/getPurchase/{tranNo}")
	public Purchase getPurchase(@PathVariable int tranNo) throws Exception{
		
		System.out.println("json/getPurchase");
		System.out.println(tranNo+" 번 거래목록");
		Purchase purchase = purchaseService.getPurchase(tranNo);
		System.out.println(purchase);
	
		
		return purchase;
	}
	/*@RequestMapping(value="json/listPurchase")
	public Map listPurchase(@RequestBody List list) throws Exception{
		System.out.println("/json/listPurchase");
		System.out.println(list);
		System.out.println(list.get(0));
		System.out.println(list.get(1));
		String buyerId = (String)(list.get(1));
		Search search = (Search)(list.get(0));
		
		System.out.println(search);
		System.out.println(buyerId);
		Map returnmap =purchaseService.getPurchaseList(search, buyerId);			
		return returnmap;
	}*/
	
	@RequestMapping(value="json/listPurchase")
	public Map listPurchase(@RequestBody Map map) throws Exception{
		System.out.println("/json/listPurchase");
		
		String buyerId = (String) map.get("buyer");
		Map search = (Map) map.get("search");
		int currentPage = (int) search.get("currentPage");
		int pageSize = (int)search.get("pageSize");
		String ordering = (String)search.get("ordering");
		Search newSearch = new Search();
		newSearch.setCurrentPage(currentPage);
		newSearch.setOrdering(ordering);
		newSearch.setPageSize(pageSize);
		
		
		System.out.println(search.get("currentPage"));
		System.out.println(search.get("pageSize"));
		System.out.println(search);
		System.out.println(buyerId);
		Map returnmap =purchaseService.getPurchaseList(newSearch, buyerId);			
		return returnmap;
		//return null;
	}

	@RequestMapping(value="json/updatePurchase", method=RequestMethod.POST)
	public Purchase updatePurchase(@RequestBody Purchase purchase) throws Exception{
		System.out.println("/updatePurchase.do");
		Purchase dbPurchase = purchaseService.getPurchase(purchase.getTranNo());
		dbPurchase.setDivyAddr(purchase.getDivyAddr());
		dbPurchase.setDivyDate(purchase.getDivyDate());
		dbPurchase.setDivyRequest(purchase.getDivyRequest());
		dbPurchase.setPaymentOption(purchase.getPaymentOption());
		
		purchaseService.updatePurchase(purchase);
				
		return dbPurchase;
	}
	
	@RequestMapping(value="json/updateTranCode")
	public Purchase updateTranCode(@RequestBody Purchase purchase) throws Exception {
		Purchase dbPurchase = purchaseService.getPurchase(purchase.getTranNo());
		System.out.println("트랜코드 : "+dbPurchase.getTranCode());
		if(dbPurchase.getTranCode().equals(null)) {
			dbPurchase.setTranCode("0");
		}
		
		int tranCode = Integer.parseInt(dbPurchase.getTranCode().trim());
		System.out.println("tranCode = " + tranCode);
		
		
		
		
		if(tranCode<2) {
			tranCode= tranCode+1;
		}
		
		purchase.setTranCode(""+tranCode);
		
		String transtatus ="";
		if(purchase.getTranCode().contains("0")){
			transtatus = "배송 준비 중";
		}else if(purchase.getTranCode().contains("1")){
			transtatus = "배송 중";
		}else{
			transtatus = "배송 완료";
		}
		
		
		purchaseService.updateTranCode(purchase);
		
		return purchase;
	}
}

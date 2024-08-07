package teamproject.ssja.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import lombok.extern.slf4j.Slf4j;
import teamproject.ssja.dto.ReplysDto;
import teamproject.ssja.dto.login.CustomPrincipal;
import teamproject.ssja.dto.userinfo.ReviewForm;
import teamproject.ssja.page.Criteria;
import teamproject.ssja.page.PageVO;
import teamproject.ssja.service.Reply.ReplyService;

@Slf4j
@RestController
@RequestMapping("/api/replys")
public class ReplyController {

	@Autowired
	private ReplyService replyService;

	@GetMapping("/list")
	public ResponseEntity<Map<String, Object>> getReplyList(Criteria criteria, @RequestParam("bno") long bno){
		Map<String, Object> responseData = new HashMap<>();
		try {
			// criteria.setBno(bno);
			responseData.put("replys", replyService.showReplys(criteria.getBno()));
			//("replys : " + responseData.get("replys"));
			responseData.put("pageMaker", new PageVO(replyService.getTotal(criteria.getBno()), criteria));
			//("pageMaker : " + responseData.get("pageMaker"));			
			return ResponseEntity.ok().body(responseData);			
		} catch (Exception e) {
			e.printStackTrace();
			responseData.put("error", "댓글 목록을 불러오는데 실패했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseData);
		} 		
	}
	
	@GetMapping("/list/{pageNum}/{amount}") 
	public ResponseEntity<Map<String, Object>> getReplyPageList(Criteria criteria,
			@PathVariable("pageNum") int pageNum, @PathVariable("amount") int amount, @RequestParam("bno") long bno){
		
		Map<String, Object> responseData = new HashMap<>();
		try {			
//			criteria.setBno(bno);
//			criteria.setPageNum(pageNum);
//			criteria.setAmount(amount);
			responseData.put("replys", replyService.showReplys(criteria.getBno()));
			//("replys : " + responseData.get("replys"));
			responseData.put("pageMaker", new PageVO(replyService.getTotal(criteria.getBno()), criteria));
			//("pageMaker : " + responseData.get("pageMaker"));
			return ResponseEntity.ok().body(responseData);			
		} catch (Exception e) {
			e.printStackTrace();
			responseData.put("error", "댓글 목록을 불러오는데 실패했습니다.");
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(responseData);
		} 		
	}
	
	@PostMapping(value="/apply")
	public ResponseEntity<String> applyReview(ReviewForm form,  @AuthenticationPrincipal CustomPrincipal user){
		//("data {}", form);
		try {
		if(user.isOAuth2User()) {
			form.setWriter(user.getEmail());
		}else {
			form.setWriter(user.getUserInfo().getM_NickName());
		}
		replyService.appleReview(form);
			return ResponseEntity.ok("success");
		}catch(Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("에러 발 생");
		}
	}
	
	@PostMapping("/add") 
	public ResponseEntity<String> addReply(ReplysDto replysDto){
		try {		
			replyService.addReply(replysDto);			
			return ResponseEntity.ok("add reply success");			
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("답변 입력에 에러가 발생");
		} 		
	}
	
	@PostMapping("/modify") 
	public ResponseEntity<String> modifyReply(ReplysDto replysDto){
		try {		
			replyService.modifyReply(replysDto);			
			return ResponseEntity.ok("modify reply success");			
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("답변 수정에 에러가 발생");
		} 		
	}
	
	@PostMapping("/delete") 
	public ResponseEntity<String> deleteReply(ReplysDto replysDto){
		try {		
			replyService.removeReply(replysDto);			
			return ResponseEntity.ok("remove reply success");			
		} catch (Exception e) {
			e.printStackTrace();
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("답변 삭제에 에러가 발생");
		} 		
	}
}

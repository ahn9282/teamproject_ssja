package teamproject.ssja.service.Community;

import java.util.List;

import org.springframework.util.MultiValueMap;
import org.springframework.web.multipart.MultipartFile;

import teamproject.ssja.dto.BoardDto;
import teamproject.ssja.dto.BoardIsLikedDto;
import teamproject.ssja.dto.MembersDto;
import teamproject.ssja.dto.ProductDto;
import teamproject.ssja.dto.ReplysDto;
import teamproject.ssja.dto.community.CommunityBoardDto;
import teamproject.ssja.dto.login.CustomPrincipal;



public interface CommunityService {
	
	//게시물 총개수 얻어오는 메서드
	long getCommunityTotal();
	//검색요건에 맞는 게시물의 총개수를 얻어오는 메서드
	long getCommunitySearchTotal(String option, String keyword);
	//검색요건에 맞는 게시물의 리스트를 얻어오는 메서드
	List<CommunityBoardDto> getSearchPost(int pageNum, int amount, String option, String keyword);
	//게시물 리스트 얻어오는 메서드
	List<CommunityBoardDto> getPost(int pageNum,int amount);
	//베스트 게시물 리스트 얻어오는 메서드
	List<CommunityBoardDto> getBestPost();
	//게시물의 조회수를 올리는 메서드
	int updateHit(CustomPrincipal principal,long bno);
	//게시물 내용 얻어오는 메서드
	CommunityBoardDto getContent(long bno);
	//게시물 입력 메서드
	long insertPost(BoardDto post);
	//게시물을 삭제하는 메서드
	int deletePost (long bno);
	//게시물 좋아요 개수 얻어오는 메서드
	long getBoardLikedTotal(long bno);
	//게시물 좋아요를 추가하는 메서드
	int insertBoardLiked(BoardIsLikedDto liked);
	//게시물에 해당 회원이 좋아요를 추가한 이력이 있는지 확인하는 메서드
	BoardIsLikedDto getBoardLiked(BoardIsLikedDto liked);
	//게시글 업데이트 메서드
	int modifyContent(BoardDto content);
	//게시글 임시 이미지 업데이트 메서드	
	String updateTempBoardImg(List<String> allList,List<String> realList,long bno);	
	//게시글 입력시 임시 이미지 삭제 메서드
	boolean deleteTempBoardImg(List<String> fileNames);
	//게시글의 상품 업데이트 메서드
	int updateBoardProduct(long bno,long proNo);
	//게시글의 연관 상품을 가져오는 메서드
	ProductDto getRelatedProduct(long proNo);
	//게시글의 최신 공지사항을 얻어오는 메서드
	BoardDto getNotice();
	
	
	//댓글 리스트 얻어오는 메서드
	List<ReplysDto> getReply(int replyNum,int amount, long bno);
	//댓글 총개수 얻어오는 메서드
	long getReplyTotal(long bno);
	//댓글 입력 메서드
	int insertReply(ReplysDto reply);
	//댓글 수정 메서드
	int updateReply(ReplysDto reply);
	//댓글 삭제 메서드
	int deleteReply(long rno);
	
	//상품을 얻어오는 메서드
	List<ProductDto> getProducts(String keyword);
	
	//특정유저를 얻어오는 메서드
	MembersDto getUser(long mno);
	
	//특정유저의 리뷰를 얻어오는 메서드
	List<BoardDto> getReviews(long mno);
	
	//상품의 카테고리를 얻어오는 메서드
	String getProductCategory(long pcno);
	
	//editor이미지 삽입 메서드
	String updateEditorImage(MultiValueMap<String, MultipartFile> multiValueMap);

	
	
	
}

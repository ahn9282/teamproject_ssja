package teamproject.ssja.service.Admin;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lombok.extern.slf4j.Slf4j;
import teamproject.ssja.dto.MembersDto;
import teamproject.ssja.dto.MembersSearchDto;
import teamproject.ssja.dto.QnaBoardDto;
import teamproject.ssja.dto.VendorDetailsDto;
import teamproject.ssja.mapper.AdminPageMapper;
import teamproject.ssja.page.Criteria;

@Slf4j
@Service
public class MemberListServiceImpl implements MemberListService {

	@Autowired
	private AdminPageMapper adminPageMapper;

	@Override
	public long getMemberListTotalCount() {
		//("getMemberListTotalCount()..");
		return adminPageMapper.getMemberListTotalCount();
	}

	@Override
	public List<MembersDto> getMemberListWithPaging(Criteria cri) {
		//("getMemberListWithPaging()..");
		return adminPageMapper.getMemberListWithPaging(cri);
	}

	@Override
	public List<MembersSearchDto> getMemberSearchList(String type, String keyword) {
		//("getMemberSearchList()..");

		return adminPageMapper.getMemberSearchList(type,keyword);
	}
		
	@Override
	public MembersDto getMemberId(int memberId) {
        return adminPageMapper.readMemberId(memberId); 
	}

	@Override
	public void modifyMember(MembersDto membersDto) {
    	adminPageMapper.updateMember(membersDto); 		
	}
	
	@Override
	public void removeMember(MembersDto membersDto) {
    	adminPageMapper.deleteMember(membersDto); 		
	}

	@Override
	public List<VendorDetailsDto> getVendorsList() {
		return  adminPageMapper.getVendorsList();
	}		
}

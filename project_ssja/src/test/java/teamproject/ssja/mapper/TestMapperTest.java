package teamproject.ssja.mapper;

import static org.junit.jupiter.api.Assertions.*;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import org.junit.jupiter.api.Disabled;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import lombok.extern.slf4j.Slf4j;
import teamproject.ssja.dto.AuthDto;
import teamproject.ssja.dto.MembersDto;

@Slf4j
@SpringBootTest
class TestMapperTest {

	@Autowired
	TestMapper testMapper;

	@Disabled
	@Test
	void test() {
		assertNotNull(testMapper);
	}

	@Disabled
	@Test
	void SelectMidTest() {
		String mid=testMapper.getMid("testUser1");
		log.info(mid);
	}
	
	@Disabled
	@Test
	void SelectMnameTest() {
		String mName=testMapper.getMNickName("tam");
		log.info(mName);
	}
	@Disabled
	@Test
	void SelectMEmailTest() {
		String mEmail=testMapper.getMEmail("user@gmail.com");
		log.info(mEmail);
	}
	
	@Disabled
	@Test
	void insertMnameTest() {
		MembersDto member= new MembersDto(0,"testUser1","testUser1","testUser1","수원시","팔달구","21231","990408",null,"user@gmail.com","01023451234",0,null,"tam");
		int result=testMapper.insertMember(member);
		log.info(result+"");
	}
	@Disabled
	@Test
	void insertAuthTest() {
		AuthDto auth= new AuthDto("testUser1",null);
		int result=testMapper.insertUserAuth(auth.getM_ID());
		log.info(result+"");
	}
	
}

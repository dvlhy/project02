package com.haeyeong.project02.member;

import java.util.List;
import java.util.Map;

public interface MemberService {

	String create(Map<String, Object> map);

	Map<String, Object> detail(String id);
	
	String idChk(String id);

	String login(Map<String, Object> map);

	List<Map<String, Object>> orderList(String id);

	List<Map<String, Object>> searchList(Map<String, Object> map);


}

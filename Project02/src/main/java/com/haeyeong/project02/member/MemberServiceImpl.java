package com.haeyeong.project02.member;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
	
	@Autowired
	MemberDao memberDao;
	
	@Override
	public String create(Map<String, Object> map) {
		int rowCnt = this.memberDao.insert(map);
		if(rowCnt == 1)
			return map.get("id").toString();
		
		return null;
	}
	
	@Override
	public Map<String, Object> detail(String id){
		return this.memberDao.selectDetail(id);
	}

	@Override
	public String idChk(String id) {
		String useIdYn = this.memberDao.idChk(id);
		if(useIdYn != null) {
			useIdYn = "Y"; // id 존재
		}else {
			useIdYn = "N"; // id 미존재
		}
		
		return useIdYn;
	}

	@Override
	public String login(Map<String, Object> map) {
		return this.memberDao.login(map);
	}

	@Override
	public List<Map<String, Object>> orderList(String id) {
		return this.memberDao.selectOrdList(id);
	}

	@Override
	public List<Map<String, Object>> searchList(Map<String, Object> map) {
		return this.memberDao.searchList(map);
	}
	
}

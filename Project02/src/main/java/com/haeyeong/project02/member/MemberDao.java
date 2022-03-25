package com.haeyeong.project02.member;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MemberDao {
	
	@Autowired
	SqlSessionTemplate sqlSessionTemplate;
	
	public int insert(Map<String, Object> map) {
		return this.sqlSessionTemplate.insert("member.insert", map);
	}
	
	public Map<String, Object> selectDetail(String id){
		return this.sqlSessionTemplate.selectOne("member.select", id);
	}

	public String idChk(String id) {
		return this.sqlSessionTemplate.selectOne("member.idChk", id);
	}

	public String login(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectOne("member.login", map);
	}

	public List<Map<String, Object>> selectOrdList(String id) {
		return this.sqlSessionTemplate.selectList("member.selectOrdList", id);
	}

	public Map<String, Object> selectMbrInfo(String user_id) {
		return this.sqlSessionTemplate.selectMap("member.selectMbrInfo", user_id);
	}

	public List<Map<String, Object>> searchList(Map<String, Object> map) {
		return this.sqlSessionTemplate.selectList("member.searchList", map);
	}

}

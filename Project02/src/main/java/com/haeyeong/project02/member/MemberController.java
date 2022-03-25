package com.haeyeong.project02.member;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.haeyeong.project02.HomeController;
import com.haeyeong.project02.util.JwtService;

@Controller
@RequestMapping("member")
public class MemberController { 
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	JwtService jwtService;
	
	@RequestMapping(value = "/memberCreate", method = RequestMethod.GET)
	public ModelAndView memberCreate() {
		return new ModelAndView("member/create");
	}
	
	@RequestMapping(value = "/memberCreatePost", method = RequestMethod.POST)
	public ModelAndView createPost(@RequestParam Map<String, Object> map,
			HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mv = new ModelAndView();
		if(map.get("gender") == null) {
			map.put("gender", "");
		}
		String mbrId = this.memberService.create(map);
		if(mbrId == null) {
			mv.setViewName("redirect:/memberCreate");
		}else {
			mv.setViewName("redirect:/member/main");
		}
		
		return mv;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@RequestParam Map<String, Object> map, 
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mv = new ModelAndView();
		String loginId = this.memberService.login(map);
		if(loginId == null) {
			//throw new Exception("로그인 정보 확인 후 다시 해주세요.");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인 정보 확인 후 다시 해주세요.'); location.href='/';</script>");
			out.flush();
		}else {
			HttpSession session = request.getSession();
			String user_id = request.getParameter("id");
			session.setAttribute("mbrId", request.getParameter("id"));
			
			if(user_id != null && user_id.length() != 0) {
				Map<String, Object> mbrMap = this.memberService.detail(user_id);
				if(mbrMap.get("AUTH").equals("admin")) {
					mv.setViewName("redirect:/member/mainAdmin");
				}else {
					mv.setViewName("redirect:/member/main");
				}
				mv.addObject("id", user_id);
			}else {
				mv.setViewName("redirect:/");
				session.invalidate();
			}
		}
		return mv;
	}
	
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(@RequestParam String id,
			HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.invalidate();
		session.removeAttribute("mbrId");
		return new ModelAndView("/");
	}
	
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public ModelAndView main(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		ModelAndView mv = new ModelAndView();
		
		String id = (String)session.getAttribute("mbrId");
		List<Map<String, Object>> list = this.memberService.orderList(id);
		
		mv.addObject("list", list);
		mv.setViewName("/member/main");
		return mv;
	}
	
	@RequestMapping(value = "/mainAdmin", method = RequestMethod.GET)
	public ModelAndView mainAdmin(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HttpSession session = request.getSession();
		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = null;
		
		String id = (String)session.getAttribute("mbrId");
		List<Map<String, Object>> list = this.memberService.searchList(map);
		
		mv.addObject("list", list);
		mv.setViewName("/member/mainAdmin");
		return mv;
	}
	
	
	@RequestMapping(value = "/searchList", method = RequestMethod.POST)
	public ModelAndView searchList(@RequestParam String nameSearch, @RequestParam String emailSearch) {
		System.out.println("===================  "+nameSearch);
		ModelAndView mv = new ModelAndView();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("nameSearch", nameSearch);
		map.put("emailSearch", emailSearch);
		List<Map<String, Object>> list = this.memberService.searchList(map);
		
		mv.addObject("list", list);
		mv.setViewName("/member/mainAdmin");
		return mv;
	}
	
	
	
	@RequestMapping(value = "/detail", method = RequestMethod.GET)
	public ModelAndView detail(HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("mbrId");
		Map<String, Object> detailMap = this.memberService.detail(id);
		
		ModelAndView mv = new ModelAndView();
		mv.addObject("data", detailMap);
		mv.addObject("mbrId", id);
		mv.setViewName("/member/detail");
		return mv;
	}
	
	@RequestMapping(value="/idChk", method = RequestMethod.GET)
	public ModelAndView idChk(@RequestParam String id) {
		ModelAndView mv = new ModelAndView();
		String idYn = this.memberService.idChk(id);
		mv.addObject("idYn", idYn);
		mv.setViewName("member/memberCreate");
		return mv;
	}

}

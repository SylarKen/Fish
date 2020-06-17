package com.domor.controller;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.domor.util.AuthFilter;
/**
 * 用于tcp测试
 * @author KingLong
 *
 */
@Controller
@RequestMapping("TCPController")
public class TCPController {
	@AuthFilter
	@RequestMapping("/tcp")
	public String index() {
		return "/TCP";
	}
}

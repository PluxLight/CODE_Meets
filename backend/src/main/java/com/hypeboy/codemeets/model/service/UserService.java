package com.hypeboy.codemeets.model.service;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import com.hypeboy.codemeets.model.dto.UserDto;

public interface UserService {
	// 개발용 API
	public List<UserDto> getUserList(String userId) throws Exception;
	public List<UserDto> getAllUserList() throws Exception;
	
	// 회원가입
	public void registUser(UserDto userDto) throws Exception;
	public void registUserInfo(UserDto userDto) throws Exception;
	
	// 유저 중복검사
	public int getUserIdOverlap(String userId) throws Exception;
	public int getUserTelOverlap(String userId) throws Exception;
	public int getUserEmailOverlap(String userId) throws Exception;
	
	// 아이디, 비밀번호 찾기
	public String searchId(String type, String data) throws Exception;
}

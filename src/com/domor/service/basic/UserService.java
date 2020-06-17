package com.domor.service.basic;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.domor.dao.basic.UserDao;
import com.domor.model.User;
import com.domor.util.DigestUtil;
import com.domor.util.MapUtils;

@Service("userService")
public class UserService {

	@Autowired
	private UserDao userDao;
	
	@Transactional
	public void insert(Map<String,Object> user) {		
		String pondCode = MapUtils.getStringValue(user, "pondCode");
		userDao.insert(user);
		
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("username", user.get("username").toString());		
		String[] pondCodes = pondCode.split(",");
		for(String pond :pondCodes){
			param.put("pondCode",pond);
			userDao.insertPonds(param);
		}
 
	}
	
	public int insertPonds(Map<String,Object> pond) {
		return userDao.insertPonds(pond);
	}
	
	public int deletePonds(String username) {
		return userDao.deletePonds(username);
	}
	
	@Transactional
	public void update(Map<String,Object> user) {
		userDao.update(user);		
	    String pondCode = MapUtils.getStringValue(user, "pondCode");
		String[] pondCodes = pondCode.split(",");
		Map<String,Object> param = new HashMap<String,Object>();
		param.put("username", user.get("username").toString());
		userDao.deletePonds(user.get("username").toString());
		for(String pond :pondCodes){
			param.put("pondCode",pond);
			userDao.insertPonds(param);
		}
		
	}
	
	public int delete(String username) {
		return userDao.delete(username);
	}
	
	public Map<String,Object> getByName(String username) {
		return userDao.getByName(username);
	}

	public List<Map<String,Object>> query(Map<String, Object> params) {
		return userDao.query(params);
	}

	public int count(Map<String, Object> params) {
		Integer result = userDao.count(params);
		return result == null ? 0 : result.intValue();
	}

	public void initUserPwd(Map<String, Object> params) {
		userDao.initUserPwd(params);
	}
	
//	public int saveUser(User user) {
//		int result = userDao.save(user);
//		return result;
//	}
//	
//	public int updateUser(User user) {
//		int result = userDao.updateUser(user);
//		return result;
//	}
//	
//	public int deleteUser(String username) {
//		int result = userDao.delete(username);
//		return result;
//	}
//	
//	public User getUserByName(String name) {
//		User user = userDao.getByName(name);
//		return user;
//	}
//	
//	public List<User> queryUser(Map<String, Object> params) {
//		List<User> users = userDao.query(params);
//		return users;
//	}
//	
//	public int count(Map<String, Object> params) {
//		int count = userDao.count(params);
//		return count;
//	}
//	
//	
//	public void initUserPwd(Map<String, Object> params) {
//		userDao.initUserPwd(params);
//	}

}

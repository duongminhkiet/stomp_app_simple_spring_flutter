package com.zmk.spring.stomp.chatapp.service;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.zmk.spring.stomp.chatapp.model.chat.ZMKUserObj;
import com.zmk.spring.stomp.chatapp.repository.ZMKUserRepository;

@Service
public class ZMKUserService {
	@Autowired
	ZMKUserRepository userRepository;
	
	Optional<ZMKUserObj> findById(long id) {
		return userRepository.findById(id);
	}
	ZMKUserObj save(ZMKUserObj obj) {
		return userRepository.save(obj);
	}
}

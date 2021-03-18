package com.zmk.spring.stomp.chatapp.repository;

import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import com.zmk.spring.stomp.chatapp.model.chat.ZMKUserObj;

@Repository
public interface ZMKUserRepository extends MongoRepository<ZMKUserObj, Long>{

	
	
}

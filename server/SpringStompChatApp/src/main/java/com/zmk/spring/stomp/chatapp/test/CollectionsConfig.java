package com.zmk.spring.stomp.chatapp.test;

import javax.annotation.PostConstruct;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.DependsOn;
import org.springframework.context.annotation.Scope;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.index.TextIndexDefinition;
import org.springframework.data.mongodb.core.index.TextIndexDefinition.TextIndexDefinitionBuilder;

@Configuration
@DependsOn("mongoTemplate")
public class CollectionsConfig {

    @Autowired
    private MongoTemplate mongoTemplate;

    @PostConstruct
    public void initIndexes() {
		TextIndexDefinition textIndex = new TextIndexDefinitionBuilder()
				  .onField("content")
				  .build();

		mongoTemplate.indexOps(TestObj.class).ensureIndex(textIndex);
    }
    
    @Bean
    @Scope("prototype")
    public AppItf1 item1() {
        return new AppImpl1();
    }
}

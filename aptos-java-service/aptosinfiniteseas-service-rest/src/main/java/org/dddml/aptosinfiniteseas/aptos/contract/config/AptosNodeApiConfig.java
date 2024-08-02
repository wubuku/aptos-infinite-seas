package org.dddml.aptosinfiniteseas.aptos.contract.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategies;
import com.github.wubuku.aptos.utils.NodeApiClient;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import java.net.MalformedURLException;

@Configuration
public class AptosNodeApiConfig {
    @Value("${aptos.contract.node-api.base-url}")
    private String nodeApiBaseUrl;

    @Bean
    public NodeApiClient aptosNodeApiClient() throws MalformedURLException {
        ObjectMapper objectMapper = new ObjectMapper();
        objectMapper.setPropertyNamingStrategy(PropertyNamingStrategies.SNAKE_CASE);
        return new NodeApiClient(nodeApiBaseUrl, objectMapper);
    }
}

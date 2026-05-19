package com.fengwei.ticket.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebFilter("/*")
public class CharacterEncodingFilter implements Filter {

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // 设置请求编码
        httpRequest.setCharacterEncoding("UTF-8");
        httpResponse.setCharacterEncoding("UTF-8");

        // 仅对 HTML 页面设置 Content-Type，不影响 CSS/JS/图片等静态资源
        String path = httpRequest.getRequestURI().toLowerCase();
        if (!path.endsWith(".css") && !path.endsWith(".js") && !path.endsWith(".png")
                && !path.endsWith(".jpg") && !path.endsWith(".jpeg") && !path.endsWith(".gif")
                && !path.endsWith(".svg") && !path.endsWith(".ico") && !path.endsWith(".woff")
                && !path.endsWith(".woff2") && !path.endsWith(".ttf")) {
            httpResponse.setContentType("text/html;charset=UTF-8");
        }

        chain.doFilter(httpRequest, httpResponse);
    }

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
    }

    @Override
    public void destroy() {
    }
}
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String password = request.getParameter("password");
%>

<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/JSPBookDB_YR"
	driver="com.mysql.jdbc.Driver" user="root" password="0000" />

<sql:query dataSource="${dataSource}" var="resultSet">
   SELECT * FROM MEMBER WHERE ID=? and password=?  
   <sql:param value="<%=id%>" />
   <sql:param value="<%=password%>" />
</sql:query>

<c:choose>
   <c:when test="${not empty resultSet.rows}">
      <% 
         session.setAttribute("sessionId", id);
      %>
      <!-- 로그인 성공하면 바로 books.jsp로 이동 -->
      <c:redirect url="/books.jsp" />
   </c:when>
   <c:otherwise>
      <c:redirect url="loginMember.jsp?error=1" />
   </c:otherwise>
</c:choose>

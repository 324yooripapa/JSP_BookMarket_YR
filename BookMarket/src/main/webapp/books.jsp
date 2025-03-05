<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="./resources/css/bootstrap.min.css" />
    <title>도서목록</title>
    <style>
        /* 📚 도서목록 헤더 스타일 */
        .book-header {
            background-image: url('./resources/images/bookstore_bg.jpg'); /* 배경 이미지 추가 */
            background-size: cover;
            background-position: center;
            padding: 80px 20px;
            text-align: center;
            border-radius: 15px;
            color: white;
            font-weight: bold;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
        }

        /* 📖 책 정보 카드 스타일 */
        .book-card {
            background: white;
            border-radius: 10px;
            box-shadow: 0px 4px 6px rgba(0, 0, 0, 0.1);
            padding: 15px;
            text-align: center;
            transition: transform 0.2s ease-in-out;
        }

        .book-card:hover {
            transform: scale(1.05);
        }

        .book-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
            border-radius: 5px;
        }

        /* 📌 버튼 스타일 */
        .btn-custom {
            background-color: #795548;
            color: white;
            border-radius: 30px;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
        }

        .btn-custom:hover {
            background-color: #5d4037;
        }
    </style>
</head>
<body>
<div class="container py-4">
    <%@ include file="menu.jsp" %>

    <!-- 📚 도서목록 헤더 -->
    <div class="book-header">
        <h1 class="display-5 fw-bold"> 도서목록</h1>
    </div>

    <%@ include file="dbconn.jsp" %>

    <!-- 📖 도서 목록 -->
    <div class="row align-items-md-stretch text-center mt-4">
        <%
            PreparedStatement pstmt = null;
            ResultSet rs = null;
            String sql = "SELECT * FROM book";
            pstmt = conn.prepareStatement(sql);
            rs = pstmt.executeQuery();
            while (rs.next()) {
        %>
        <div class="col-md-4 mb-4">
            <div class="book-card">
                <img src="./resources/images/<%=rs.getString("b_filename")%>" alt="도서 이미지">
                <h5 class="mt-3"><b><%=rs.getString("b_name")%></b></h5>
                <p><%=rs.getString("b_author")%></p>
                <p><small><%=rs.getString("b_publisher")%> | <%=rs.getString("b_releaseDate")%></small></p>
                <p><%=rs.getString("b_description").substring(0, 60)%>...</p>
                <h6 class="text-danger fw-bold"><%=rs.getString("b_unitPrice")%>원</h6>
                <a href="./book.jsp?b_id=<%=rs.getString("b_id")%>" class="btn btn-custom">📖 상세 정보 &raquo;</a>               
            </div>
        </div>
        <%
            }
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        %>
    </div>

    <%@ include file="footer.jsp" %>
</div>
</body>
</html>

<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Date" %>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* 📖 전체 페이지 글꼴 설정 */
        body {
            background: url('./resources/images/bookstore_bg_(2).jpg') no-repeat center center/cover;
            color: #3e2723;
        }

        /* 🌟 환영 메시지 스타일 */
        .hero {
            background: rgba(255, 245, 235, 0.9);
            padding: 60px 40px;
            border-radius: 15px;
            text-align: center;
        }


        /* ⏳ 현재 시간 스타일 */
        .clock {
            font-size: 24px;
            font-weight: bold;
            color: #5d4037;
        }

        /* 📌 버튼 스타일 */
        .btn-custom {
            background-color: #795548;
            color: white;
            border-radius: 30px;
            padding: 12px 25px;
            font-size: 18px;
        }
        .btn-custom:hover {
            background-color: #5d4037;
        }

        /* 📚 추가적인 소개 섹션 */
        .feature {
            background: rgba(255, 255, 255, 0.8);
            padding: 30px;
            border-radius: 10px;
            text-align: center;
            margin-top: 30px;
        }

        /* 📜 푸터 스타일 */
        .footer {
            text-align: center;
            padding: 20px;
            margin-top: 40px;
            font-size: 14px;
            color: #6d4c41;
        }
    </style>
    <title>책과 함께하는 특별한 시간</title>
</head>
<body>

<div class="container py-5">
    <%@ include file="menu.jsp" %>

    <!-- 🌟 환영 메시지 -->
    <div class="hero">
        <h1 class="display-4 fw-bold">책과 함께하는 특별한 시간</h1>
        <p class="fs-5">문학을 사랑하는 당신을 위한 온라인 서점에 오신 것을 환영합니다.</p>
        <p class="clock">
            <%
                response.setIntHeader("Refresh", 5);
                Date day = new java.util.Date();
                String am_pm;
                int hour = day.getHours();
                int minute = day.getMinutes();
                int second = day.getSeconds();

                if (hour / 12 == 0) {
                    am_pm = "AM";
                } else {
                    am_pm = "PM";
                    hour = hour - 12;
                }
                String CT = hour + ":" + minute + ":" + second + " " + am_pm;
                out.println("현재 시간: " + CT);
            %>
        </p>
        <a href="books.jsp" class="btn btn-custom mt-3">도서 구경하기 &raquo;</a>
    </div>

    <!-- 📚 추가 소개 섹션 -->
    <div class="row text-center mt-5">
        <div class="col-md-4">
            <div class="feature">
                <img src="./resources/images/novel.jpg" class="img-fluid rounded shadow-sm" alt="문학 소설">
                <h3 class="mt-3">감성적인 문학 소설</h3>
                <p>마음을 울리는 이야기와 깊은 감동을 선사하는 소설들을 만나보세요.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature">
                <img src="./resources/images/cafe_reading.jpg" class="img-fluid rounded shadow-sm" alt="카페에서 독서">
                <h3 class="mt-3">따뜻한 카페, 독서의 즐거움</h3>
                <p>좋아하는 책과 함께 여유로운 독서 시간을 가져보세요.</p>
            </div>
        </div>
        <div class="col-md-4">
            <div class="feature">
                <img src="./resources/images/classic_books.jpg" class="img-fluid rounded shadow-sm" alt="클래식 문학">
                <h3 class="mt-3">고전부터 현대 문학까지</h3>
                <p>세대를 초월하는 명작들과 새로운 문학 작품을 모두 만나볼 수 있습니다.</p>
            </div>
        </div>
    </div>

    <div class="footer">
        &copy; 2025 BookMarket | 당신의 독서를 응원합니다 📖
    </div>
</div>

</body>
</html>


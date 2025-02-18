<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Date" %>

<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Welcome</title>
</head>
<body>
<div class="container py-4">
	<%@ include file="menu.jsp" %>
    


<%! String greeting="도서 쇼핑몰에 오신 것을 환영합니다.";
String tagline="Welcome to Web Market!"; %>

<div class="p-5 mb-4 bg body-tertiary rounded-3">
<div class="container-fluid py-5">
		<h1 class="display-5 fw-bold"><%=greeting %></h1>
		<p class="col-md-8 fs-4">BookMarket</p>
	</div>
</div>

<div class="row align-items-md-stretch  text-center">
<div class="col-md-12">
<div class="h-100 p-5">
<h3><%=tagline%></h3>

<%
	response.setIntHeader("Refresh", 5);
	Date day = new java.util.Date();
	//현재 날짜와 시각을 얻어오기 위해 Date 클래스의 인스턴스 day를 생성함
	
	String am_pm;
	int hour=day.getHours();
	int minute=day.getMinutes();
	int second=day.getSeconds();
	//Date 클래스의 인스턴스 day를 통해 현재 시, 분, 초를 얻어오도록 작성함
	
	if (hour /12==0){
						am_pm="AM";
					}
	else {
		 				am_pm="PM";
						hour=hour -12;
					}
	//현재 시각이 12 이하이면 "AM"을 출력하고 12를 초과하면 "PM"을 출력함
	
	String CT=hour+":"+minute+":"+second+" "+am_pm;
	out.println("현재 접속 시각: " +CT +"\n");
%>

</div>
</div>
</div>
<%@ include file="footer.jsp" %>
</div>
</body>
</html>


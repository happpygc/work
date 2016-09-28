<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>无需刷新整个Web页面显示服务器响应的当前时间</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
  </head>

  <body>
  		 当前时间：${requestScope.nowStr }</br>
		<input id="01" type="button" value="传统同步方式获取服务器时间"></br>
		<hr>
		
		当前时间:<span id= "time"></span> </br>
		<input id="02" type="button" value="异步方式获取服务器时间"></br>
		
		<script type="text/javascript">
			//定位按钮，获取点击事件
			//alert(document.getElementById("01"));
			document.getElementById("01").onclick = function(){
				var url = "${pageContext.request.contextPath}/TimeServlet";
				window.location.href = url;
			}	
		</script>
		
		<script type="text/javascript">
			function creatAJAX(){
				var ajax = null;
				try{
					ajax =new ActiveXObject("microsoft.xmlhttp");
					
				}catch(e1){
					try{
						ajax = new XMLHttpRequest();
					}catch(e2){
						alert("浏览器不支持ajax");
					}
				}
			return ajax;
			}
		
		
		
		</script>
		<script type="text/javascript">
		
		document.getElementById("02").onclick = function(){
			//1.创建ajax对象
			var ajax =creatAJAX();
			//2.准备发送请求
			var method ="GET"
			var url = "${pageContext.request.contextPath}/TimeServlet1";
			ajax.open(method,url);
			//3.正真发送请求体的数据到服务器，如果请求体中无数据（get方式）,则用null
			ajax.send(null);
			//-------------等待----------------
			
			//ajax异步对象监听服务器响应的状态码（0，1，2，3，4）
			ajax.onreadystatechange = function(){
				if(ajax.readyState == 4){
					if(ajax.status == 200){
					//5.从AJAX对象获取服务器返回的HTML数据
						var nowStr = ajax.responseText;
					//6.将结果按DOM规则，动态加载到页面指定的标签中					
					var spanElement = document.getElementById("time");
					spanElement.innerHTML = nowStr;
					}
				}
			}
		
		}
		</script>
		
		  静态文本</br>
	

	

  </body>
</html>

<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.data.User" %>
<%
UserStore userStore = UserStore.getInstance();
User user = userStore.getUser((String)request.getSession().getAttribute("user"));
%>

<!DOCTYPE html>
<html>
<head>
  <title>Profile</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/activityfeed">Activity Feed</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null) { %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else { %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <a href="/profile">Profile</a>
  </nav>

  <div id="container">
    <h1>Profile</h1>

    <% if(request.getSession().getAttribute("user") != null){ %>
      <form action ="/profile" method="POST">
        <textarea 
            name="About Me" rows="10" col="40">
        </textarea>
        <br>
        <input type="Submit">
       </form>
       <p> <%= user.getAboutMe() %> </p> 
    <% } %>
  </div>
</body>
</html>
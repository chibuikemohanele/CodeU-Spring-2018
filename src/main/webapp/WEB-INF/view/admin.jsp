<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.User" %>

<!DOCTYPE html>
<html>
<head>
  <title>Admin Page</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/activityfeed">Activity Feed</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/conversations">Conversations</a>
    <a href="/about.jsp">About</a>
    <a href="/profile">Profile</a>
    <% if(request.getSession().getAttribute("user").equals("annietang") ||
        request.getSession().getAttribute("user").equals("chibuikem")) { %>
        <a href="/admin">Admin Page</a>
    <% } %>
  </nav>

  <div id="container">
    <%-- If there are errors, tell Admin.  --%>
    <% if(request.getAttribute("error") != null) { %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } %>

    <%-- Else, display site statistics.  --%>
    <h1> Administration </h1>
    <h2> Site Statistics </h2>
    <%
    List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");
    List<Message> messages = (List<Message>) request.getAttribute("messages");
    List<User> users = (List<User>) request.getAttribute("users");
    %>
    <ul>

    <% if(users != null){ %>
        <li><strong>Users:</strong> <%= users.size() %> </li>
    <% } %>
    <% if(conversations != null){ %>
        <li><strong>Conversations:</strong> <%= conversations.size() %> </li>
    <% } %>
    <% if(messages != null){ %>
        <li><strong>Messages:</strong> <%= messages.size() %> </li>
    <% } %>
    </ul>
  </div>
</body>
</html>

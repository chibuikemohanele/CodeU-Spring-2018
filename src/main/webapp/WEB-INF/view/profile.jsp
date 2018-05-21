<!DOCTYPE html>
<html>
<head>
  <title>Profile</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null) { %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
      <a href="/profile?username=user">Profile</a>
    <% } else { %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>
    <!-- <a href="/profile">Profile</a> -->
  </nav>

  <div id="container">
    <h1>Profile</h1>
    <h2>This is your profile.</h2>


    <!-- <% if(request.getAttribute("error") != null){ %>
        <h2 style="color:red"><%= request.getAttribute("error") %></h2>
    <% } %>

    <form action="/register" method="POST">
      <label for="username">Username: </label>
      <br/>
      <input type="text" name="username" id="username">
      <br/>
      <label for="password">Password: </label>
      <br/>
      <input type="password" name="password" id="password">
      <br/><br/>
      <button type="submit">Submit</button>
    </form> -->
  </div>
</body>
</html>
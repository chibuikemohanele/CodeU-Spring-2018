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

  <script type="text/javascript">
    function getDisplay(text)
    {
      //var text = document.getElementById("message").value;
      document.getElementById("Display").innerHTML = text
    }
  </script>

  <div id="container">
    <h1>Profile</h1>

    <% if(request.getSession().getAttribute("user") != null){ %>
      <h1>About Me</h1>
      <textarea name="message" id="message" style="height: 200px; width: 350px;"     onclick="this.value=''">Enter text here...</textarea>
      <button onclick= "getDisplay(document.getElementById('message').value)">Post</button>
    <% } %>
  </div>
  <div>
    <div id="Display">
  </div>
</body>
</html>
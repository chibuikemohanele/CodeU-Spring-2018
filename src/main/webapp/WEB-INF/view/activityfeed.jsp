<%--
  Copyright 2017 Google Inc.

  Licensed under the Apache License, Version 2.0 (the "License");
  you may not use this file except in compliance with the License.
  You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

  Unless required by applicable law or agreed to in writing, software
  distributed under the License is distributed on an "AS IS" BASIS,
  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
  See the License for the specific language governing permissions and
  limitations under the License.
--%>
<%@ page import="java.util.List" %>
<%@ page import="codeu.model.data.Conversation" %>

<!DOCTYPE html>
<html>
<head>
  <title>Activity Feed</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/conversations">Conversations</a>
    <a href="/about.jsp">About</a>
    <a href="/activityfeed">Activity Feed</a>
    <% if(request.getSession().getAttribute("user").equals("annietang") ||
        request.getSession().getAttribute("user").equals("chibuikem")) { %>
        <a href="/admin">Admin Page</a>
    <% } %>

  </nav>

  <div id="container">

    <h1>Activity Feed</h1>
    <hr/>

    <div style="background-color:Silver">
      <p><strong>Sat Mar 10 09:39:36 PST 2018: </strong>Ada joined!</p>
      <p><strong>Sat Mar 10 06:52:56 PST 2018: </strong>Grace sent a message in Programming Chat: "Hey Friends!"</p>
      <p><strong>Sat Mar 10 04:06:16 PST 2018: </strong>Alan sent a message in Cat Chat: "Yo yo yo!"</p>
      <p><strong>Sat Mar 10 01:19:36 PST 2018: </strong>Margaret joined!</p>
    </div>

  </div>
</body>
</html>

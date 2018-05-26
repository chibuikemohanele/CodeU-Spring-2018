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
<%@ page import="java.util.ListIterator" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.store.basic.UserStore" %>


<!DOCTYPE html>
<html>
<head>
  <title>Activity Feed</title>
  <link rel="stylesheet" href="/css/main.css">
</head>
<body>

  <nav>
    <a id="navTitle" href="/">CodeU Chat App</a>
    <a href="/activityfeed">Activity Feed</a>
    <a href="/conversations">Conversations</a>
    <% if(request.getSession().getAttribute("user") != null){ %>
      <a>Hello <%= request.getSession().getAttribute("user") %>!</a>
    <% } else{ %>
      <a href="/login">Login</a>
    <% } %>
    <a href="/about.jsp">About</a>

  </nav>

  <div id="container">

    <h1>Activity Feed</h1>
    <hr/>

    <div style="background-color:Silver">
      <!-- Add to activity feed when:
              - Users register -- "blahblah joined!" 
              - Users creating conversations -- "blahblah created a new conversation: Convo17"
              - Users sending messages -- Blahblah sent a message to Convo 17: Yoyo! -->


      <!-- USER REGISTERED -->
      <h3>New Users</h3>
     <%
      // Pull user data
      UserStore userStore = (UserStore) request.getAttribute("users");
      List<User> users = (List<User>) userStore.getAllUsers();
      ListIterator<User> itrU = users.listIterator(users.size());

      // empty?
      if(users == null || users.isEmpty()){
      %>
        <p>No New Users.</p>
      <%
      }
      else{ // not empty? make a list
      %>
        <ul class="mdl-list">
      <%
        while(itrU.hasPrevious()){
          User currUser = itrU.previous();
      %>
        <li>
          <strong> <%= currUser.getCreationTime() %>: </strong> 
          <%= currUser.getName() %> joined!
        </li> 
      <%
        }
      %>
        </ul>
      <%
      }
      %>


      <!-- CONVERSATION CREATION -->
      <h3>New Conversations</h3>
     
      <%
      // Pull conversation data
      List<Conversation> conversations = (List<Conversation>) request.getAttribute("conversations");

      ListIterator<Conversation> itrC = conversations.listIterator(conversations.size());

      // empty?
      if(conversations == null || conversations.isEmpty()){
      %>
        <p>No New Conversations.</p>
      <%
      }
      else{ // not empty? make a list
      %>
        <ul class="mdl-list">
      <%
        while(itrC.hasPrevious()){
          Conversation currConvo = itrC.previous();
      %>
        <li>
          <strong> <%= currConvo.getCreationTime() %>: </strong> 
          <%= (userStore.getUser(currConvo.getOwnerId())).getName() %> created a new conversation: 
          <a href="/chat/<%= currConvo.getTitle() %>"> <%= currConvo.getTitle() %></a>
        </li> 
      <%
        }
      %>
        </ul>
      <%
      }
      %>

      <!-- NEW MESSAGES -->
      <h3>New Messages</h3>
     


    </div>



  </div>
</body>
</html>

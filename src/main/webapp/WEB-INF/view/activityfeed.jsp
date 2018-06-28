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

<%@ page import="java.util.Arrays" %>
<%@ page import="java.util.Comparator" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ListIterator" %>
<%@ page import="codeu.model.data.Conversation" %>
<%@ page import="codeu.model.data.User" %>
<%@ page import="codeu.model.data.Message" %>
<%@ page import="codeu.model.data.Feed" %>
<%@ page import="codeu.model.store.basic.UserStore" %>
<%@ page import="codeu.model.store.basic.MessageStore" %>
<%@ page import="codeu.model.store.basic.ConversationStore" %>


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

      <!-- Add to activity feed when:
              - Users register ~ "blahblah joined!"
              - Users creating conversations ~ "blahblah created a new conversation: Convo17"
              - Users sending messages ~ Blahblah sent a message to Convo 17: Yoyo!
      -->

      <%
        // Stores
        UserStore userStore =  UserStore.getInstance();
        ConversationStore convoStore = ConversationStore.getInstance();
        MessageStore messageStore = MessageStore.getInstance();

        // Lists
        List<User> users = userStore.getLatestUsers();
        List<Conversation> conversations = (List<Conversation>) convoStore.getLatestConversations();
        List<Message> messages = messageStore.getLatestMessages();

        // New Feed
        Feed myFeed = new Feed();

        // add users
        for (int i = 0; i < users.size(); i++) {
            User currUser = users.get(i);
            myFeed.addNewUser(currUser.getCreationTime().toString(), currUser.getName());
        }

        // add conversations
        for (int i = 0; i < conversations.size(); i++) {
            Conversation currConversation = conversations.get(i);
            myFeed.addNewConversation(currConversation.getCreationTime().toString(), (userStore.getUser(currConversation.getOwnerId())).getName(), currConversation.getTitle());
        }

        // add messages
        for (int i = 0; i < messages.size(); i++) {
            Message currMessage = messages.get(i);
            myFeed.addNewMessage(currMessage.getCreationTime().toString(), (userStore.getUser(currMessage.getAuthorId())).getName(), (convoStore.getConversationWithID(currMessage.getConversationId())).getTitle(), currMessage.getContent());
        }

        myFeed.sortByTime();
    %>

    <div style="background-color:Silver">
      <%
          // Date format
          SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");

          // Iterate through feed
          int totalSize = (int) request.getAttribute("totalSize");

          for (int x = 0; x < totalSize; x++) {

                Instant ins = Instant.parse(myFeed.getEventDate(x));
                Date myDate = Date.from(ins);
                String formattedDate = sdf.format(myDate);

                // Conversations
                if (myFeed.getEventType(x) == "c") {
                %>
                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= myFeed.getUsername(x) %> created a new conversation:
                   <a href="/chat/<%= myFeed.getConversationTitle(x) %>"> <%= myFeed.getConversationTitle(x) %></a>.
                  </li>
                <%

                // Users
                } else if (myFeed.getEventType(x) == "u") {
                %>
                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= myFeed.getUsername(x) %> joined!
                  </li>
                <%

                // Messages
                } else if (myFeed.getEventType(x) == "m") {
                %>
                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= myFeed.getUsername(x) %> sent a message in
                   <a href="/chat/<%= myFeed.getConversationTitle(x) %>"> <%= myFeed.getConversationTitle(x) %></a>: "<%= myFeed.getMessageContent(x) %>"
                  </li>
                <%
              }
          }
      %>
    </div>
  </div>
</body>
</html>

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

        // Master List

          /*
            Overall Format:
              Date | Mode | Username | Convo | Message Content

            Convo Format:
              Date | c | Username | Convo | NULL

            User Format:
              Date | u | Username |  NULL | NULL

            Message Format:
              Date | m | Username | Convo | Message Content
          */

          int totalSize = (int) request.getAttribute("totalSize");
          // TODO: make object instance of master list instead
          String[][] masterList = new String[totalSize][5];

          // TODO: add users to object
          // add users
          for (int i = 0; i < users.size(); i++) {
              User currUser = users.get(i);

              masterList[i][0] = currUser.getCreationTime().toString();
              masterList[i][1] = "u";
              masterList[i][2] = currUser.getName();
              masterList[i][3] = "";
              masterList[i][4] = "";
          }

          // TODO: add convos to object
          // add convos
          for (int i = 0; i < conversations.size(); i++) {

              Conversation currConvo = conversations.get(i);
              int buff = users.size();

              masterList[i+buff][0] = currConvo.getCreationTime().toString();
              masterList[i+buff][1] = "c";
              masterList[i+buff][2] = (userStore.getUser(currConvo.getOwnerId())).getName();
              masterList[i+buff][3] = currConvo.getTitle();
              masterList[i+buff][4] = "";
          }

          // TODO: add messages to objects
          // add messages
          for (int i = 0; i < messages.size(); i++) {
              Message currMessage = messages.get(i);
              int buff = conversations.size() + users.size();

              masterList[i+buff][0] = currMessage.getCreationTime().toString();
              masterList[i+buff][1] = "m";
              masterList[i+buff][2] = (userStore.getUser(currMessage.getAuthorId())).getName();
              masterList[i+buff][3] = (convoStore.getConversationWithID(currMessage.getConversationId())).getTitle();
              masterList[i+buff][4] = currMessage.getContent();
          }



          // SORT MASTER LIST BASED ON TIMESTAMP
          // TODO: object instance sort by time
          Arrays.sort(masterList, new java.util.Comparator<String[]>() {
               public int compare(String[] a, String[] b) {

                  Instant ins1 = Instant.parse(a[0]);
                  Date date1 = Date.from(ins1);

                  Instant ins2 = Instant.parse(b[0]);
                  Date date2 = Date.from(ins2);

                   if (date2.before(date1))
                      return -1;
                   else
                     return 1;
               }
           }
        );

    %>

  <%

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
          // DATE FORMAT
          SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");

          // Iterate through master list
          for (int x = 0; x < totalSize; x++) {

                Instant ins = Instant.parse(masterList[x][0]); // TODO: use class access methods
                Date myDate = Date.from(ins);
                String formattedDate = sdf.format(myDate);

                // Conversations
                // TODO: use class access methods
                if (masterList[x][1] == "c") {
                %>

                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] /* TODO: use class access methods */%> created a new conversation:
                   <a href="/chat/<%= masterList[x][3] /* TODO: use class access methods */%>"> <%= masterList[x][3] %></a>.
                  </li>

                <%

                // Users
                // TODO: use class access methods
                } else if (masterList[x][1] == "u") {

                %>

                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] /* TODO: use class access methods */ %> joined!
                  </li>

                <%

                // Messages
                // TODO: use class access methods
                } else if (masterList[x][1] == "m") {

                %>

                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] /* TODO: use class access methods */ %> sent a message in
                   <a href="/chat/<%= masterList[x][3] %>"> <%= masterList[x][3] /* TODO: use class access methods */ %></a>: "<%= masterList[x][4] /* TODO: use class access methods */ %>"
                  </li>

                <%
              }
          }
      %>
    </div>

<br>
    <div style="background-color:Silver">

      <%
          // DATE FORMAT
          //SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");

          // Iterate through master list
          for (int x = 0; x < totalSize; x++) {

                Instant ins = Instant.parse(masterList[x][0]); // TODO: use class access methods
                Date myDate = Date.from(ins);
                String formattedDate = sdf.format(myDate);

                // Conversations
                // TODO: use class access methods
                if (masterList[x][1] == "c") {
                %>

                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] /* TODO: use class access methods */%> created a new conversation:
                   <a href="/chat/<%= masterList[x][3] /* TODO: use class access methods */%>"> <%= masterList[x][3] %></a>.
                  </li>

                <%

                // Users
                // TODO: use class access methods
                } else if (masterList[x][1] == "u") {

                %>

                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] /* TODO: use class access methods */ %> joined!
                  </li>

                <%

                // Messages
                // TODO: use class access methods
                } else if (masterList[x][1] == "m") {

                %>

                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] /* TODO: use class access methods */ %> sent a message in
                   <a href="/chat/<%= masterList[x][3] %>"> <%= masterList[x][3] /* TODO: use class access methods */ %></a>: "<%= masterList[x][4] /* TODO: use class access methods */ %>"
                  </li>

                <%
              }
          }
      %>
    </div>

  </div>
</body>
</html>

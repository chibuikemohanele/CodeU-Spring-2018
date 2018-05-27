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
<%@ page import="codeu.model.store.basic.UserStore" %>
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

    <div style="background-color:Silver">
      <!-- Add to activity feed when:
              - Users register -- "blahblah joined!" 
              - Users creating conversations -- "blahblah created a new conversation: Convo17"
              - Users sending messages -- Blahblah sent a message to Convo 17: Yoyo! 
      -->

      <%
        // Stores
          UserStore userStore = (UserStore) request.getAttribute("users");
          ConversationStore convoStore = (ConversationStore) request.getAttribute("conversations");

        // Lists
          List<User> users = userStore.getLatestUsers();
          List<Conversation> conversations = (List<Conversation>) convoStore.getLatestConversations();
          List<Message> messages = (List<Message>) request.getAttribute("messages");

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

          int totalSize = conversations.size() + users.size() + messages.size();
          String[][] masterList = new String[totalSize][5];

          // add convos
          for (int i = 0; i < conversations.size(); i++) {

              Conversation currConvo = conversations.get(i);

              // Date formatting
              String s = (currConvo.getCreationTime().toString()).replace("Z", "+00:00");
              s = s.substring(0, 22) + s.substring(23);

              masterList[i][0] = s;
              masterList[i][1] = "u";
              masterList[i][2] = (userStore.getUser(currConvo.getOwnerId())).getName();
              masterList[i][3] = currConvo.getTitle();
              masterList[i][4] = "";
          }

          // add users
          for (int i = 0; i < users.size(); i++) {

              User currUser = users.get(i);
              int buff = conversations.size();

              // Date formatting
              String s = (currUser.getCreationTime().toString()).replace("Z", "+00:00");
              s = s.substring(0, 22) + s.substring(23);

              masterList[i + buff][0] = s;
              masterList[i + buff][1] = "c";
              masterList[i + buff][2] = currUser.getName();
              masterList[i + buff][3] = "";
              masterList[i + buff][4] = "";
          }

          // // add messages
          for (int i = 0; i < messages.size(); i++) {

              Message currMessage = messages.get(i);
              int buff = conversations.size() + users.size();
              
              // Date formatting
              String s = (currMessage.getCreationTime().toString()).replace("Z", "+00:00");
              s = s.substring(0, 22) + s.substring(23);

              masterList[i + buff][0] = s;
              masterList[i + buff][1] = "m";
              masterList[i + buff][2] = (userStore.getUser(currMessage.getAuthorId())).getName();
              masterList[i + buff][3] = (convoStore.getConvoWithID(currMessage.getConversationId())).getTitle();
              masterList[i + buff][4] = currMessage.getContent();
          }



          // SORT 
          //Arrays.sort(masterList
          //   , new java.util.Comparator<String[]>() {
          //      public int compare(String[] a, String[] b) {

          //         // SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss.SSSZ");

          //         // Date date1 = dateFormat.parse(a[0]);
          //         // Date date2 = dateFormat.parse(b[0]);

          //         // if (date1.before(date2))
          //         //   return -1;
          //         // else
          //           return 1;
          //     }
          // }
            /*
              Date date = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(s);
            */
        //);

      %>

      <!-- USER REGISTERED -->
      <h3>New Users</h3>

      <%
        ListIterator<User> itrU = users.listIterator(users.size());
        // example: Sat Mar 10 09:39:36 PST 2018
        SimpleDateFormat formatter = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
        
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
            Date myDate = Date.from(currUser.getCreationTime());
            String formattedDate = formatter.format(myDate);
        %>
          <li>
            <strong> <%= formattedDate %>: </strong> 
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
          Date myDate = Date.from(currConvo.getCreationTime());
          String formattedDate = formatter.format(myDate);
      %>
        <li>
          <strong> <%= formattedDate %>: </strong> 
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
      
      <%
      ListIterator<Message> itrM = messages.listIterator(messages.size());


      // empty?
      if(messages == null || messages.isEmpty()){
      %>
        <p>No New Conversations.</p>
      <%
      }
      else{ // not empty? make a list
      %>
        <ul class="mdl-list">
      <%
        while(itrM.hasPrevious()){
          Message currMessage = itrM.previous();
          Date myDate = Date.from(currMessage.getCreationTime());
          String formattedDate = formatter.format(myDate);
      %>
        <li>
          <strong> <%= formattedDate %>: </strong> 
          <%= (userStore.getUser(currMessage.getAuthorId())).getName() %> sent a message in 
          <a href="/chat/<%= (convoStore.getConvoWithID(currMessage.getConversationId())).getTitle() %>"> <%= (convoStore.getConvoWithID(currMessage.getConversationId())).getTitle() %></a>
          : "<%= currMessage.getContent() %>"
        </li> 
      <%
        }
      %>
        </ul>
      <%
      }
      %>

    </div>

    <div style="background-color:Silver">
      <h3>Merged</h3>

      <% 
          SimpleDateFormat sdf = new SimpleDateFormat("EEE MMM dd HH:mm:ss z yyyy");
          for (int x = 0; x < totalSize; x++) {

                Date rawDate = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ").parse(masterList[x][0]);
                String formattedDate = sdf.format(rawDate);

                if (masterList[x][1] == "c") {
                %>
                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] %> created a new conversation:
                   <a href="/chat/<%= masterList[x][3] %>"> <%= masterList[x][3] %></a>.
                  </li> 
                <%
              } else if (masterList[x][1] == "u") {
               %>
                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] %> joined!
                  </li> 
                <%
              } else if (masterList[x][1] == "m") {
                %>
                  <li>
                   <strong> <%= formattedDate %>: </strong>
                   <%= masterList[x][2] %> sent a message in
                   <a href="/chat/<%= masterList[x][3] %>"> <%= masterList[x][3] %></a>: "<%= masterList[x][4] %>""
                  </li> 
                <%
              }
          }
      %>
    </div>

  </div>
</body>
</html>

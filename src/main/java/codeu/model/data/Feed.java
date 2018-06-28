// Copyright 2017 Google Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package codeu.model.data;

import java.time.Instant;
import java.util.UUID;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;

/** Class representing a registered user. */
public class Feed {

  private ArrayList<String[]> myFeed;
  /**
   * Constructs a new Feed.
   */
  public Feed() {
    myFeed = new ArrayList<String[]>();
  }

  /** Document new registered user. */
  public void addNewUser(String date, String username) {
    myFeed.add(new String[3]);
    myFeed.get(myFeed.size() - 1)[0] = "u";
    myFeed.get(myFeed.size() - 1)[1] = date;
    myFeed.get(myFeed.size() - 1)[2] = username;
  }

  /** Document new conversation. */
  public void addNewConversation(String date, String username, String conversation) {
    myFeed.add(new String[4]);
    myFeed.get(myFeed.size() - 1)[0] = "c";
    myFeed.get(myFeed.size() - 1)[1] = date;
    myFeed.get(myFeed.size() - 1)[2] = username;
    myFeed.get(myFeed.size() - 1)[3] = conversation;
  }

  /** Document new message. */
  public void addNewMessage(String date, String username, String conversation, String message) {
    myFeed.add(new String[5]);
    myFeed.get(myFeed.size() - 1)[0] = "m";
    myFeed.get(myFeed.size() - 1)[1] = date;
    myFeed.get(myFeed.size() - 1)[2] = username;
    myFeed.get(myFeed.size() - 1)[3] = conversation;
    myFeed.get(myFeed.size() - 1)[4] = message;

  }

  /** Access event type. */
  public String getEventType(int index) {
    return myFeed.get(index)[0];
  }

  /** Access date of the event. */
  public String getEventDate(int index) {
    return myFeed.get(index)[1];
  }

  /** Access username of the user causing the event. */
  public String getUsername(int index) {
    return myFeed.get(index)[2];
  }

  /** Access conversation title. */
  public String getConversationTitle(int index) {
    if (myFeed.get(index)[0] == "c" || myFeed.get(index)[0] == "m")
      return myFeed.get(index)[3];
    else
      return "NULL ACCESS";
  }

  /** Access message content. */
  public String getMessageContent(int index) {
    if (myFeed.get(index)[0] == "m")
      return myFeed.get(index)[4];
    else
      return "NULL ACCESS";
  }

  /** Sort feed by time **/
  public void sortByTime() {
    Collections.sort(myFeed, new java.util.Comparator<String[]>() {
           public int compare(String[] a, String[] b) {

              Instant ins1 = Instant.parse(a[1]);
              Date date1 = Date.from(ins1);

              Instant ins2 = Instant.parse(b[1]);
              Date date2 = Date.from(ins2);

               if (date2.before(date1))
                  return -1;
               else
                 return 1;
           }
       }
   );
  }
}
